import { useEffect, useMemo, useState } from "react";
import { Link } from "react-router-dom";
import Loading from "../components/Loading.jsx";
import ErrorMessage from "../components/ErrorMessage.jsx";
import { api } from "../services/api.js";
import "../styles/Tables.css";

const inr = new Intl.NumberFormat("en-IN", { style: "currency", currency: "INR", maximumFractionDigits: 0 });

const SAMPLE = [
  { transactionId: 501, accountId: 1, accountNumber: "SB-2201", transactionType: "DEPOSIT", amount: 12000, transactionDate: "2026-09-22", status: "SUCCESS" },
  { transactionId: 500, accountId: 2, accountNumber: "SB-1187", transactionType: "WITHDRAWAL", amount: 4500, transactionDate: "2026-09-22", status: "SUCCESS" },
  { transactionId: 499, accountId: 3, accountNumber: "CA-3390", transactionType: "TRANSFER", amount: 25000, transactionDate: "2026-09-21", status: "SUCCESS" },
  { transactionId: 498, accountId: 1, accountNumber: "SB-2201", transactionType: "DEPOSIT", amount: 8000, transactionDate: "2026-09-20", status: "SUCCESS" },
  { transactionId: 497, accountId: 2, accountNumber: "SB-1187", transactionType: "WITHDRAWAL", amount: 2000, transactionDate: "2026-09-19", status: "FAILED" },
];

export default function Transactions() {
  const [txns, setTxns] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [typeFilter, setTypeFilter] = useState("ALL");
  const [query, setQuery] = useState("");

  const load = () => {
    setLoading(true);
    setError("");
    api
      .getTransactions()
      .then(setTxns)
      .catch(() => setTxns(SAMPLE))
      .finally(() => setLoading(false));
  };

  useEffect(load, []);

  const filtered = useMemo(() => {
    if (!txns) return [];
    return txns.filter((t) => {
      const matchesType = typeFilter === "ALL" || t.transactionType === typeFilter;
      const q = query.trim().toLowerCase();
      const matchesQuery = !q || t.accountNumber.toLowerCase().includes(q);
      return matchesType && matchesQuery;
    });
  }, [txns, typeFilter, query]);

  if (loading) return <Loading label="Turning the ledger pages" />;
  if (error) return <ErrorMessage message={error} onRetry={load} />;

  return (
    <div>
      <div className="page-head">
        <div>
          <h1>Transactions</h1>
          <p className="page-sub">Deposits, withdrawals and transfers across every account.</p>
        </div>
        <span className="page-folio">Fol. 05</span>
      </div>

      <div className="ledger-panel">
        <div className="table-toolbar">
          <div className="table-toolbar__search">
            <input
              type="search"
              placeholder="Search account number"
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              aria-label="Search transactions"
            />
          </div>
          <div className="table-toolbar__filters">
            <select value={typeFilter} onChange={(e) => setTypeFilter(e.target.value)} aria-label="Filter by type">
              <option value="ALL">All types</option>
              <option value="DEPOSIT">Deposit</option>
              <option value="WITHDRAWAL">Withdrawal</option>
              <option value="TRANSFER">Transfer</option>
            </select>
          </div>
        </div>

        <div className="ledger-panel__body" style={{ padding: 0 }}>
          {filtered.length === 0 ? (
            <div className="table-empty">No transactions match your filters.</div>
          ) : (
            <table className="ledger-table">
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Account</th>
                  <th>Type</th>
                  <th>Status</th>
                  <th className="is-numeric">Amount</th>
                </tr>
              </thead>
              <tbody>
                {filtered.map((t) => (
                  <tr key={t.transactionId}>
                    <td className="folio">{t.transactionDate}</td>
                    <td>
                      <Link to={`/accounts/${t.accountId}`} className="dash-panel-link">
                        {t.accountNumber}
                      </Link>
                    </td>
                    <td>{t.transactionType}</td>
                    <td>
                      <span
                        className={
                          "status-tag " +
                          (t.status === "SUCCESS" ? "status-tag--success" : "status-tag--failed")
                        }
                      >
                        {t.status}
                      </span>
                    </td>
                    <td
                      className={
                        "is-numeric amount figure " +
                        (t.transactionType === "WITHDRAWAL" ? "amount--debit" : "amount--credit")
                      }
                    >
                      {t.transactionType === "WITHDRAWAL" ? "−" : "+"}
                      {inr.format(t.amount)}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </div>
    </div>
  );
}

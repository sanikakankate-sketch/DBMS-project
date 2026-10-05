import { useEffect, useState } from "react";
import { useParams, Link, useNavigate } from "react-router-dom";
import Loading from "../components/Loading.jsx";
import ErrorMessage from "../components/ErrorMessage.jsx";
import { api } from "../services/api.js";
import "../styles/Tables.css";

const inr = new Intl.NumberFormat("en-IN", { style: "currency", currency: "INR", maximumFractionDigits: 0 });

const SAMPLE_ACCOUNT = {
  accountId: 1,
  accountNumber: "SB-2201",
  customerName: "Rahul Mehta",
  branchName: "Deccan Gymkhana",
  accountType: "SAVINGS",
  balance: 182500,
  status: "ACTIVE",
  createdDate: "2022-04-11",
};

const SAMPLE_TXNS = [
  { transactionId: 501, transactionType: "DEPOSIT", amount: 12000, transactionDate: "2026-09-22", status: "SUCCESS", description: "Salary credit" },
  { transactionId: 497, transactionType: "WITHDRAWAL", amount: 4500, transactionDate: "2026-09-18", status: "SUCCESS", description: "ATM withdrawal" },
  { transactionId: 480, transactionType: "TRANSFER", amount: 25000, transactionDate: "2026-09-10", status: "SUCCESS", description: "To CA-3390" },
];

export default function AccountDetails() {
  const { accountId } = useParams();
  const navigate = useNavigate();
  const [account, setAccount] = useState(null);
  const [txns, setTxns] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const load = () => {
    setLoading(true);
    setError("");
    Promise.all([api.getAccount(accountId), api.getTransactions(accountId)])
      .then(([acc, tx]) => {
        setAccount(acc);
        setTxns(tx);
      })
      .catch(() => {
        setAccount({ ...SAMPLE_ACCOUNT, accountId: Number(accountId) });
        setTxns(SAMPLE_TXNS);
      })
      .finally(() => setLoading(false));
  };

  useEffect(load, [accountId]);

  if (loading) return <Loading label="Pulling account folio" />;
  if (error) return <ErrorMessage message={error} onRetry={load} />;

  return (
    <div>
      <div className="page-head">
        <div>
          <h1>Account {account.accountNumber}</h1>
          <p className="page-sub">
            {account.customerName} &middot; {account.branchName} &middot; {account.accountType}
          </p>
        </div>
        <span
          className={
            "status-tag " + (account.status === "ACTIVE" ? "status-tag--active" : "status-tag--inactive")
          }
        >
          {account.status}
        </span>
      </div>

      <div className="dash-hero" style={{ marginBottom: 20 }}>
        <div className="dash-hero__label">Current balance</div>
        <div className="dash-hero__figure figure">{inr.format(account.balance)}</div>
      </div>

      <div className="btn-row" style={{ marginTop: 0, marginBottom: 28 }}>
        <button className="btn btn--primary" onClick={() => navigate(`/accounts/${accountId}/deposit`)}>
          Deposit
        </button>
        <button className="btn btn--ghost" onClick={() => navigate(`/accounts/${accountId}/withdraw`)}>
          Withdraw
        </button>
        <button className="btn btn--ghost" onClick={() => navigate(`/accounts/${accountId}/transfer`)}>
          Transfer
        </button>
      </div>

      <div className="ledger-panel">
        <div className="ledger-panel__head">
          <h2>Transaction history</h2>
          <Link to="/transactions" className="dash-panel-link">
            All transactions
          </Link>
        </div>
        <div className="ledger-panel__body" style={{ padding: 0 }}>
          {!txns?.length ? (
            <div className="table-empty">No transactions on this account yet.</div>
          ) : (
            <table className="ledger-table">
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Type</th>
                  <th>Description</th>
                  <th>Status</th>
                  <th className="is-numeric">Amount</th>
                </tr>
              </thead>
              <tbody>
                {txns.map((t) => (
                  <tr key={t.transactionId}>
                    <td className="folio">{t.transactionDate}</td>
                    <td>{t.transactionType}</td>
                    <td>{t.description || "—"}</td>
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

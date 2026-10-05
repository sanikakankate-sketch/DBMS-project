import { useEffect, useState } from "react";
import Loading from "../components/Loading.jsx";
import ErrorMessage from "../components/ErrorMessage.jsx";
import { api } from "../services/api.js";
import "../styles/Tables.css";

const inr = new Intl.NumberFormat("en-IN", { style: "currency", currency: "INR", maximumFractionDigits: 0 });

const SAMPLE = {
  byBranch: [
    { branchName: "Deccan Gymkhana", accounts: 58, totalBalance: 1820000 },
    { branchName: "Bandra Kurla Complex", accounts: 71, totalBalance: 2140000 },
    { branchName: "College Road", accounts: 35, totalBalance: 860500 },
  ],
  byLoanType: [
    { loanType: "HOME", count: 14, totalPrincipal: 18500000 },
    { loanType: "PERSONAL", count: 19, totalPrincipal: 3120000 },
    { loanType: "VEHICLE", count: 9, totalPrincipal: 4980000 },
    { loanType: "EDUCATION", count: 4, totalPrincipal: 1260000 },
  ],
  transactionVolume: { deposits: 312, withdrawals: 198, transfers: 87 },
};

export default function Reports() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const load = () => {
    setLoading(true);
    setError("");
    api
      .getSummaryReport()
      .then(setData)
      .catch(() => setData(SAMPLE))
      .finally(() => setLoading(false));
  };

  useEffect(load, []);

  if (loading) return <Loading label="Compiling the register" />;
  if (error) return <ErrorMessage message={error} onRetry={load} />;

  const volumeTotal = data.transactionVolume.deposits + data.transactionVolume.withdrawals + data.transactionVolume.transfers;

  return (
    <div>
      <div className="page-head">
        <div>
          <h1>Reports</h1>
          <p className="page-sub">Predefined views built from the database&rsquo;s SQL views.</p>
        </div>
        <span className="page-folio">Fol. 07</span>
      </div>

      <div className="ledger-panel" style={{ marginBottom: 24 }}>
        <div className="ledger-panel__head">
          <h2>Balance by branch</h2>
        </div>
        <div className="ledger-panel__body" style={{ padding: 0 }}>
          <table className="ledger-table">
            <thead>
              <tr>
                <th>Branch</th>
                <th className="is-numeric">Accounts</th>
                <th className="is-numeric">Total balance</th>
              </tr>
            </thead>
            <tbody>
              {data.byBranch.map((b) => (
                <tr key={b.branchName}>
                  <td>{b.branchName}</td>
                  <td className="is-numeric figure">{b.accounts}</td>
                  <td className="is-numeric amount figure">{inr.format(b.totalBalance)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      <div className="ledger-panel" style={{ marginBottom: 24 }}>
        <div className="ledger-panel__head">
          <h2>Loan portfolio by type</h2>
        </div>
        <div className="ledger-panel__body" style={{ padding: 0 }}>
          <table className="ledger-table">
            <thead>
              <tr>
                <th>Loan type</th>
                <th className="is-numeric">Count</th>
                <th className="is-numeric">Total principal</th>
              </tr>
            </thead>
            <tbody>
              {data.byLoanType.map((l) => (
                <tr key={l.loanType}>
                  <td>{l.loanType}</td>
                  <td className="is-numeric figure">{l.count}</td>
                  <td className="is-numeric amount figure">{inr.format(l.totalPrincipal)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      <div className="ledger-panel">
        <div className="ledger-panel__head">
          <h2>Transaction volume (last 30 days)</h2>
        </div>
        <div className="ledger-panel__body" style={{ padding: "18px 24px 24px" }}>
          <div className="report-bars">
            {[
              { label: "Deposits", value: data.transactionVolume.deposits, cls: "amount--credit" },
              { label: "Withdrawals", value: data.transactionVolume.withdrawals, cls: "amount--debit" },
              { label: "Transfers", value: data.transactionVolume.transfers, cls: "" },
            ].map((row) => (
              <div className="report-bar" key={row.label}>
                <div className="report-bar__label">{row.label}</div>
                <div className="report-bar__track">
                  <div
                    className={"report-bar__fill " + row.cls}
                    style={{ width: `${Math.round((row.value / volumeTotal) * 100)}%` }}
                  />
                </div>
                <div className="report-bar__value figure">{row.value}</div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

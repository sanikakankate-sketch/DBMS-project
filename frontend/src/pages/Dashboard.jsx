import { useEffect, useMemo, useState } from "react";
import { Link } from "react-router-dom";
import Loading from "../components/Loading.jsx";
import ErrorMessage from "../components/ErrorMessage.jsx";
import { api } from "../services/api.js";
import "../styles/Dashboard.css";

const inr = new Intl.NumberFormat("en-IN", {
  style: "currency",
  currency: "INR",
  maximumFractionDigits: 0,
});

/** Counts a number up from 0 to `value` once, on mount. The single
 * orchestrated motion moment for this whole app — nothing else animates
 * on load. */
function useCountUp(value, durationMs = 900) {
  const [display, setDisplay] = useState(0);

  useEffect(() => {
    if (!value) return;
    let start;
    let frame;
    const step = (ts) => {
      if (!start) start = ts;
      const progress = Math.min((ts - start) / durationMs, 1);
      const eased = 1 - Math.pow(1 - progress, 3);
      setDisplay(Math.round(value * eased));
      if (progress < 1) frame = requestAnimationFrame(step);
    };
    frame = requestAnimationFrame(step);
    return () => cancelAnimationFrame(frame);
  }, [value, durationMs]);

  return display;
}

export default function Dashboard() {
  const [summary, setSummary] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const load = () => {
    setLoading(true);
    setError("");
    api
      .getSummaryReport()
      .then(setSummary)
      .catch(() => {
        // Backend not wired yet — fall back to representative sample data
        // so Anjali can build/demo the UI independently of Sanika.
        setSummary({
          totalBalance: 4820500,
          totalCustomers: 128,
          totalAccounts: 164,
          activeLoans: 37,
          recentTransactions: [
            { id: 501, account: "SB-2201", type: "DEPOSIT", amount: 12000, date: "2026-09-22" },
            { id: 500, account: "SB-1187", type: "WITHDRAWAL", amount: 4500, date: "2026-09-22" },
            { id: 499, account: "CA-3390", type: "TRANSFER", amount: 25000, date: "2026-09-21" },
            { id: 498, account: "SB-2201", type: "DEPOSIT", amount: 8000, date: "2026-09-20" },
          ],
        });
      })
      .finally(() => setLoading(false));
  };

  useEffect(load, []);

  const animatedBalance = useCountUp(summary?.totalBalance ?? 0);

  const stats = useMemo(
    () => [
      { label: "Customers", value: summary?.totalCustomers, to: "/customers" },
      { label: "Accounts", value: summary?.totalAccounts, to: "/accounts" },
      { label: "Active loans", value: summary?.activeLoans, to: "/loans" },
    ],
    [summary]
  );

  if (loading) return <Loading label="Totaling the ledger" />;
  if (error) return <ErrorMessage message={error} onRetry={load} />;

  return (
    <div>
      <div className="page-head">
        <div>
          <h1>Dashboard</h1>
          <p className="page-sub">Today, {new Date().toLocaleDateString("en-IN", { day: "numeric", month: "long", year: "numeric" })}</p>
        </div>
        <span className="page-folio">Fol. 01</span>
      </div>

      <div className="dash-hero">
        <div className="dash-hero__label">Total balance across all accounts</div>
        <div className="dash-hero__figure figure">{inr.format(animatedBalance)}</div>
      </div>

      <div className="dash-stats">
        {stats.map((s) => (
          <Link to={s.to} className="dash-stat" key={s.label}>
            <div className="dash-stat__value figure">{s.value ?? "—"}</div>
            <div className="dash-stat__label">{s.label}</div>
          </Link>
        ))}
      </div>

      <div className="ledger-panel" style={{ marginTop: 32 }}>
        <div className="ledger-panel__head">
          <h2>Recent transactions</h2>
          <Link to="/transactions" className="dash-panel-link">
            View all
          </Link>
        </div>
        <div className="ledger-panel__body">
          <table className="ledger-table">
            <thead>
              <tr>
                <th>Account</th>
                <th>Type</th>
                <th>Date</th>
                <th className="is-numeric">Amount</th>
              </tr>
            </thead>
            <tbody>
              {summary?.recentTransactions?.map((t) => (
                <tr key={t.id}>
                  <td className="folio">{t.account}</td>
                  <td>{t.type}</td>
                  <td>{t.date}</td>
                  <td
                    className={
                      "is-numeric amount figure " +
                      (t.type === "WITHDRAWAL" ? "amount--debit" : "amount--credit")
                    }
                  >
                    {t.type === "WITHDRAWAL" ? "−" : "+"}
                    {inr.format(t.amount)}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

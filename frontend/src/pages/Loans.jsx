import { useEffect, useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";
import Loading from "../components/Loading.jsx";
import ErrorMessage from "../components/ErrorMessage.jsx";
import { api } from "../services/api.js";
import "../styles/Tables.css";

const inr = new Intl.NumberFormat("en-IN", { style: "currency", currency: "INR", maximumFractionDigits: 0 });

const SAMPLE = [
  { loanId: 1, customerName: "Rahul Mehta", loanType: "HOME", loanAmount: 2500000, interestRate: 8.4, startDate: "2024-01-15", loanStatus: "ACTIVE" },
  { loanId: 2, customerName: "Sneha Kulkarni", loanType: "PERSONAL", loanAmount: 300000, interestRate: 11.5, startDate: "2025-06-02", loanStatus: "ACTIVE" },
  { loanId: 3, customerName: "Arjun Deshpande", loanType: "VEHICLE", loanAmount: 850000, interestRate: 9.2, startDate: "2023-09-20", loanStatus: "CLOSED" },
  { loanId: 4, customerName: "Sneha Kulkarni", loanType: "PERSONAL", loanAmount: 150000, interestRate: 12.0, startDate: "2026-02-10", loanStatus: "OVERDUE" },
];

export default function Loans() {
  const navigate = useNavigate();
  const [loans, setLoans] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [statusFilter, setStatusFilter] = useState("ALL");
  const [showForm, setShowForm] = useState(false);
  const [form, setForm] = useState({ customerId: "", loanType: "PERSONAL", loanAmount: "", interestRate: "" });
  const [saving, setSaving] = useState(false);

  const load = () => {
    setLoading(true);
    setError("");
    api
      .getLoans()
      .then(setLoans)
      .catch(() => setLoans(SAMPLE))
      .finally(() => setLoading(false));
  };

  useEffect(load, []);

  const filtered = useMemo(() => {
    if (!loans) return [];
    if (statusFilter === "ALL") return loans;
    return loans.filter((l) => l.loanStatus === statusFilter);
  }, [loans, statusFilter]);

  function handleChange(e) {
    setForm({ ...form, [e.target.name]: e.target.value });
  }

  async function handleSubmit(e) {
    e.preventDefault();
    if (!form.customerId || !form.loanAmount || !form.interestRate) return;
    setSaving(true);
    try {
      const created = await api.createLoan(form);
      setLoans((prev) => [created, ...(prev || [])]);
    } catch {
      setLoans((prev) => [
        {
          loanId: Date.now(),
          customerName: `Customer #${form.customerId}`,
          loanType: form.loanType,
          loanAmount: Number(form.loanAmount),
          interestRate: Number(form.interestRate),
          startDate: new Date().toISOString().slice(0, 10),
          loanStatus: "ACTIVE",
        },
        ...(prev || []),
      ]);
    } finally {
      setForm({ customerId: "", loanType: "PERSONAL", loanAmount: "", interestRate: "" });
      setShowForm(false);
      setSaving(false);
    }
  }

  if (loading) return <Loading label="Opening the loan book" />;
  if (error) return <ErrorMessage message={error} onRetry={load} />;

  return (
    <div>
      <div className="page-head">
        <div>
          <h1>Loans</h1>
          <p className="page-sub">Every loan issued to a customer, with its repayment status.</p>
        </div>
        <span className="page-folio">Fol. 06</span>
      </div>

      <div className="ledger-panel">
        <div className="table-toolbar">
          <div className="table-toolbar__filters">
            <select value={statusFilter} onChange={(e) => setStatusFilter(e.target.value)} aria-label="Filter by status">
              <option value="ALL">All statuses</option>
              <option value="ACTIVE">Active</option>
              <option value="OVERDUE">Overdue</option>
              <option value="CLOSED">Closed</option>
            </select>
          </div>
          <div className="table-toolbar__spacer" />
          <button className="btn btn--brass" onClick={() => setShowForm((v) => !v)}>
            {showForm ? "Close" : "New loan"}
          </button>
        </div>

        {showForm && (
          <div className="inline-panel">
            <h3>Issue a new loan</h3>
            <form onSubmit={handleSubmit}>
              <div className="form-grid">
                <div className="field">
                  <label htmlFor="customerId">Customer ID</label>
                  <input id="customerId" name="customerId" value={form.customerId} onChange={handleChange} />
                </div>
                <div className="field">
                  <label htmlFor="loanType">Loan type</label>
                  <select id="loanType" name="loanType" value={form.loanType} onChange={handleChange}>
                    <option value="PERSONAL">Personal</option>
                    <option value="HOME">Home</option>
                    <option value="VEHICLE">Vehicle</option>
                    <option value="EDUCATION">Education</option>
                  </select>
                </div>
                <div className="field">
                  <label htmlFor="loanAmount">Loan amount (₹)</label>
                  <input id="loanAmount" name="loanAmount" type="number" value={form.loanAmount} onChange={handleChange} />
                </div>
                <div className="field">
                  <label htmlFor="interestRate">Interest rate (%)</label>
                  <input
                    id="interestRate"
                    name="interestRate"
                    type="number"
                    step="0.1"
                    value={form.interestRate}
                    onChange={handleChange}
                  />
                </div>
              </div>
              <div className="btn-row">
                <button className="btn btn--primary" type="submit" disabled={saving}>
                  {saving ? "Issuing…" : "Issue loan"}
                </button>
                <button type="button" className="btn btn--ghost" onClick={() => setShowForm(false)}>
                  Cancel
                </button>
              </div>
            </form>
          </div>
        )}

        <div className="ledger-panel__body" style={{ padding: 0 }}>
          {filtered.length === 0 ? (
            <div className="table-empty">No loans match this filter.</div>
          ) : (
            <table className="ledger-table">
              <thead>
                <tr>
                  <th>Customer</th>
                  <th>Type</th>
                  <th>Started</th>
                  <th className="is-numeric">Principal</th>
                  <th className="is-numeric">Rate</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                {filtered.map((l) => (
                  <tr key={l.loanId} onClick={() => navigate(`/loans/${l.loanId}`)}>
                    <td>
                      <span className="folio">L-{String(l.loanId).padStart(4, "0")}</span>
                      <div>{l.customerName}</div>
                    </td>
                    <td>{l.loanType}</td>
                    <td>{l.startDate}</td>
                    <td className="is-numeric amount figure">{inr.format(l.loanAmount)}</td>
                    <td className="is-numeric figure">{l.interestRate}%</td>
                    <td>
                      <span
                        className={
                          "status-tag " +
                          (l.loanStatus === "ACTIVE"
                            ? "status-tag--active"
                            : l.loanStatus === "OVERDUE"
                            ? "status-tag--overdue"
                            : "status-tag--closed-good")
                        }
                      >
                        {l.loanStatus}
                      </span>
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

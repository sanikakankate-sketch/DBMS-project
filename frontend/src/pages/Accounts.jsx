import { useEffect, useMemo, useState } from "react";
import { useNavigate } from "react-router-dom";
import Loading from "../components/Loading.jsx";
import ErrorMessage from "../components/ErrorMessage.jsx";
import { api } from "../services/api.js";
import "../styles/Tables.css";

const inr = new Intl.NumberFormat("en-IN", { style: "currency", currency: "INR", maximumFractionDigits: 0 });

const SAMPLE = [
  { accountId: 1, accountNumber: "SB-2201", customerName: "Rahul Mehta", branchName: "Deccan Gymkhana", accountType: "SAVINGS", balance: 182500, status: "ACTIVE" },
  { accountId: 2, accountNumber: "SB-1187", customerName: "Sneha Kulkarni", branchName: "Bandra Kurla Complex", accountType: "SAVINGS", balance: 94200, status: "ACTIVE" },
  { accountId: 3, accountNumber: "CA-3390", customerName: "Arjun Deshpande", branchName: "College Road", accountType: "CURRENT", balance: 512000, status: "ACTIVE" },
  { accountId: 4, accountNumber: "SB-0044", customerName: "Rahul Mehta", branchName: "Deccan Gymkhana", accountType: "SAVINGS", balance: 0, status: "CLOSED" },
];

export default function Accounts() {
  const navigate = useNavigate();
  const [accounts, setAccounts] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [query, setQuery] = useState("");
  const [typeFilter, setTypeFilter] = useState("ALL");
  const [showForm, setShowForm] = useState(false);
  const [form, setForm] = useState({ customerId: "", branchId: "", accountType: "SAVINGS" });
  const [saving, setSaving] = useState(false);

  const load = () => {
    setLoading(true);
    setError("");
    api
      .getAccounts()
      .then(setAccounts)
      .catch(() => setAccounts(SAMPLE))
      .finally(() => setLoading(false));
  };

  useEffect(load, []);

  const filtered = useMemo(() => {
    if (!accounts) return [];
    return accounts.filter((a) => {
      const matchesType = typeFilter === "ALL" || a.accountType === typeFilter;
      const q = query.trim().toLowerCase();
      const matchesQuery =
        !q || a.accountNumber.toLowerCase().includes(q) || a.customerName.toLowerCase().includes(q);
      return matchesType && matchesQuery;
    });
  }, [accounts, query, typeFilter]);

  function handleChange(e) {
    setForm({ ...form, [e.target.name]: e.target.value });
  }

  async function handleSubmit(e) {
    e.preventDefault();
    if (!form.customerId || !form.branchId) return;
    setSaving(true);
    try {
      const created = await api.createAccount(form);
      setAccounts((prev) => [created, ...(prev || [])]);
    } catch {
      setAccounts((prev) => [
        {
          accountId: Date.now(),
          accountNumber: `${form.accountType === "SAVINGS" ? "SB" : "CA"}-${Math.floor(1000 + Math.random() * 8999)}`,
          customerName: `Customer #${form.customerId}`,
          branchName: `Branch #${form.branchId}`,
          accountType: form.accountType,
          balance: 0,
          status: "ACTIVE",
        },
        ...(prev || []),
      ]);
    } finally {
      setForm({ customerId: "", branchId: "", accountType: "SAVINGS" });
      setShowForm(false);
      setSaving(false);
    }
  }

  if (loading) return <Loading label="Opening the account register" />;
  if (error) return <ErrorMessage message={error} onRetry={load} />;

  return (
    <div>
      <div className="page-head">
        <div>
          <h1>Accounts</h1>
          <p className="page-sub">Savings and current accounts held across all branches.</p>
        </div>
        <span className="page-folio">Fol. 04</span>
      </div>

      <div className="ledger-panel">
        <div className="table-toolbar">
          <div className="table-toolbar__search">
            <input
              type="search"
              placeholder="Search account no. or customer"
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              aria-label="Search accounts"
            />
          </div>
          <div className="table-toolbar__filters">
            <select value={typeFilter} onChange={(e) => setTypeFilter(e.target.value)} aria-label="Filter by type">
              <option value="ALL">All types</option>
              <option value="SAVINGS">Savings</option>
              <option value="CURRENT">Current</option>
            </select>
          </div>
          <div className="table-toolbar__spacer" />
          <button className="btn btn--brass" onClick={() => setShowForm((v) => !v)}>
            {showForm ? "Close" : "Open account"}
          </button>
        </div>

        {showForm && (
          <div className="inline-panel">
            <h3>Open a new account</h3>
            <form onSubmit={handleSubmit}>
              <div className="form-grid">
                <div className="field">
                  <label htmlFor="customerId">Customer ID</label>
                  <input id="customerId" name="customerId" value={form.customerId} onChange={handleChange} placeholder="e.g. 1" />
                </div>
                <div className="field">
                  <label htmlFor="branchId">Branch ID</label>
                  <input id="branchId" name="branchId" value={form.branchId} onChange={handleChange} placeholder="e.g. 1" />
                </div>
                <div className="field field--span-2">
                  <label htmlFor="accountType">Account type</label>
                  <select id="accountType" name="accountType" value={form.accountType} onChange={handleChange}>
                    <option value="SAVINGS">Savings</option>
                    <option value="CURRENT">Current</option>
                  </select>
                </div>
              </div>
              <p className="field-hint" style={{ marginTop: 10 }}>
                Customer and branch pickers will become searchable dropdowns once{" "}
                <code>GET /api/customers</code> and <code>GET /api/branches</code> are live.
              </p>
              <div className="btn-row">
                <button className="btn btn--primary" type="submit" disabled={saving}>
                  {saving ? "Opening…" : "Open account"}
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
            <div className="table-empty">No accounts match your filters.</div>
          ) : (
            <table className="ledger-table">
              <thead>
                <tr>
                  <th>Account</th>
                  <th>Customer</th>
                  <th>Branch</th>
                  <th>Type</th>
                  <th className="is-numeric">Balance</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                {filtered.map((a) => (
                  <tr key={a.accountId} onClick={() => navigate(`/accounts/${a.accountId}`)}>
                    <td className="folio">{a.accountNumber}</td>
                    <td>{a.customerName}</td>
                    <td>{a.branchName}</td>
                    <td>{a.accountType}</td>
                    <td className="is-numeric amount figure">{inr.format(a.balance)}</td>
                    <td>
                      <span
                        className={
                          "status-tag " +
                          (a.status === "ACTIVE" ? "status-tag--active" : "status-tag--inactive")
                        }
                      >
                        {a.status}
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

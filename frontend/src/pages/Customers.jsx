import { useEffect, useMemo, useState } from "react";
import Loading from "../components/Loading.jsx";
import ErrorMessage from "../components/ErrorMessage.jsx";
import { api } from "../services/api.js";
import "../styles/Tables.css";

const SAMPLE = [
  { customerId: 1, name: "Rahul Mehta", email: "rahul.mehta@mail.com", phone: "9821004455", address: "Pune, MH", dateOfBirth: "1994-03-12" },
  { customerId: 2, name: "Sneha Kulkarni", email: "sneha.k@mail.com", phone: "9822011234", address: "Mumbai, MH", dateOfBirth: "1990-07-02" },
  { customerId: 3, name: "Arjun Deshpande", email: "arjun.d@mail.com", phone: "9890056677", address: "Nashik, MH", dateOfBirth: "1988-11-25" },
];

function calcAge(dob) {
  if (!dob) return "—";
  const diff = Date.now() - new Date(dob).getTime();
  return Math.floor(diff / (365.25 * 24 * 3600 * 1000));
}

export default function Customers() {
  const [customers, setCustomers] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [query, setQuery] = useState("");
  const [showForm, setShowForm] = useState(false);
  const [form, setForm] = useState({ name: "", email: "", phone: "", address: "", dateOfBirth: "" });
  const [formError, setFormError] = useState("");
  const [saving, setSaving] = useState(false);

  const load = () => {
    setLoading(true);
    setError("");
    api
      .getCustomers()
      .then(setCustomers)
      .catch(() => setCustomers(SAMPLE))
      .finally(() => setLoading(false));
  };

  useEffect(load, []);

  const filtered = useMemo(() => {
    if (!customers) return [];
    const q = query.trim().toLowerCase();
    if (!q) return customers;
    return customers.filter(
      (c) => c.name.toLowerCase().includes(q) || c.email.toLowerCase().includes(q) || c.phone.includes(q)
    );
  }, [customers, query]);

  function handleChange(e) {
    setForm({ ...form, [e.target.name]: e.target.value });
  }

  async function handleSubmit(e) {
    e.preventDefault();
    setFormError("");
    if (!form.name || !form.email || !form.phone) {
      setFormError("Name, email and phone are required.");
      return;
    }
    setSaving(true);
    try {
      const created = await api.createCustomer(form);
      setCustomers((prev) => [created, ...(prev || [])]);
      setForm({ name: "", email: "", phone: "", address: "", dateOfBirth: "" });
      setShowForm(false);
    } catch (err) {
      // Backend not wired yet — add locally so the UI stays usable during dev.
      setCustomers((prev) => [{ customerId: Date.now(), ...form }, ...(prev || [])]);
      setForm({ name: "", email: "", phone: "", address: "", dateOfBirth: "" });
      setShowForm(false);
    } finally {
      setSaving(false);
    }
  }

  if (loading) return <Loading label="Opening the customer ledger" />;
  if (error) return <ErrorMessage message={error} onRetry={load} />;

  return (
    <div>
      <div className="page-head">
        <div>
          <h1>Customers</h1>
          <p className="page-sub">Everyone holding an account or loan with the bank.</p>
        </div>
        <span className="page-folio">Fol. 02</span>
      </div>

      <div className="ledger-panel">
        <div className="table-toolbar">
          <div className="table-toolbar__search">
            <input
              type="search"
              placeholder="Search by name, email or phone"
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              aria-label="Search customers"
            />
          </div>
          <div className="table-toolbar__spacer" />
          <button className="btn btn--brass" onClick={() => setShowForm((v) => !v)}>
            {showForm ? "Close" : "New customer"}
          </button>
        </div>

        {showForm && (
          <div className="inline-panel">
            <h3>Add a customer</h3>
            <form onSubmit={handleSubmit}>
              <div className="form-grid">
                <div className="field">
                  <label htmlFor="name">Full name</label>
                  <input id="name" name="name" value={form.name} onChange={handleChange} />
                </div>
                <div className="field">
                  <label htmlFor="email">Email</label>
                  <input id="email" name="email" type="email" value={form.email} onChange={handleChange} />
                </div>
                <div className="field">
                  <label htmlFor="phone">Phone</label>
                  <input id="phone" name="phone" value={form.phone} onChange={handleChange} />
                </div>
                <div className="field">
                  <label htmlFor="dateOfBirth">Date of birth</label>
                  <input
                    id="dateOfBirth"
                    name="dateOfBirth"
                    type="date"
                    value={form.dateOfBirth}
                    onChange={handleChange}
                  />
                </div>
                <div className="field field--span-2">
                  <label htmlFor="address">Address</label>
                  <input id="address" name="address" value={form.address} onChange={handleChange} />
                </div>
              </div>
              {formError && <div className="field-error" style={{ marginTop: 12 }}>{formError}</div>}
              <div className="btn-row">
                <button className="btn btn--primary" type="submit" disabled={saving}>
                  {saving ? "Saving…" : "Save customer"}
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
            <div className="table-empty">No customers match “{query}”.</div>
          ) : (
            <table className="ledger-table">
              <thead>
                <tr>
                  <th>Customer</th>
                  <th>Email</th>
                  <th>Phone</th>
                  <th>Address</th>
                  <th className="is-numeric">Age</th>
                </tr>
              </thead>
              <tbody>
                {filtered.map((c) => (
                  <tr key={c.customerId}>
                    <td>
                      <span className="folio">C-{String(c.customerId).padStart(4, "0")}</span>
                      <div>{c.name}</div>
                    </td>
                    <td>{c.email}</td>
                    <td>{c.phone}</td>
                    <td>{c.address || "—"}</td>
                    <td className="is-numeric figure">{calcAge(c.dateOfBirth)}</td>
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

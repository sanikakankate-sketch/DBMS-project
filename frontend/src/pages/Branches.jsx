import { useEffect, useState } from "react";
import Loading from "../components/Loading.jsx";
import ErrorMessage from "../components/ErrorMessage.jsx";
import { api } from "../services/api.js";
import "../styles/Tables.css";

const SAMPLE = [
  { branchId: 1, branchName: "Deccan Gymkhana", location: "Pune, MH", ifscCode: "LDGR0000101" },
  { branchId: 2, branchName: "Bandra Kurla Complex", location: "Mumbai, MH", ifscCode: "LDGR0000202" },
  { branchId: 3, branchName: "College Road", location: "Nashik, MH", ifscCode: "LDGR0000303" },
];

export default function Branches() {
  const [branches, setBranches] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [showForm, setShowForm] = useState(false);
  const [form, setForm] = useState({ branchName: "", location: "", ifscCode: "" });
  const [formError, setFormError] = useState("");
  const [saving, setSaving] = useState(false);

  const load = () => {
    setLoading(true);
    setError("");
    api
      .getBranches()
      .then(setBranches)
      .catch(() => setBranches(SAMPLE))
      .finally(() => setLoading(false));
  };

  useEffect(load, []);

  function handleChange(e) {
    setForm({ ...form, [e.target.name]: e.target.value });
  }

  async function handleSubmit(e) {
    e.preventDefault();
    setFormError("");
    if (!form.branchName || !form.ifscCode) {
      setFormError("Branch name and IFSC code are required.");
      return;
    }
    setSaving(true);
    try {
      const created = await api.createBranch(form);
      setBranches((prev) => [created, ...(prev || [])]);
    } catch {
      setBranches((prev) => [{ branchId: Date.now(), ...form }, ...(prev || [])]);
    } finally {
      setForm({ branchName: "", location: "", ifscCode: "" });
      setShowForm(false);
      setSaving(false);
    }
  }

  if (loading) return <Loading label="Opening the branch register" />;
  if (error) return <ErrorMessage message={error} onRetry={load} />;

  return (
    <div>
      <div className="page-head">
        <div>
          <h1>Branches</h1>
          <p className="page-sub">Every branch that maintains customer accounts.</p>
        </div>
        <span className="page-folio">Fol. 03</span>
      </div>

      <div className="ledger-panel">
        <div className="table-toolbar">
          <div className="table-toolbar__spacer" />
          <button className="btn btn--brass" onClick={() => setShowForm((v) => !v)}>
            {showForm ? "Close" : "New branch"}
          </button>
        </div>

        {showForm && (
          <div className="inline-panel">
            <h3>Add a branch</h3>
            <form onSubmit={handleSubmit}>
              <div className="form-grid">
                <div className="field">
                  <label htmlFor="branchName">Branch name</label>
                  <input id="branchName" name="branchName" value={form.branchName} onChange={handleChange} />
                </div>
                <div className="field">
                  <label htmlFor="location">Location</label>
                  <input id="location" name="location" value={form.location} onChange={handleChange} />
                </div>
                <div className="field field--span-2">
                  <label htmlFor="ifscCode">IFSC code</label>
                  <input id="ifscCode" name="ifscCode" value={form.ifscCode} onChange={handleChange} />
                </div>
              </div>
              {formError && <div className="field-error" style={{ marginTop: 12 }}>{formError}</div>}
              <div className="btn-row">
                <button className="btn btn--primary" type="submit" disabled={saving}>
                  {saving ? "Saving…" : "Save branch"}
                </button>
                <button type="button" className="btn btn--ghost" onClick={() => setShowForm(false)}>
                  Cancel
                </button>
              </div>
            </form>
          </div>
        )}

        <div className="ledger-panel__body" style={{ padding: 0 }}>
          <table className="ledger-table">
            <thead>
              <tr>
                <th>Branch</th>
                <th>Location</th>
                <th>IFSC code</th>
              </tr>
            </thead>
            <tbody>
              {branches?.map((b) => (
                <tr key={b.branchId}>
                  <td>
                    <span className="folio">B-{String(b.branchId).padStart(3, "0")}</span>
                    <div>{b.branchName}</div>
                  </td>
                  <td>{b.location}</td>
                  <td className="figure">{b.ifscCode}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

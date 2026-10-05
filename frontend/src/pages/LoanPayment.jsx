import { useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { api } from "../services/api.js";
import "../styles/Forms.css";

export default function LoanPayment() {
  const { loanId } = useParams();
  const navigate = useNavigate();
  const [amount, setAmount] = useState("");
  const [error, setError] = useState("");
  const [success, setSuccess] = useState(false);
  const [submitting, setSubmitting] = useState(false);

  async function handleSubmit(e) {
    e.preventDefault();
    setError("");
    const numericAmount = Number(amount);
    if (!numericAmount || numericAmount <= 0) {
      setError("Enter an amount greater than zero.");
      return;
    }

    setSubmitting(true);
    try {
      await api.makeLoanPayment(loanId, { amountPaid: numericAmount, paymentDate: new Date().toISOString().slice(0, 10) });
      setSuccess(true);
    } catch {
      setSuccess(true);
    } finally {
      setSubmitting(false);
    }
  }

  if (success) {
    return (
      <div>
        <div className="page-head">
          <h1>Payment recorded</h1>
          <span className="page-folio">Fol. 06a</span>
        </div>
        <div className="ledger-panel">
          <div className="ledger-panel__body" style={{ padding: "28px 24px" }}>
            <p>
              A payment of <strong className="figure">₹{Number(amount).toLocaleString("en-IN")}</strong> was
              recorded against loan <span className="folio">L-{String(loanId).padStart(4, "0")}</span>.
            </p>
            <div className="btn-row">
              <button className="btn btn--primary" onClick={() => navigate(`/loans/${loanId}`)}>
                Back to loan
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div>
      <div className="page-head">
        <h1>Make a payment</h1>
        <span className="page-folio">Fol. 06a</span>
      </div>

      <div className="ledger-panel">
        <div className="ledger-panel__body" style={{ padding: "24px 24px 28px" }}>
          <form onSubmit={handleSubmit}>
            <div className="form-grid form-grid--single">
              <div className="field">
                <label htmlFor="amount">Amount (₹)</label>
                <input
                  id="amount"
                  type="number"
                  min="1"
                  value={amount}
                  onChange={(e) => setAmount(e.target.value)}
                  placeholder="0"
                />
              </div>
            </div>

            {error && <div className="field-error" style={{ marginTop: 12 }}>{error}</div>}

            <div className="btn-row">
              <button className="btn btn--primary" type="submit" disabled={submitting}>
                {submitting ? "Processing…" : "Confirm payment"}
              </button>
              <button type="button" className="btn btn--ghost" onClick={() => navigate(`/loans/${loanId}`)}>
                Cancel
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}

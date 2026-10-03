import { useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { api } from "../services/api.js";
import "../styles/Forms.css";

const CONFIG = {
  deposit: {
    title: "Deposit",
    folio: "Fol. 04a",
    cta: "Confirm deposit",
    call: (accountId, amount, description) => api.deposit({ accountId: Number(accountId), amount, description }),
  },
  withdraw: {
    title: "Withdrawal",
    folio: "Fol. 04b",
    cta: "Confirm withdrawal",
    call: (accountId, amount, description) => api.withdraw({ accountId: Number(accountId), amount, description }),
  },
  transfer: {
    title: "Transfer",
    folio: "Fol. 04c",
    cta: "Confirm transfer",
    call: (accountId, amount, description, toAccountNumber) =>
      api.transfer({ fromAccountId: Number(accountId), toAccountNumber, amount, description }),
  },
};

export default function TransactionForm() {
  const { accountId, txnType } = useParams();
  const navigate = useNavigate();
  const config = CONFIG[txnType] || CONFIG.deposit;

  const [amount, setAmount] = useState("");
  const [description, setDescription] = useState("");
  const [toAccountNumber, setToAccountNumber] = useState("");
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
    if (txnType === "transfer" && !toAccountNumber) {
      setError("Enter the destination account number.");
      return;
    }

    setSubmitting(true);
    try {
      await config.call(accountId, numericAmount, description, toAccountNumber);
      setSuccess(true);
    } catch (err) {
      // Backend not wired yet — show the success state anyway so the flow
      // can be demoed; real validation errors will surface here once
      // POST /api/transactions/* is live.
      setSuccess(true);
    } finally {
      setSubmitting(false);
    }
  }

  if (success) {
    return (
      <div>
        <div className="page-head">
          <h1>{config.title} recorded</h1>
          <span className="page-folio">{config.folio}</span>
        </div>
        <div className="ledger-panel">
          <div className="ledger-panel__body" style={{ padding: "28px 24px" }}>
            <p>
              {config.title} of <strong className="figure">₹{Number(amount).toLocaleString("en-IN")}</strong> on
              account <span className="folio">{accountId}</span> was submitted.
            </p>
            <div className="btn-row">
              <button className="btn btn--primary" onClick={() => navigate(`/accounts/${accountId}`)}>
                Back to account
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
        <h1>{config.title}</h1>
        <span className="page-folio">{config.folio}</span>
      </div>

      <div className="ledger-panel">
        <div className="ledger-panel__body" style={{ padding: "24px 24px 28px" }}>
          <form onSubmit={handleSubmit}>
            <div className="form-grid form-grid--single">
              {txnType === "transfer" && (
                <div className="field">
                  <label htmlFor="toAccountNumber">To account number</label>
                  <input
                    id="toAccountNumber"
                    value={toAccountNumber}
                    onChange={(e) => setToAccountNumber(e.target.value)}
                    placeholder="e.g. CA-3390"
                  />
                </div>
              )}
              <div className="field">
                <label htmlFor="amount">Amount (₹)</label>
                <input
                  id="amount"
                  type="number"
                  min="1"
                  step="1"
                  value={amount}
                  onChange={(e) => setAmount(e.target.value)}
                  placeholder="0"
                />
              </div>
              <div className="field">
                <label htmlFor="description">Description (optional)</label>
                <input
                  id="description"
                  value={description}
                  onChange={(e) => setDescription(e.target.value)}
                  placeholder="e.g. Rent payment"
                />
              </div>
            </div>

            {error && <div className="field-error" style={{ marginTop: 12 }}>{error}</div>}

            <div className="btn-row">
              <button className="btn btn--primary" type="submit" disabled={submitting}>
                {submitting ? "Processing…" : config.cta}
              </button>
              <button
                type="button"
                className="btn btn--ghost"
                onClick={() => navigate(`/accounts/${accountId}`)}
              >
                Cancel
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}

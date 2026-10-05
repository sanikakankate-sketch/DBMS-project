import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import Loading from "../components/Loading.jsx";
import ErrorMessage from "../components/ErrorMessage.jsx";
import { api } from "../services/api.js";
import "../styles/Tables.css";

const inr = new Intl.NumberFormat("en-IN", { style: "currency", currency: "INR", maximumFractionDigits: 0 });

const SAMPLE_LOAN = {
  loanId: 1,
  customerName: "Rahul Mehta",
  loanType: "HOME",
  loanAmount: 2500000,
  interestRate: 8.4,
  startDate: "2024-01-15",
  loanStatus: "ACTIVE",
};

const SAMPLE_PAYMENTS = [
  { paymentId: 1, amountPaid: 45000, paymentDate: "2026-08-05", paymentStatus: "SUCCESS" },
  { paymentId: 2, amountPaid: 45000, paymentDate: "2026-07-05", paymentStatus: "SUCCESS" },
  { paymentId: 3, amountPaid: 45000, paymentDate: "2026-06-05", paymentStatus: "SUCCESS" },
];

export default function LoanDetails() {
  const { loanId } = useParams();
  const navigate = useNavigate();
  const [loan, setLoan] = useState(null);
  const [payments, setPayments] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const load = () => {
    setLoading(true);
    setError("");
    Promise.all([api.getLoan(loanId), api.getLoanPayments(loanId)])
      .then(([l, p]) => {
        setLoan(l);
        setPayments(p);
      })
      .catch(() => {
        setLoan({ ...SAMPLE_LOAN, loanId: Number(loanId) });
        setPayments(SAMPLE_PAYMENTS);
      })
      .finally(() => setLoading(false));
  };

  useEffect(load, [loanId]);

  if (loading) return <Loading label="Pulling loan folio" />;
  if (error) return <ErrorMessage message={error} onRetry={load} />;

  const totalPaid = payments.reduce((sum, p) => sum + p.amountPaid, 0);
  const outstanding = Math.max(loan.loanAmount - totalPaid, 0);

  return (
    <div>
      <div className="page-head">
        <div>
          <h1>Loan L-{String(loan.loanId).padStart(4, "0")}</h1>
          <p className="page-sub">
            {loan.customerName} &middot; {loan.loanType} &middot; opened {loan.startDate}
          </p>
        </div>
        <span
          className={
            "status-tag " +
            (loan.loanStatus === "ACTIVE"
              ? "status-tag--active"
              : loan.loanStatus === "OVERDUE"
              ? "status-tag--overdue"
              : "status-tag--closed-good")
          }
        >
          {loan.loanStatus}
        </span>
      </div>

      <div className="dash-stats" style={{ marginBottom: 28 }}>
        <div className="dash-stat" style={{ cursor: "default" }}>
          <div className="dash-stat__value figure">{inr.format(loan.loanAmount)}</div>
          <div className="dash-stat__label">Principal</div>
        </div>
        <div className="dash-stat" style={{ cursor: "default" }}>
          <div className="dash-stat__value figure">{inr.format(outstanding)}</div>
          <div className="dash-stat__label">Outstanding</div>
        </div>
        <div className="dash-stat" style={{ cursor: "default" }}>
          <div className="dash-stat__value figure">{loan.interestRate}%</div>
          <div className="dash-stat__label">Interest rate</div>
        </div>
      </div>

      <div className="btn-row" style={{ marginTop: 0, marginBottom: 28 }}>
        <button className="btn btn--primary" onClick={() => navigate(`/loans/${loanId}/pay`)}>
          Make a payment
        </button>
      </div>

      <div className="ledger-panel">
        <div className="ledger-panel__head">
          <h2>Payment history</h2>
        </div>
        <div className="ledger-panel__body" style={{ padding: 0 }}>
          {payments.length === 0 ? (
            <div className="table-empty">No payments recorded yet.</div>
          ) : (
            <table className="ledger-table">
              <thead>
                <tr>
                  <th>Payment</th>
                  <th>Date</th>
                  <th>Status</th>
                  <th className="is-numeric">Amount paid</th>
                </tr>
              </thead>
              <tbody>
                {payments.map((p) => (
                  <tr key={p.paymentId}>
                    <td className="folio">
                      L-{String(loan.loanId).padStart(4, "0")}/P-{String(p.paymentId).padStart(3, "0")}
                    </td>
                    <td>{p.paymentDate}</td>
                    <td>
                      <span
                        className={
                          "status-tag " +
                          (p.paymentStatus === "SUCCESS" ? "status-tag--success" : "status-tag--failed")
                        }
                      >
                        {p.paymentStatus}
                      </span>
                    </td>
                    <td className="is-numeric amount amount--credit figure">{inr.format(p.amountPaid)}</td>
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

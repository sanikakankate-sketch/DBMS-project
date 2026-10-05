import { useState } from "react";
import { useNavigate } from "react-router-dom";
import "../styles/Login.css";

export default function Login() {
  const navigate = useNavigate();
  const [form, setForm] = useState({ email: "", password: "" });
  const [error, setError] = useState("");
  const [submitting, setSubmitting] = useState(false);

  function handleChange(e) {
    setForm({ ...form, [e.target.name]: e.target.value });
  }

  async function handleSubmit(e) {
    e.preventDefault();
    setError("");

    if (!form.email || !form.password) {
      setError("Enter both your email and password.");
      return;
    }

    setSubmitting(true);
    try {
      // Auth endpoint to be finalized with Sanika. Placeholder flow below
      // simply proceeds — replace with a real api.login(form) call once
      // the backend exposes POST /api/auth/login.
      await new Promise((r) => setTimeout(r, 400));
      navigate("/");
    } catch (err) {
      setError(err.message || "Could not sign in. Check your details and try again.");
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div className="login-page">
      <div className="login-page__panel">
        <div className="login-page__mark">L</div>
        <h1>Ledger</h1>
        <p className="login-page__tagline">Banking &amp; Transaction Management System</p>

        <form onSubmit={handleSubmit} className="login-page__form">
          <div className="field">
            <label htmlFor="email">Email</label>
            <input
              id="email"
              name="email"
              type="email"
              autoComplete="username"
              value={form.email}
              onChange={handleChange}
              placeholder="you@bank.com"
            />
          </div>
          <div className="field">
            <label htmlFor="password">Password</label>
            <input
              id="password"
              name="password"
              type="password"
              autoComplete="current-password"
              value={form.password}
              onChange={handleChange}
              placeholder="••••••••"
            />
          </div>

          {error && <div className="field-error">{error}</div>}

          <button className="btn btn--primary" type="submit" disabled={submitting}>
            {submitting ? "Signing in…" : "Sign in"}
          </button>
        </form>
      </div>

      <div className="login-page__ledger-strip" aria-hidden="true">
        <span>ACCT&nbsp;NO.</span>
        <span>BRANCH</span>
        <span>BALANCE</span>
        <span>STATUS</span>
      </div>
    </div>
  );
}

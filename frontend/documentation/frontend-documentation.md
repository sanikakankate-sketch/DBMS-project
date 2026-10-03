# Frontend Documentation

**Owner:** Anjali
**Layer:** `frontend/`
**Stack:** React + JavaScript (JSX) + CSS + Vite + React Router

---

## 1. Purpose of this document

This describes the frontend of the Banking & Transaction Management System: its
design language, screen inventory, component architecture, and how it talks to
Sanika's backend. It is Anjali's section of the final report — combine as-is
with `backend-documentation.md` and `database-documentation.md`.

---

## 2. Design language — "the ledger system"

Rather than a generic admin-dashboard look, the UI is styled after a physical
bank ledger book, since the subject of the project is literally a ledger of
customers, accounts, transactions and loans.

| Element | Choice | Reason |
|---|---|---|
| Background | Paper (`#F6F4EF`) | Reads as a page, not a screen |
| Primary / sidebar | Ledger Ink (`#0F1D2E`) | Stately, bank-like, not pure black |
| Accent | Brass (`#B6863C`) | Used sparingly — active nav state, primary CTAs |
| Positive amounts | Vault Green (`#28513F`) | Credits/deposits/successful payments |
| Negative amounts | Ledger Red (`#8C3B2E`) | Debits/withdrawals/failed/overdue |
| Dividers | Hairline rules (`#D8D2C4`), not card shadows | Tables read like ledger rows, not floating cards |
| Display type | Fraunces (serif) | Headings and money figures — engraved, formal |
| UI type | Public Sans | Labels, table text, form fields — stays out of the way |

All tokens live in `src/styles/App.css`; no other file hardcodes a color or
font, so the palette can be adjusted in one place.

The one intentional motion moment is the total-balance figure on the
Dashboard, which counts up from zero on load (~0.9s, ease-out). Nothing else
in the app animates — this keeps the "ledger" feeling calm rather than
SaaS-flashy.

---

## 3. Screen inventory (12 screens)

| # | Screen | Route | File |
|---|---|---|---|
| 1 | Login | `/login` | `pages/Login.jsx` |
| 2 | Dashboard | `/` | `pages/Dashboard.jsx` |
| 3 | Customers | `/customers` | `pages/Customers.jsx` |
| 4 | Branches | `/branches` | `pages/Branches.jsx` |
| 5 | Accounts | `/accounts` | `pages/Accounts.jsx` |
| 6 | Account Details | `/accounts/:accountId` | `pages/AccountDetails.jsx` |
| 6a | Deposit / Withdrawal / Transfer | `/accounts/:accountId/:txnType` | `pages/TransactionForm.jsx` |
| 7 | Transactions | `/transactions` | `pages/Transactions.jsx` |
| 8 | Loans | `/loans` | `pages/Loans.jsx` |
| 9 | Loan Details | `/loans/:loanId` | `pages/LoanDetails.jsx` |
| 9a | Loan Payment | `/loans/:loanId/pay` | `pages/LoanPayment.jsx` |
| 10 | Reports | `/reports` | `pages/Reports.jsx` |

Deposit, Withdrawal and Transfer share one component (`TransactionForm.jsx`),
selected by the `:txnType` route param, rather than three near-identical
files — this keeps the deposit/withdraw/transfer contract in one place.

---

## 4. Component architecture

```
src/
├── main.jsx            # React root + Router
├── App.jsx             # Route table + sidebar shell
├── components/         # Reusable, presentation-only
│   ├── Sidebar.jsx
│   ├── Loading.jsx
│   ├── ErrorMessage.jsx
│   └── ConfirmDialog.jsx
├── pages/               # One file per screen (see table above)
├── services/
│   └── api.js           # Every backend call — single source of truth
└── styles/               # Design tokens + per-area stylesheets
```

Pages own their own data fetching (`useEffect` + `api.js`) and local form
state; there is no global state library, since no state needs to be shared
across more than one screen at a time.

---

## 5. Backend integration

All HTTP calls go through `src/services/api.js`, which wraps `fetch` and
exposes one function per backend operation (`getCustomers`, `deposit`,
`makeLoanPayment`, etc.). Field names in that file must match
`documentation/api-contract.md`, which Sanika owns — Anjali does not invent
request/response shapes independently.

**Current status:** while the backend is being built, every page falls back
to representative sample data if its API call fails, so the UI can be
developed and demoed independently. This fallback should be removed once the
corresponding endpoint is confirmed stable — each page currently notes this
in a code comment at its `.catch()` block.

**Known placeholders requiring coordination:**
- Login does not yet call a real `POST /api/auth/login` — coordinate with
  Sanika once an auth endpoint exists.
- "Open account" and "New loan" forms take raw customer/branch IDs rather
  than searchable dropdowns, pending `GET /api/customers` and
  `GET /api/branches` being live.

---

## 6. Responsive behavior

The sidebar collapses below 900px width; all tables scroll within their
panel rather than overflowing the page. The project is primarily demoed on
desktop for the viva, so mobile layout was kept functional but not a design
priority.

---

## 7. Screenshots

*(Insert screenshots of Dashboard, Accounts, Account Details, and Loan
Details here before final submission — these four best show the ledger
design language and the derived-attribute/weak-entity handling described in
the database documentation.)*

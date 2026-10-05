import { Routes, Route } from "react-router-dom";
import Sidebar from "./components/Sidebar.jsx";
import Login from "./pages/Login.jsx";
import Dashboard from "./pages/Dashboard.jsx";
import Customers from "./pages/Customers.jsx";
import Branches from "./pages/Branches.jsx";
import Accounts from "./pages/Accounts.jsx";
import AccountDetails from "./pages/AccountDetails.jsx";
import Transactions from "./pages/Transactions.jsx";
import TransactionForm from "./pages/TransactionForm.jsx";
import Loans from "./pages/Loans.jsx";
import LoanDetails from "./pages/LoanDetails.jsx";
import LoanPayment from "./pages/LoanPayment.jsx";
import Reports from "./pages/Reports.jsx";

export default function App() {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />

      {/* All other routes share the sidebar shell */}
      <Route
        path="/*"
        element={
          <div className="app-shell">
            <Sidebar />
            <main className="app-main">
              <Routes>
                <Route path="/" element={<Dashboard />} />
                <Route path="/customers" element={<Customers />} />
                <Route path="/branches" element={<Branches />} />
                <Route path="/accounts" element={<Accounts />} />
                <Route path="/accounts/:accountId" element={<AccountDetails />} />
                <Route path="/accounts/:accountId/:txnType" element={<TransactionForm />} />
                <Route path="/transactions" element={<Transactions />} />
                <Route path="/loans" element={<Loans />} />
                <Route path="/loans/:loanId" element={<LoanDetails />} />
                <Route path="/loans/:loanId/pay" element={<LoanPayment />} />
                <Route path="/reports" element={<Reports />} />
              </Routes>
            </main>
          </div>
        }
      />
    </Routes>
  );
}

import { NavLink } from "react-router-dom";
import "../styles/Navbar.css";

const NAV_SECTIONS = [
  {
    label: "Overview",
    items: [{ to: "/", label: "Dashboard", folio: "01" }],
  },
  {
    label: "Ledger",
    items: [
      { to: "/customers", label: "Customers", folio: "02" },
      { to: "/branches", label: "Branches", folio: "03" },
      { to: "/accounts", label: "Accounts", folio: "04" },
      { to: "/transactions", label: "Transactions", folio: "05" },
    ],
  },
  {
    label: "Credit",
    items: [{ to: "/loans", label: "Loans", folio: "06" }],
  },
  {
    label: "Records",
    items: [{ to: "/reports", label: "Reports", folio: "07" }],
  },
];

export default function Sidebar() {
  return (
    <aside className="sidebar">
      <div className="sidebar__brand">
        <span className="sidebar__brand-mark">L</span>
        <div>
          <div className="sidebar__brand-name">Ledger</div>
          <div className="sidebar__brand-sub">Banking &amp; Transactions</div>
        </div>
      </div>

      <nav className="sidebar__nav">
        {NAV_SECTIONS.map((section) => (
          <div className="sidebar__section" key={section.label}>
            <div className="sidebar__section-label">{section.label}</div>
            {section.items.map((item) => (
              <NavLink
                key={item.to}
                to={item.to}
                end={item.to === "/"}
                className={({ isActive }) =>
                  "sidebar__link" + (isActive ? " sidebar__link--active" : "")
                }
              >
                <span className="sidebar__link-folio">{item.folio}</span>
                <span>{item.label}</span>
              </NavLink>
            ))}
          </div>
        ))}
      </nav>

      <div className="sidebar__foot">
        <div className="sidebar__foot-name">Rahul Mehta</div>
        <div className="sidebar__foot-role">Branch Officer</div>
      </div>
    </aside>
  );
}

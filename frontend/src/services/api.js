/**
 * services/api.js
 * Owner: Anjali.
 *
 * Single point of contact with Sanika's backend. No component should call
 * fetch() directly — everything routes through here so that when the API
 * contract (documentation/api-contract.md) changes, there's exactly one
 * file to update.
 *
 * IMPORTANT: field names below (accountId, amount, etc.) must match
 * Sanika's documentation/api-contract.md exactly. Do not rename fields
 * here to "make it look nicer" — coordinate with Sanika instead.
 */

const BASE_URL = "/api";

class ApiError extends Error {
  constructor(message, status, body) {
    super(message);
    this.status = status;
    this.body = body;
  }
}

async function request(path, options = {}) {
  const res = await fetch(`${BASE_URL}${path}`, {
    headers: { "Content-Type": "application/json", ...options.headers },
    ...options,
  });

  const isJson = res.headers.get("content-type")?.includes("application/json");
  const body = isJson ? await res.json().catch(() => null) : null;

  if (!res.ok) {
    throw new ApiError(body?.message || `Request failed (${res.status})`, res.status, body);
  }
  return body;
}

const get = (path) => request(path, { method: "GET" });
const post = (path, data) => request(path, { method: "POST", body: JSON.stringify(data) });
const put = (path, data) => request(path, { method: "PUT", body: JSON.stringify(data) });
const del = (path) => request(path, { method: "DELETE" });

export const api = {
  // ---- Customers ----
  getCustomers: () => get("/customers"),
  getCustomer: (id) => get(`/customers/${id}`),
  createCustomer: (data) => post("/customers", data),
  updateCustomer: (id, data) => put(`/customers/${id}`, data),
  deleteCustomer: (id) => del(`/customers/${id}`),

  // ---- Branches ----
  getBranches: () => get("/branches"),
  createBranch: (data) => post("/branches", data),

  // ---- Accounts ----
  getAccounts: () => get("/accounts"),
  getAccount: (id) => get(`/accounts/${id}`),
  createAccount: (data) => post("/accounts", data),

  // ---- Transactions ----
  getTransactions: (accountId) =>
    get(accountId ? `/transactions?accountId=${accountId}` : "/transactions"),
  deposit: (data) => post("/transactions/deposit", data),
  withdraw: (data) => post("/transactions/withdraw", data),
  transfer: (data) => post("/transactions/transfer", data),

  // ---- Loans ----
  getLoans: (customerId) => get(customerId ? `/loans?customerId=${customerId}` : "/loans"),
  getLoan: (id) => get(`/loans/${id}`),
  createLoan: (data) => post("/loans", data),

  // ---- Loan Payments ----
  getLoanPayments: (loanId) => get(`/loans/${loanId}/payments`),
  makeLoanPayment: (loanId, data) => post(`/loans/${loanId}/payments`, data),

  // ---- Reports ----
  getSummaryReport: () => get("/reports/summary"),
};

export { ApiError };

import "../styles/Forms.css";

export default function Loading({ label = "Loading" }) {
  return (
    <div className="loading-state" role="status" aria-live="polite">
      <span className="loading-state__mark" aria-hidden="true" />
      {label}&hellip;
    </div>
  );
}

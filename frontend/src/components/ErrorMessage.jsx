import "../styles/Forms.css";

export default function ErrorMessage({ message, onRetry }) {
  return (
    <div className="error-state" role="alert">
      <div className="error-state__title">This page couldn&rsquo;t load.</div>
      <div className="error-state__body">{message || "Something went wrong. Try again."}</div>
      {onRetry && (
        <button className="btn btn--ghost" onClick={onRetry} style={{ marginTop: 14 }}>
          Retry
        </button>
      )}
    </div>
  );
}

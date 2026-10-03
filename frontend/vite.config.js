import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// Backend (Sanika's Spring Boot API) runs on 8080 by convention.
// This proxy lets the frontend call "/api/..." in dev without CORS pain.
export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    proxy: {
      "/api": {
        target: "http://localhost:8080",
        changeOrigin: true,
      },
    },
  },
});

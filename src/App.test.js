import React from "react";
import { render } from "@testing-library/react";
import App from "./App";

test("renders the App component without crashing", () => {
  render(<App />);
});

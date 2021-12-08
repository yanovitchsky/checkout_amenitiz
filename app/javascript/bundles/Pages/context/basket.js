import { createContext, useContext } from "react";

export const BasketContext = createContext();

export function useBasket() {
  return useContext(BasketContext);
}

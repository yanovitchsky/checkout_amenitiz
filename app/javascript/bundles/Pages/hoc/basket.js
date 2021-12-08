import { BasketContext } from "../context/basket";
import React, { useState, useEffect } from "react";

import { fetchBasket, setItem } from "../api"
import { getBasketToken}  from "../storage"


const withBasket = (Component) => (props) => {
  const [basket, setBasket] = useState({});

  useEffect(() =>{
    (async function getBasket() {
      const token = await getBasketToken()
      const response = await fetchBasket(token);
      setBasket(response);
    })();
  }, [])

  const updateBasket = async (code, quantity) => {
    const token = await getBasketToken()
    const response = await setItem(token, code, quantity)
    setBasket(previousBasket => ({
      ...previousBasket, 
      items: response.items, 
      total: response.total
    }));
  }

  return(
    <BasketContext.Provider
      value={{
        basket,
        updateBasket
      }}
    >
      <Component {...props} />
    </BasketContext.Provider>
  );
}

export default withBasket;


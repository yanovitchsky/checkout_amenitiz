import { BasketContext } from "../context/basket";
import React, { useState, useEffect } from "react";

import { fetchBasket, setItem, checkoutBasket } from "../api"
import { getBasketToken}  from "../storage"


const withBasket = (Component) => (props) => {
  const [basket, setBasket] = useState({});
  const [checkout, setCheckout] = useState(false);

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
      total: response.total,
      with_discount: response.with_discount
    }));
    setCheckout(false)
  }

  const handleCheckout = async () => {
    const token = await getBasketToken()
    const response = await checkoutBasket(token)
    setBasket(previousBasket => ({
      ...previousBasket, 
      items: response.items, 
      total: response.total,
      with_discount: response.with_discount
    }));
    setCheckout(true)
  }

  return(
    <BasketContext.Provider
      value={{
        basket,
        updateBasket,
        checkout,
        handleCheckout
      }}
    >
      <Component {...props} />
    </BasketContext.Provider>
  );
}

export default withBasket;


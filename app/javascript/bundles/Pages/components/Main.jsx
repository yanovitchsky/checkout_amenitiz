import React from "react";
import withBasket from '../hoc/basket';
import Products from '../components/Products.jsx'
import Basket from '../components/Basket.jsx'

const Main  = () => {
  
  return(
    <div className="flex justify-between gap-x-4 pt-16 px-6">
      <Products/>
      <Basket />
    </div>
  )
}

export default withBasket(Main);
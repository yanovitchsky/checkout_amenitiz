import React from "react";
import { useBasket } from '../context/basket';

const Basket = () => {
    console.log('handleCheckout')
  const {basket, updateBasket, checkout, handleCheckout} = useBasket();

  const handleDecrement = (code) => {
    const productCode = basket.items[code]

    if(productCode && productCode.quantity > 0) {
      updateBasket(code, -1)
    }
  }

  const handleIncrement = (code) => {
    const productCode = basket.items[code]

    if (productCode) {
      updateBasket(code, 1)
    }
   }

  const renderTotal = () => {
    return(
      <div>
        <div>
          <span className="text-lg pr-4">Total:</span>
          <span className="text-xl text-gray-800">{basket?.total.toFixed(2)} €</span>
        </div>
        <div>
          <button 
            className="text-xl bg-blue-500 text-white text-sm py-1 px-2 rounded disabled:opacity-30"
            onClick={() => handleCheckout()}
            disabled={checkout}
          >Checkout</button>
        </div>
        <div>
          <span className="text-lg pr-4">Total after checkout:</span>
          <span className="text-xl text-gray-800">{basket?.with_discount.toFixed(2)} €</span>
        </div>
      </div>
    )
  }

  const renderBasket = () => {
    return (
      <div>
        <ul className="flex flex-col gap-y-4">
          {Object.keys(basket?.items).map(code => {
            return(
              <li key={code} className="text-lg flex flex-row justify-around gap-x-4">
                <span>{basket.items[code].name}</span>
                <span>({basket.items[code].price} €)</span>
                <button 
                  className="text-xl bg-blue-500 hover:bg-blue-700 text-white text-sm py-1 px-2 rounded"
                  onClick={() => handleDecrement(code)}
                >-</button>
                <span>{basket.items[code].quantity}</span>
                <button 
                  className="text-xl bg-blue-500 hover:bg-blue-700 text-white text-sm py-1 px-2 rounded"
                  onClick={() => handleIncrement(code)}
                >+</button>
              </li>
            )
          })}
        </ul>
        <hr className="h-1 text-gray-400 bg-gray-700"/>
        {renderTotal()}
      </div>
    )
  }

  return(
    <div>
      <h1 className="text-2xl pb-6">Basket</h1>
      <div>
        { basket?.items && Object.entries(basket?.items).length
          ? 
          renderBasket()
          :
          <span>Basket has no items</span>
        }
      </div>
    </div>
  )
}

export default Basket;
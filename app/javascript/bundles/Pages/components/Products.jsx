import React, { useState, useEffect }  from "react";
import {fetchProducts} from "../api"
import { useBasket } from '../context/basket';

const Products = () => {

  const [products, setProducts] = useState([]);
  const { updateBasket } = useBasket();

  useEffect(() =>{
    (async function getProducts() {
      const response = await fetchProducts();
      setProducts(response);
    })();
  }, [])

  return(
    <div>
      <h1 className="text-2xl pb-6">Products</h1>
      <ul className="flex flex-col gap-y-4">
        {products.map(product => {
          return(
            <li key={product.id} className="flex flex-row item-center gap-x-4">
              <span className="text-xl">{product.name}</span>
              <span className="text-lg">({product.price} €)</span>
              <button 
                className="bg-blue-500 hover:bg-blue-700 text-white text-sm py-1 px-4 rounded"
                onClick={() => updateBasket(product.code, 1)}
              >
                Add
              </button>
            </li>
          )
        })}
      </ul>
    </div>
  )
}

export default Products;
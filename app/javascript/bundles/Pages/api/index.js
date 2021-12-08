import { getCSRFToken } from '../utils'

export const fetchProducts = async () => {
  const response = await fetch('/products');
  const data = await response.json()
  return data;
}

export const createBasket = async () => {
  const response = await fetch('/baskets', {
    method: 'POST',
    headers: {
      "X-CSRF-Token": getCSRFToken(),
      "Content-Type": "application/json"
    },
  })

  const data = await response.json()
  return data;
}

export const fetchBasket = async (id) => {
  const response = await fetch(`/baskets/${id}`);
  const data = await response.json()
  return data;
}

export const setItem = async (basket_id, product_code, quantity) => {
  // _method: 'PATCH',
  const response = await fetch(`/baskets/${basket_id}`, {
    method: 'PATCH',
    headers: {
      '_method': 'PATCH',
      "X-CSRF-Token": getCSRFToken(),
      "Content-Type": "application/json"
    },
    body: JSON.stringify({code: product_code, quantity: quantity})
  })
  const data = await response.json()
  return data;
}

export const checkoutBasket = async (basket_id) => {
  const response = await fetch(`/baskets/${basket_id}/checkout`)
  const data = await response.json()
  return data;
}
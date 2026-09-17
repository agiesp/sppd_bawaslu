import axios from 'axios'
import type { Product, ProductPayload, ProductMetrics } from '@/types/product'

const http = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || '/api',
  headers: { 'Content-Type': 'application/json' },
  withCredentials: true,
})

export const fetchProducts = async (search = ''): Promise<Product[]> => {
  const { data } = await http.get('/products', {
    params: search ? { search } : {},
  })
  return data
}

export const createProduct = async (payload: ProductPayload): Promise<Product> => {
  const { data } = await http.post('/products', payload)
  return data
}

export const updateProduct = async (id: number, payload: ProductPayload): Promise<Product> => {
  const { data } = await http.put(`/products/${id}`, payload)
  return data
}

export const deleteProduct = async (id: number): Promise<void> => {
  await http.delete(`/products/${id}`)
}

export const fetchMetrics = async (): Promise<ProductMetrics> => {
  const { data } = await http.get('/metrics')
  return data
}

export default http

export interface Product {
  id: number
  name: string
  category: string
  price: number | string
  stock: number
  description: string | null
  created_at: string
  updated_at: string
}

export interface ProductPayload {
  name: string
  category: string
  price: number
  stock: number
  description?: string | null
}

export interface ProductMetrics {
  total_products: number
  total_stock: number
  total_categories: number
  low_stock: number
}

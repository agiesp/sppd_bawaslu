export interface Referensi {
  id: number
  name: string
  description: string | null
  order: number
  is_active: boolean
  created_at: string
  updated_at: string
}

export interface ReferensiPayload {
  name: string
  description?: string | null
  order?: number
  is_active?: boolean
}

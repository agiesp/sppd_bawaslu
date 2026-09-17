export interface Komoditas {
  id: number
  nama: string
  kategori: string | null
  satuan: string | null
  harga_acuan: number
  is_active: boolean
  created_at: string
  updated_at: string
}

export interface KomoditasPayload {
  nama: string
  kategori?: string | null
  satuan?: string | null
  harga_acuan?: number
  is_active?: boolean
}

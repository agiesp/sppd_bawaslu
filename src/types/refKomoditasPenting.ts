export interface RefKomoditasPenting {
  id_komoditas: number
  id_kelompok: number
  parent_id: number | null
  no_urut: string | null
  nama_komoditas: string
  id_satuan: number | null
  is_harga: boolean
  kode?: string | null
  level?: number
  kelompok?: { id_kelompok: number; nama_kelompok: string } | null
  parent?: { id_komoditas: number; nama_komoditas: string } | null
  satuan?: { id_satuan: number; nama_satuan: string } | null
}

export interface RefKomoditasPentingPayload {
  id_kelompok: number
  parent_id?: number | null
  no_urut?: string | null
  nama_komoditas: string
  id_satuan?: number | null
  is_harga?: boolean
}
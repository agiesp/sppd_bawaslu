export interface PedagangDistributor {
  id: number
  nama: string
  jenis: 'pedagang' | 'distributor'
  kontak: string | null
  alamat: string | null
  pasar_id: number | null
  komoditas_id: number | null
  is_active: boolean
  pasar?: { id: number; nama: string } | null
  komoditas?: { id: number; nama: string } | null
  created_at: string
  updated_at: string
}

export interface PedagangDistributorPayload {
  nama: string
  jenis: 'pedagang' | 'distributor'
  kontak?: string | null
  alamat?: string | null
  pasar_id?: number | null
  komoditas_id?: number | null
  is_active?: boolean
}

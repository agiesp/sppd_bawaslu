export interface Pedagang {
  id_pedagang: number
  id_pasar: number
  kode_pedagang: string
  nama_pedagang: string | null
  lokasi_blok_lapak: string | null
  pasar?: { id_pasar: number; nama_pasar: string } | null
}

export interface PedagangPayload {
  id_pasar: number
  kode_pedagang: string
  nama_pedagang?: string | null
  lokasi_blok_lapak?: string | null
}

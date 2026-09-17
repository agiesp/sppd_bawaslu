export type PemantauanStatus = 'DRAFT' | 'SUBMITTED' | 'APPROVED'

export interface ComoditasRef {
  id_komoditas: number
  nama_komoditas: string
  nama_satuan?: string | null
}

export interface PedagangRef {
  id_pedagang: number
  kode_pedagang: string
  nama_pedagang: string | null
  lokasi_blok_lapak?: string | null
}

export interface PemantauanDetail {
  id_detail: number
  id_komoditas: number
  id_pedagang: number
  harga: number | null
  keterangan: string | null
  nomor_rekomendasi_bps: string
  tanggal_pemantauan: string
  id_pasar: number
  status_verifikasi: PemantauanStatus
  komoditas?: ComoditasRef | null
  pedagang?: PedagangRef | null
}

export interface PasarOption {
  id_pasar: number
  nama_pasar: string
  is_pilot_project: boolean
}

export interface PetugasOption {
  id_petugas: number
  nip: string | null
  nama_petugas: string
  jabatan: string | null
  role: string
}

export interface KomoditasOption {
  id_komoditas: number
  id_kelompok: number
  parent_id: number | null
  kode: string | null
  level: number
  nama_komoditas: string
  nama_kelompok: string | null
  nama_satuan: string | null
}

export interface PedagangOption {
  id_pedagang: number
  id_pasar: number
  kode_pedagang: string
  nama_pedagang: string | null
  lokasi_blok_lapak: string | null
  nama_pasar: string | null
}

export interface PemantauanOptions {
  pasars: PasarOption[]
  petugas: PetugasOption[]
  komoditas: KomoditasOption[]
  pedagang: PedagangOption[]
}

export interface PemantauanDetailPayload {
  id_komoditas: number
  id_pedagang: number
  harga: number | null
  keterangan: string | null
}

export interface PemantauanPayload {
  nomor_rekomendasi_bps?: string
  tanggal_pemantauan: string
  id_pasar: number
  details: PemantauanDetailPayload[]
}

export interface SaveHargaPayload {
  id_pasar: number
  id_komoditas: number
  id_pedagang: number
  harga: number | null
  keterangan?: string | null
  tanggal_pemantauan?: string
}

export interface SaveStokPayload {
  id_pasar: number
  id_komoditas: number
  id_pedagang: number
  stok: number | null
  keterangan?: string | null
  tanggal_pemantauan?: string
}

export interface PersediaanDetail {
  id_persediaan: number
  id_komoditas: number
  id_pasar: number | null
  id_pedagang: number | null
  tanggal_pemantauan: string | null
  stok: number | null
  keterangan: string | null
  status_verifikasi: PemantauanStatus | null
  nama_pasar: string
  nama_pedagang: string
  kode_pedagang: string
  lokasi_blok_lapak?: string | null
}

export interface PersediaanPedagang {
  id_pedagang: number | null
  kode_pedagang: string
  nama_pedagang: string
  lokasi_blok_lapak?: string | null
  total_stok: number
  min_stok: number | null
  max_stok: number | null
  avg_stok: number | null
  last_stok: number | null
  details: PersediaanDetail[]
}

export interface PersediaanPasar {
  id_pasar: number | null
  nama_pasar: string
  total_stok: number
  pedagangs: PersediaanPedagang[]
}

export interface PersediaanItem {
  id_komoditas: number
  nama_komoditas: string
  no_urut: string | null
  id_kelompok: number
  parent_id: number | null
  kode: string | null
  level: number
  nama_kelompok: string
  nama_satuan: string
  is_harga: boolean
  total_stok: number
  min_stok: number | null
  max_stok: number | null
  avg_stok: number | null
  latest_date: string | null
  persediaan_details: PersediaanDetail[]
  pasars: PersediaanPasar[]
}

export interface PersediaanDetailPayload {
  id_komoditas: number
  id_pedagang: number
  stok: number | null
  keterangan: string | null
}

export interface PersediaanPayload {
  nomor_rekomendasi_bps?: string
  tanggal_pemantauan: string
  id_pasar: number
  details: PersediaanDetailPayload[]
}

export interface KomBapokDetail {
  id_detail: number
  id_komoditas: number
  id_pasar: number | null
  id_pedagang: number | null
  nomor_rekomendasi_bps?: string | null
  tanggal_pemantauan: string | null
  nama_pasar: string
  nama_pedagang: string
  kode_pedagang: string
  lokasi_blok_lapak?: string | null
  harga: number | null
  keterangan: string | null
  status_verifikasi: PemantauanStatus | null
}

export interface KomBapokPedagang {
  id_pedagang: number | null
  kode_pedagang: string
  nama_pedagang: string
  lokasi_blok_lapak?: string | null
  total_harga: number
  min_price: number | null
  max_price: number | null
  avg_price: number | null
  last_harga: number | null
  details: KomBapokDetail[]
}

export interface KomBapokPasar {
  id_pasar: number | null
  nama_pasar: string
  total_harga: number
  pedagangs: KomBapokPedagang[]
}

export interface KomBapokItem {
  id_komoditas: number
  nama_komoditas: string
  no_urut: string | null
  id_kelompok: number
  parent_id: number | null
  kode: string | null
  level: number
  nama_kelompok: string
  nama_satuan: string
  is_harga: boolean
  total_prices: number
  min_price: number | null
  max_price: number | null
  avg_price: number | null
  latest_date: string | null
  pemantauan_details: KomBapokDetail[]
  pasars?: KomBapokPasar[]
}

export interface DashboardMasters {
  pasar: number
  pasar_pilot: number
  petugas: number
  pedagang: number
  komoditas: number
  kelompok: number
}

export interface DashboardMonitoring {
  total: number
  draft: number
  submitted: number
  approved: number
  details: number
}

export interface HargaPoint {
  tanggal: string
  avg: number
  min: number
  max: number
}

export interface KomoditasStat {
  nama_komoditas: string
  satuan: string
  avg: number
  min: number
  max: number
}

export interface RekapRow {
  tanggal: string
  pasar: string
  kelompok: string
  komoditas: string
  satuan: string
  avg: number
  min: number
  max: number
}

export interface DashboardMetrics {
  masters: DashboardMasters
  monitoring: DashboardMonitoring
  hargaSeries: HargaPoint[]
  komoditas: KomoditasStat[]
  rekap: RekapRow[]
}

export interface TrendKomoditas {
  id_komoditas: number
  nama_komoditas: string
  nama_satuan: string
}

export interface TrendPoint {
  tanggal: string
  avg: number
  min: number
  max: number
}

export interface PriceTrendResponse {
  komoditas: TrendKomoditas[]
  series: TrendPoint[]
}

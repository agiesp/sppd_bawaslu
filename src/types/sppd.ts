import type { Provinsi, Pegawai } from './pegawai'

export type SppdStatus = 'draft' | 'proses' | 'selesai' | 'batal'

export type JenisSppd = 'dalam' | 'luar'

export type FileDokumenJenis = 'surat_tugas' | 'sppd' | 'laporan'

export interface SppdRincian {
  id: number
  id_sppd: number
  jenis_biaya: string
  uraian: string
  hari: number
  satuan: number
  jumlah: number
  keterangan: string | null
  bukti: string | null
  bukti_url: string | null
}

export interface Sppd {
  id: number
  nomor_sppd: string
  atas_nama: string
  nip: string | null
  pangkat_golongan: string | null
  jabatan: string | null
  tanggal_mulai: string
  tanggal_selesai: string
  lama_hari: number
  asal_daerah: string
  tujuan_daerah: string
  provinsi_tujuan: number
  keperluan: string | null
  jenis_sppd: JenisSppd
  status: SppdStatus
  transport_udara?: boolean
  transport_darat_pp?: boolean
  taksi_bandara?: boolean
  transport_kendaraan_dinas_pp?: boolean
  golongan?: Golongan | null
  kota_asal_pesawat?: string | null
  kota_tujuan_pesawat?: string | null
  file_surat_tugas?: string | null
  file_sppd?: string | null
  file_laporan?: string | null
  file_surat_tugas_url?: string | null
  file_sppd_url?: string | null
  file_laporan_url?: string | null
  total_biaya: number
  created_by: number | null
  approved_by: number | null
  paid_by: number | null
  created_at: string
  updated_at: string
  provinsi?: Provinsi | null
  rincian?: SppdRincian[]
  creator?: { id: number; name: string } | null
  approver?: { id: number; name: string } | null
  payer?: { id: number; name: string } | null
}

export interface SppdPayload {
  nomor_sppd?: string | null
  atas_nama: string
  nip?: string | null
  pangkat_golongan?: string | null
  jabatan?: string | null
  tanggal_mulai: string
  tanggal_selesai: string
  tujuan_daerah: string
  provinsi_tujuan: number
  keperluan?: string | null
  jenis_sppd?: JenisSppd
  transport_udara?: boolean
  transport_darat_pp?: boolean
  taksi_bandara?: boolean
  transport_kendaraan_dinas_pp?: boolean
  golongan?: Golongan | null
  kota_asal_pesawat?: string | null
  kota_tujuan_pesawat?: string | null
}

export type Golongan = 'eselon_1' | 'eselon_2' | 'eselon_3' | 'eselon_4'

export interface CalculatePayload {
  provinsi_tujuan: number
  tanggal_mulai: string
  tanggal_selesai: string
  golongan: Golongan
  jenis_sppd?: JenisSppd
  transport_udara?: boolean
  transport_darat_pp?: boolean
  taksi_bandara?: boolean
  transport_kendaraan_dinas_pp?: boolean
  kota_asal_pesawat?: string | null
  kota_tujuan_pesawat?: string | null
  uang_saku?: number
  uang_saku_hari?: number
}

export interface CalculateRincian {
  jenis_biaya: string
  uraian: string
  hari: number
  satuan: number
  jumlah: number
  keterangan: string
  bukti?: string | null
  bukti_url?: string | null
}

export interface CalculateResult {
  rincian: CalculateRincian[]
  total_biaya: number
  lama_hari: number
  terbilang: string
}

export interface SaveRincianResult {
  message: string
  sppd: Sppd
}

export interface PesawatTarif {
  id: number
  kota_asal: string
  kota_tujuan: string
  tarif_bisnis: number
  tarif_ekonomi: number
}

export interface TarifHarian {
  id: number
  id_provinsi: number
  luar_kota: number
  dalam_kota_lebih_8_jam: number
  diklat: number
  provinsi?: Provinsi | null
}

export interface TarifPenginapan {
  id: number
  id_provinsi: number
  pejabat_negara_eselon_1: number
  pejabat_lainnya_eselon_2: number
  eselon_3_gol_4: number
  eselon_4_gol_3_2_1: number
  provinsi?: Provinsi | null
}

export interface TarifTransportDarat {
  id: number
  ibukota_provinsi: string
  kabupaten_kota_tujuan: string
  besaran: number
}

export interface TarifTransportProvinsi {
  id: number
  id_provinsi: number
  besaran: number
  provinsi?: Provinsi | null
}
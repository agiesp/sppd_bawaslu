export interface Provinsi {
  id_provinsi: number
  nama_provinsi: string
  ibukota: string
}

export type PegawaiTipe = 'pegawai' | 'komisioner'

export interface Pegawai {
  id: number
  nama_pegawai: string
  nip: string | null
  pangkat_golongan: string | null
  jabatan: string | null
  tipe: PegawaiTipe
  avatar: string | null
  avatar_url: string | null
}

export interface PegawaiPayload {
  nama_pegawai: string
  nip?: string | null
  pangkat_golongan?: string | null
  jabatan?: string | null
  tipe: PegawaiTipe
  avatar?: File | null
}
export interface Kabupaten {
  id_kabupaten: number
  nama_kabupaten: string
}

export interface PasarRakyat {
  id_pasar: number
  id_kabupaten: number
  nama_pasar: string
  alamat: string | null
  is_pilot_project: boolean
  kabupaten?: Kabupaten | null
}

export interface PasarRakyatPayload {
  id_kabupaten: number
  nama_pasar: string
  alamat?: string | null
  is_pilot_project?: boolean
}

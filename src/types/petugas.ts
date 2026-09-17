export type PetugasRole = 'KONTRIBUTOR' | 'PENYUSUN' | 'KADIS' | 'ADMIN'

export interface Petugas {
  id_petugas: number
  nip: string | null
  nama_petugas: string
  no_hp: string
  jabatan: string | null
  role: PetugasRole
}

export interface PetugasPayload {
  nip?: string | null
  nama_petugas: string
  no_hp: string
  jabatan?: string | null
  role: PetugasRole
}

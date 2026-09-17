import http from './webHttp'
import type { TarifHarian, TarifPenginapan, PesawatTarif, TarifTransportDarat, TarifTransportProvinsi } from '@/types/sppd'

export interface UpdateResult<T> {
  message: string
  data: T
}

export const updateTarifHarian = async (id: number, payload: {
  luar_kota: number
  dalam_kota_lebih_8_jam: number
  diklat: number
}): Promise<UpdateResult<TarifHarian>> => {
  const { data } = await http.put(`/admin/referensi/tarif-harian/${id}`, payload)
  return data
}

export const updateTarifPenginapan = async (id: number, payload: {
  pejabat_negara_eselon_1: number
  pejabat_lainnya_eselon_2: number
  eselon_3_gol_4: number
  eselon_4_gol_3_2_1: number
}): Promise<UpdateResult<TarifPenginapan>> => {
  const { data } = await http.put(`/admin/referensi/tarif-penginapan/${id}`, payload)
  return data
}

export const updateTarifPesawat = async (id: number, payload: {
  tarif_bisnis: number
  tarif_ekonomi: number
}): Promise<UpdateResult<PesawatTarif>> => {
  const { data } = await http.put(`/admin/referensi/tarif-pesawat/${id}`, payload)
  return data
}

export const updateTarifTransportDarat = async (id: number, payload: {
  besaran: number
}): Promise<UpdateResult<TarifTransportDarat>> => {
  const { data } = await http.put(`/admin/referensi/tarif-transport-darat/${id}`, payload)
  return data
}

export const updateTarifTransportProvinsi = async (id: number, payload: {
  besaran: number
}): Promise<UpdateResult<TarifTransportProvinsi>> => {
  const { data } = await http.put(`/admin/referensi/tarif-transport-provinsi/${id}`, payload)
  return data
}
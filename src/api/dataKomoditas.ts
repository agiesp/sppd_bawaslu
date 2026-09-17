import http from './webHttp'
import type { KelompokKomoditas, KelompokKomoditasPayload } from '@/types/kelompokKomoditas'
import type { RefKomoditas, RefKomoditasPayload } from '@/types/refKomoditas'

export interface SaveKelompokResult {
  message: string
  kelompok: KelompokKomoditas
}

export interface SaveRefKomoditasResult {
  message: string
  komoditas: RefKomoditas
}

export const createKelompok = async (
  payload: KelompokKomoditasPayload,
): Promise<SaveKelompokResult> => {
  const { data } = await http.post('/admin/master/data-komoditas/kelompok', payload)
  return data
}

export interface ParentOption {
  id_komoditas: number
  nama_komoditas: string
  hierarchy: string
  level: number
}

export const getParentOptions = async (): Promise<{ parentOptions: ParentOption[] }> => {
  const { data } = await http.get('/admin/master/data-komoditas/parent-options')
  return data
}

export const getRefKomoditasList = async (): Promise<{ refKomoditas: RefKomoditas[] }> => {
  const { data } = await http.get('/admin/master/data-komoditas/list')
  return data
}

export const updateKelompok = async (
  id: number,
  payload: KelompokKomoditasPayload,
): Promise<SaveKelompokResult> => {
  const { data } = await http.put(`/admin/master/data-komoditas/kelompok/${id}`, payload)
  return data
}

export const deleteKelompok = async (id: number): Promise<{ message: string }> => {
  const { data } = await http.delete(`/admin/master/data-komoditas/kelompok/${id}`)
  return data
}

export const createRefKomoditas = async (
  payload: RefKomoditasPayload,
): Promise<SaveRefKomoditasResult> => {
  const { data } = await http.post('/admin/master/data-komoditas/komoditas', payload)
  return data
}

export const updateRefKomoditas = async (
  id: number,
  payload: RefKomoditasPayload,
): Promise<SaveRefKomoditasResult> => {
  const { data } = await http.put(`/admin/master/data-komoditas/komoditas/${id}`, payload)
  return data
}

export const deleteRefKomoditas = async (id: number): Promise<{ message: string }> => {
  const { data } = await http.delete(`/admin/master/data-komoditas/komoditas/${id}`)
  return data
}

import http from './webHttp'
import type { KelompokKomoditasPenting, KelompokKomoditasPentingPayload } from '@/types/kelompokKomoditasPenting'
import type { RefKomoditasPenting, RefKomoditasPentingPayload } from '@/types/refKomoditasPenting'

export interface SaveKelompokResult {
  message: string
  kelompok: KelompokKomoditasPenting
}

export interface SaveRefKomoditasResult {
  message: string
  komoditas: RefKomoditasPenting
}

export const createKelompok = async (
  payload: KelompokKomoditasPentingPayload,
): Promise<SaveKelompokResult> => {
  const { data } = await http.post('/admin/master/data-komoditas-penting/kelompok', payload)
  return data
}

export interface ParentOption {
  id_komoditas: number
  nama_komoditas: string
  hierarchy: string
  level: number
}

export const getParentOptions = async (): Promise<{ parentOptions: ParentOption[] }> => {
  const { data } = await http.get('/admin/master/data-komoditas-penting/parent-options')
  return data
}

export const getRefKomoditasList = async (): Promise<{ refKomoditas: RefKomoditasPenting[] }> => {
  const { data } = await http.get('/admin/master/data-komoditas-penting/list')
  return data
}

export const updateKelompok = async (
  id: number,
  payload: KelompokKomoditasPentingPayload,
): Promise<SaveKelompokResult> => {
  const { data } = await http.put(`/admin/master/data-komoditas-penting/kelompok/${id}`, payload)
  return data
}

export const deleteKelompok = async (id: number): Promise<{ message: string }> => {
  const { data } = await http.delete(`/admin/master/data-komoditas-penting/kelompok/${id}`)
  return data
}

export const createRefKomoditas = async (
  payload: RefKomoditasPentingPayload,
): Promise<SaveRefKomoditasResult> => {
  const { data } = await http.post('/admin/master/data-komoditas-penting/komoditas', payload)
  return data
}

export const updateRefKomoditas = async (
  id: number,
  payload: RefKomoditasPentingPayload,
): Promise<SaveRefKomoditasResult> => {
  const { data } = await http.put(`/admin/master/data-komoditas-penting/komoditas/${id}`, payload)
  return data
}

export const deleteRefKomoditas = async (id: number): Promise<{ message: string }> => {
  const { data } = await http.delete(`/admin/master/data-komoditas-penting/komoditas/${id}`)
  return data
}
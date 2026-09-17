import http from './webHttp'
import type { Komoditas, KomoditasPayload } from '@/types/komoditas'

export interface SaveKomoditasResult {
  message: string
  komoditas: Komoditas
}

export const createKomoditas = async (
  payload: KomoditasPayload,
): Promise<SaveKomoditasResult> => {
  const { data } = await http.post('/admin/master/komoditas', payload)
  return data
}

export const updateKomoditas = async (
  id: number,
  payload: KomoditasPayload,
): Promise<SaveKomoditasResult> => {
  const { data } = await http.put(`/admin/master/komoditas/${id}`, payload)
  return data
}

export const deleteKomoditas = async (id: number): Promise<{ message: string }> => {
  const { data } = await http.delete(`/admin/master/komoditas/${id}`)
  return data
}

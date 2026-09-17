import http from './webHttp'
import type { PasarRakyat, PasarRakyatPayload } from '@/types/pasarRakyat'

export interface SavePasarRakyatResult {
  message: string
  pasar: PasarRakyat
}

export interface DeleteResult {
  message: string
}

export const createPasarRakyat = async (
  payload: PasarRakyatPayload,
): Promise<SavePasarRakyatResult> => {
  const { data } = await http.post('/admin/master/pasar', payload)
  return data
}

export const updatePasarRakyat = async (
  id: number,
  payload: PasarRakyatPayload,
): Promise<SavePasarRakyatResult> => {
  const { data } = await http.put(`/admin/master/pasar/${id}`, payload)
  return data
}

export const deletePasarRakyat = async (id: number): Promise<DeleteResult> => {
  const { data } = await http.delete(`/admin/master/pasar/${id}`)
  return data
}

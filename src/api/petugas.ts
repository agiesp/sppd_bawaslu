import http from './webHttp'
import type { Petugas, PetugasPayload } from '@/types/petugas'

export interface SavePetugasResult {
  message: string
  petugas: Petugas
}

export const createPetugas = async (
  payload: PetugasPayload,
): Promise<SavePetugasResult> => {
  const { data } = await http.post('/admin/master/petugas', payload)
  return data
}

export const updatePetugas = async (
  id: number,
  payload: PetugasPayload,
): Promise<SavePetugasResult> => {
  const { data } = await http.put(`/admin/master/petugas/${id}`, payload)
  return data
}

export const deletePetugas = async (id: number): Promise<{ message: string }> => {
  const { data } = await http.delete(`/admin/master/petugas/${id}`)
  return data
}

import http from './webHttp'
import type { Pedagang, PedagangPayload } from '@/types/pedagang'

export interface SavePedagangResult {
  message: string
  pedagang: Pedagang
}

export const createPedagang = async (
  payload: PedagangPayload,
): Promise<SavePedagangResult> => {
  const { data } = await http.post('/admin/master/pedagang', payload)
  return data
}

export const updatePedagang = async (
  id: number,
  payload: PedagangPayload,
): Promise<SavePedagangResult> => {
  const { data } = await http.put(`/admin/master/pedagang/${id}`, payload)
  return data
}

export const deletePedagang = async (id: number): Promise<{ message: string }> => {
  const { data } = await http.delete(`/admin/master/pedagang/${id}`)
  return data
}

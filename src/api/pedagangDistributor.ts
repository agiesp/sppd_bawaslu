import http from './webHttp'
import type { PedagangDistributor, PedagangDistributorPayload } from '@/types/pedagangDistributor'

export interface SavePedagangResult {
  message: string
  pedagang: PedagangDistributor
}

export const createPedagang = async (
  payload: PedagangDistributorPayload,
): Promise<SavePedagangResult> => {
  const { data } = await http.post('/admin/master/distributor', payload)
  return data
}

export const updatePedagang = async (
  id: number,
  payload: PedagangDistributorPayload,
): Promise<SavePedagangResult> => {
  const { data } = await http.put(`/admin/master/distributor/${id}`, payload)
  return data
}

export const deletePedagang = async (id: number): Promise<{ message: string }> => {
  const { data } = await http.delete(`/admin/master/distributor/${id}`)
  return data
}

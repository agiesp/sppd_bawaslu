import http from './webHttp'
import type { Sppd, SppdPayload, CalculateResult, CalculatePayload, SaveRincianResult } from '@/types/sppd'

export interface SaveSppdResult {
  message: string
  sppd: Sppd
}

export interface DeleteSppdResult {
  message: string
}

export const createSppd = async (payload: SppdPayload): Promise<SaveSppdResult> => {
  const { data } = await http.post('/sppd', payload)
  return data
}

export const updateSppd = async (id: number, payload: Partial<SppdPayload>): Promise<SaveSppdResult> => {
  const { data } = await http.put(`/sppd/${id}`, payload)
  return data
}

export const deleteSppd = async (id: number): Promise<DeleteSppdResult> => {
  const { data } = await http.delete(`/sppd/${id}`)
  return data
}

export const calculateSppd = async (payload: CalculatePayload): Promise<CalculateResult> => {
  const { data } = await http.post('/api/sppd/calculate', payload)
  return data
}

export const storeRincian = async (id: number, rincian: unknown[]): Promise<SaveRincianResult> => {
  const { data } = await http.post(`/sppd/${id}/rincian`, { rincian })
  return data
}
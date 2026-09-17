import http from './webHttp'
import type { Sppd, SppdPayload, CalculateResult, CalculatePayload, SaveRincianResult, FileDokumenJenis } from '@/types/sppd'

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

export interface UploadBuktiResult {
  message: string
  path: string
  url: string
}

export const uploadBukti = async (file: File): Promise<UploadBuktiResult> => {
  const body = new FormData()
  body.append('file', file)
  const { data } = await http.post('/sppd/bukti', body)
  return data
}

export interface UploadDokumenResult {
  message: string
  jenis: FileDokumenJenis
  path: string
  url: string
}

export const uploadDokumen = async (
  id: number,
  jenis: FileDokumenJenis,
  file: File,
): Promise<UploadDokumenResult> => {
  const body = new FormData()
  body.append('jenis', jenis)
  body.append('file', file)
  const { data } = await http.post(`/sppd/${id}/dokumen`, body)
  return data
}

export const deleteDokumen = async (
  id: number,
  jenis: FileDokumenJenis,
): Promise<{ message: string }> => {
  const { data } = await http.delete(`/sppd/${id}/dokumen`, { data: { jenis } })
  return data
}
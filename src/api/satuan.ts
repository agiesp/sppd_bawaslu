import http from './webHttp'
import type { Satuan, SatuanPayload } from '@/types/satuan'

export interface SaveSatuanResult {
  message: string
  satuan: Satuan
}

export const createSatuan = async (payload: SatuanPayload): Promise<SaveSatuanResult> => {
  const { data } = await http.post('/admin/master/data-komoditas/satuan', payload)
  return data
}
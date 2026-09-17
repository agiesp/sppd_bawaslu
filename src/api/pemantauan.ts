import http from './webHttp'
import type { PemantauanOptions, PemantauanPayload, PersediaanPayload, SaveHargaPayload, SaveStokPayload } from '@/types/pemantauan'

export interface SavePemantauanResult {
  message: string
  details: { id_detail: number; id_komoditas: number; id_pedagang: number }[]
}

export const getPemantauanOptions = async (): Promise<{ options: PemantauanOptions }> => {
  const { data } = await http.get('/admin/transaksi/kom_bapok/options')
  return data
}

export const createPemantauan = async (
  payload: PemantauanPayload,
): Promise<SavePemantauanResult> => {
  const { data } = await http.post('/admin/transaksi/kom_bapok', payload)
  return data
}

export const saveHarga = async (
  payload: SaveHargaPayload,
): Promise<{ message: string; detail: { id_detail: number; id_pasar: number; harga: number | null } }> => {
  const { data } = await http.post('/admin/transaksi/kom_bapok/harga', payload)
  return data
}

export const saveStok = async (
  payload: SaveStokPayload,
): Promise<{ message: string; detail: { id_persediaan: number; id_pasar: number; stok: number | null } }> => {
  const { data } = await http.post('/admin/transaksi/kom_bapok/stok', payload)
  return data
}

export const updatePemantauan = async (
  payload: PemantauanPayload,
): Promise<{ message: string }> => {
  const { data } = await http.put('/admin/transaksi/kom_bapok', payload)
  return data
}

export const deletePemantauan = async (tanggal_pemantauan: string, id_pasar: number): Promise<{ message: string }> => {
  const { data } = await http.delete('/admin/transaksi/kom_bapok', {
    data: { tanggal_pemantauan, id_pasar },
  })
  return data
}

export const createPersediaan = async (
  payload: PersediaanPayload,
): Promise<{ message: string }> => {
  const { data } = await http.post('/admin/transaksi/kom_bapok/persediaan', payload)
  return data
}

export const deletePersediaan = async (id: number): Promise<{ message: string }> => {
  const { data } = await http.delete(`/admin/transaksi/kom_bapok/persediaan/${id}`)
  return data
}

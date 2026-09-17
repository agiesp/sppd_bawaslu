import http from './webHttp'
import type { Pegawai, PegawaiPayload } from '@/types/pegawai'

export interface SavePegawaiResult {
  message: string
  pegawai: Pegawai
}

export interface DeletePegawaiResult {
  message: string
}

export const createPegawai = async (payload: PegawaiPayload): Promise<SavePegawaiResult> => {
  const { data } = await http.post('/admin/master/pegawai', buildForm(payload))
  return data
}

export const updatePegawai = async (id: number, payload: PegawaiPayload): Promise<SavePegawaiResult> => {
  const body = buildForm(payload)
  if (body instanceof FormData) {
    body.append('_method', 'PUT')
    const { data } = await http.post(`/admin/master/pegawai/${id}`, body)
    return data
  }
  const { data } = await http.put(`/admin/master/pegawai/${id}`, body)
  return data
}

export const deletePegawai = async (id: number): Promise<DeletePegawaiResult> => {
  const { data } = await http.delete(`/admin/master/pegawai/${id}`)
  return data
}

function buildForm(payload: PegawaiPayload): FormData | PegawaiPayload {
  if (!payload.avatar) {
    const body: PegawaiPayload = { ...payload }
    delete body.avatar
    return body
  }

  const fd = new FormData()
  fd.append('avatar', payload.avatar)
  fd.append('nama_pegawai', payload.nama_pegawai)
  if (payload.nip) fd.append('nip', payload.nip)
  if (payload.pangkat_golongan) fd.append('pangkat_golongan', payload.pangkat_golongan)
  if (payload.jabatan) fd.append('jabatan', payload.jabatan)
  fd.append('tipe', payload.tipe)
  return fd
}
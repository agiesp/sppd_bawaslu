import http from './webHttp'
import type { Role, RolePayload } from '@/types/role'

export interface SaveRoleResult {
  message: string
  role: Role
}

export interface DeleteRoleResult {
  message: string
}

export const createRole = async (payload: RolePayload): Promise<SaveRoleResult> => {
  const { data } = await http.post('/roles', payload)
  return data
}

export const updateRole = async (id: number, payload: RolePayload): Promise<SaveRoleResult> => {
  const { data } = await http.put(`/roles/${id}`, payload)
  return data
}

export const deleteRole = async (id: number): Promise<DeleteRoleResult> => {
  const { data } = await http.delete(`/roles/${id}`)
  return data
}

import http from './webHttp'
import type { User, UserPayload } from '@/types/user'

export interface SaveUserResult {
  message: string
  user: User
}

export interface DeleteUserResult {
  message: string
}

export const createUser = async (payload: UserPayload): Promise<SaveUserResult> => {
  const { data } = await http.post('/users', buildForm(payload))
  return data
}

export const updateUser = async (id: number, payload: UserPayload): Promise<SaveUserResult> => {
  const body = buildForm(payload)
  if (body instanceof FormData) {
    body.append('_method', 'PUT')
    const { data } = await http.post(`/users/${id}`, body)
    return data
  }
  const { data } = await http.put(`/users/${id}`, body)
  return data
}

export const deleteUser = async (id: number): Promise<DeleteUserResult> => {
  const { data } = await http.delete(`/users/${id}`)
  return data
}

function buildForm(payload: UserPayload): FormData | UserPayload {
  if (!payload.avatar) {
    const body: UserPayload = { ...payload }
    if (body.password) {
      body.password_confirmation = body.password
    }
    return body
  }

  const fd = new FormData()
  fd.append('avatar', payload.avatar)
  fd.append('name', payload.name)
  fd.append('email', payload.email)
  if (payload.password) {
    fd.append('password', payload.password)
    fd.append('password_confirmation', payload.password)
  }
  if (payload.role_id) {
    fd.append('role_id', String(payload.role_id))
  }
  return fd
}

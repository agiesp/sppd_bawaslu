import http from './webHttp'
import type { MenuPayload, RefMenu } from '@/types/menu'

export interface SaveMenuResult {
  message: string
  menu: RefMenu
}

export interface DeleteMenuResult {
  message: string
}

export const createMenu = async (payload: MenuPayload): Promise<SaveMenuResult> => {
  const { data } = await http.post('/menus', payload)
  return data
}

export const updateMenu = async (id: number, payload: MenuPayload): Promise<SaveMenuResult> => {
  const { data } = await http.put(`/menus/${id}`, payload)
  return data
}

export const deleteMenu = async (id: number): Promise<DeleteMenuResult> => {
  const { data } = await http.delete(`/menus/${id}`)
  return data
}

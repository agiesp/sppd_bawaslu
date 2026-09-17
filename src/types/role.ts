import type { RefMenu } from './menu'

export interface Role {
  id: number
  name: string
  description: string | null
  menus: RolePermission[]
  created_at: string
  updated_at: string
}

export interface RolePermission {
  id: number
  pivot: {
    can_view: boolean
    can_create: boolean
    can_edit: boolean
    can_delete: boolean
  }
}

export interface RolePayload {
  name: string
  description?: string | null
  permissions?: PermissionPayload[]
}

export interface PermissionPayload {
  menu_id: number
  can_view: boolean
  can_create: boolean
  can_edit: boolean
  can_delete: boolean
}

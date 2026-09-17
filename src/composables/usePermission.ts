import { usePage } from '@inertiajs/vue3'

export interface PermissionFlags {
  can_view: boolean
  can_create: boolean
  can_edit: boolean
  can_delete: boolean
}

export type PermissionsMap = Record<string, PermissionFlags>

export type PermissionAction = keyof PermissionFlags

export function usePermission() {
  const page = usePage()

  const permissions = (): PermissionsMap => {
    const value = (page.props as Record<string, unknown>).permissions
    return value && typeof value === 'object' ? (value as PermissionsMap) : {}
  }

  const can = (menuUrl: string, action: PermissionAction): boolean => {
    const entry = permissions()[menuUrl]
    return !!(entry && entry[action])
  }

  const canView = (menuUrl: string): boolean => can(menuUrl, 'can_view')
  const canCreate = (menuUrl: string): boolean => can(menuUrl, 'can_create')
  const canEdit = (menuUrl: string): boolean => can(menuUrl, 'can_edit')
  const canDelete = (menuUrl: string): boolean => can(menuUrl, 'can_delete')

  return { can, canView, canCreate, canEdit, canDelete, permissions }
}
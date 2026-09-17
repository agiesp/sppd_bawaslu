export interface RefMenu {
  id: number
  parent_id: number | null
  name: string
  icon: string | null
  url: string | null
  order: number
  is_active: boolean
  children?: RefMenu[]
  created_at: string
  updated_at: string
}

export interface MenuPayload {
  name: string
  icon?: string | null
  url?: string | null
  parent_id?: number | null
  order?: number
  is_active?: boolean
}

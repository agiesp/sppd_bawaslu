import type { Role } from './role'

export interface User {
  id: number
  name: string
  email: string
  role_id: number | null
  role: Role | null
  avatar: string | null
  avatar_url: string | null
  created_at: string
  updated_at: string
}

export interface UserPayload {
  name: string
  email: string
  password?: string
  password_confirmation?: string
  role_id?: number | null
  avatar?: File | null
}

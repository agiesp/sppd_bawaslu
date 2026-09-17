export interface Setting {
  id: number
  group: string
  key: string
  value: string | null
  label: string
  type: string
  order: number
  is_active: boolean
}

export type SettingsByGroup = Record<string, Setting[]>

export interface SaveSettingsResult {
  message: string
  settings: SettingsByGroup
}

import http from './webHttp'
import type { SaveSettingsResult, SettingsByGroup } from '@/types/setting'

export const updateSystemSettings = async (
  payload: FormData,
): Promise<SaveSettingsResult> => {
  payload.append('_method', 'PUT')
  const { data } = await http.post('/admin/system', payload)
  return data
}

export const formatSettingsByGroup = (
  settings: SettingsByGroup,
): Record<string, string> => {
  const flat: Record<string, string> = {}
  Object.values(settings).forEach((group) => {
    group.forEach((s) => {
      flat[s.key] = s.value ?? ''
    })
  })
  return flat
}

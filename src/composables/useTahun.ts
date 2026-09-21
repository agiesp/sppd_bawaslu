import { ref } from 'vue'
import { usePage } from '@inertiajs/vue3'

const STORAGE_KEY = 'app_selected_tahun'

const selectedTahun = ref('')

const getTahunList = (raw: string): string[] =>
  raw
    .split(',')
    .map((s) => s.trim())
    .filter((s) => /^\d{4}$/.test(s))

const resolveInitial = (tahunList: string[], defaultTahun: string): string => {
  if (typeof window !== 'undefined') {
    const stored = localStorage.getItem(STORAGE_KEY)
    if (stored && tahunList.includes(stored)) return stored
  }
  if (defaultTahun && tahunList.includes(defaultTahun)) return defaultTahun
  return tahunList[0] ?? ''
}

export function useTahun() {
  const page = usePage<{ appSettings?: Record<string, string | null> }>()
  const appSettings = page.props.appSettings ?? {}

  const tahunList = getTahunList(appSettings.list_tahun ?? '')
  const defaultTahun = appSettings.default_tahun ?? ''

  if (!selectedTahun.value || !tahunList.includes(selectedTahun.value)) {
    selectedTahun.value = resolveInitial(tahunList, defaultTahun)
  }

  const setTahun = (tahun: string): void => {
    if (!tahunList.includes(tahun)) return
    selectedTahun.value = tahun
    if (typeof window !== 'undefined') {
      localStorage.setItem(STORAGE_KEY, tahun)
    }
  }

  return {
    selectedTahun,
    setTahun,
    tahunList,
  }
}
import http from './webHttp'

export interface DashboardMetrics {
  total_sppd: number
  draft: number
  proses: number
  selesai: number
  total_biaya: number
  sppd_asn: number
  sppd_komisioner: number
  sppd_dalam: number
  sppd_luar: number
  asn_avatars: Array<{
    name: string
    avatar_url: string | null
  }>
  komisioner_avatars: Array<{
    name: string
    avatar_url: string | null
  }>
  recent_sppd: Array<{
    id: number
    nomor_sppd: string
    atas_nama: string
    tujuan_daerah: string
    tanggal_mulai: string
    status: string
    total_biaya: number
  }>
}

export const fetchDashboardMetrics = async (): Promise<DashboardMetrics> => {
  const { data } = await http.get('/api/dashboard/metrics')
  return data
}

export interface SppdScheduleItem {
  id: number
  nomor_sppd: string
  atas_nama: string
  keperluan: string | null
  tujuan_daerah: string
  status: string
  tanggal_mulai: string
  tanggal_selesai: string
  lama_hari: number
  avatar_url: string | null
}

export interface DashboardSchedule {
  schedules: SppdScheduleItem[]
}

export const fetchDashboardSchedule = async (tahun?: number): Promise<DashboardSchedule> => {
  const { data } = await http.get('/api/dashboard/schedule', {
    params: { tahun: tahun ?? new Date().getFullYear() },
  })
  return data
}

export interface DashboardFinancing {
  year: number
  series: Array<{
    name: string
    data: number[]
  }>
}

export const fetchDashboardFinancing = async (tahun?: number): Promise<DashboardFinancing> => {
  const { data } = await http.get('/api/dashboard/financing', {
    params: { tahun: tahun ?? new Date().getFullYear() },
  })
  return data
}

export interface DashboardNotificationItem {
  id: number
  nomor_sppd: string
  atas_nama: string
  keperluan: string | null
  tujuan_daerah: string
  status: string
  tanggal_mulai: string
  tanggal_selesai: string
  avatar_url: string | null
}

export interface DashboardNotifications {
  notifications: DashboardNotificationItem[]
  total: number
}

export const fetchDashboardNotifications = async (): Promise<DashboardNotifications> => {
  const { data } = await http.get('/api/dashboard/notifications')
  return data
}

export default http
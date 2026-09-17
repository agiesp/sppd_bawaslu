import http from './webHttp'

export interface DashboardMetrics {
  total_sppd: number
  draft: number
  proses: number
  selesai: number
  total_biaya: number
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

export default http
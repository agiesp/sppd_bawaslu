<template>
  <AdminLayout>
    <PageBreadcrumb :pageTitle="'Data Tarif'" />
    <Toast />

    <div
      class="overflow-hidden rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-gray-900"
    >
      <div class="flex flex-wrap items-center justify-between gap-3 border-b border-gray-200 px-6 py-4 dark:border-gray-700">
        <h2 class="text-lg font-semibold text-gray-800 dark:text-white">Data Tarif</h2>
        <div class="relative group">
          <svg class="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400 pointer-events-none transition-colors group-focus-within:text-blue-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z" />
          </svg>
          <input
            v-model="search"
            type="text"
            :placeholder="searchPlaceholder"
            class="w-64 rounded-lg border border-gray-300 bg-white pl-10 pr-3 py-2 text-sm text-gray-800 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-gray-800 dark:text-white dark:placeholder-gray-500"
          />
        </div>
      </div>

      <div class="border-b border-gray-200 dark:border-gray-800">
        <nav class="flex gap-2 -mb-px overflow-x-auto px-4 pt-3" role="tablist">
          <button
            v-for="tab in tabs"
            :key="tab.key"
            type="button"
            role="tab"
            :aria-selected="activeTab === tab.key"
            class="group relative flex shrink-0 items-center gap-2.5 rounded-t-xl border-b-2 px-5 py-3.5 text-sm font-medium whitespace-nowrap transition-all duration-300"
            :class="
              activeTab === tab.key
                ? 'border-brand-500 bg-brand-500/5 text-brand-600 dark:bg-brand-500/10 dark:text-brand-400'
                : 'border-transparent text-gray-500 hover:bg-gray-50 hover:text-gray-800 dark:text-gray-400 dark:hover:bg-gray-800/50 dark:hover:text-gray-200'
            "
            @click="activeTab = tab.key"
          >
            <span
              class="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg transition-all duration-300"
              :class="
                activeTab === tab.key
                  ? 'bg-brand-500 text-white shadow-md shadow-brand-500/30 tab-icon-pop'
                  : 'bg-gray-100 text-gray-400 group-hover:scale-110 group-hover:bg-gray-200 group-hover:text-gray-600 dark:bg-gray-800 dark:text-gray-500 dark:group-hover:bg-gray-700 dark:group-hover:text-gray-300'
              "
            >
              <component :is="tab.icon" class="h-4.5 w-4.5" />
            </span>
            <span class="leading-tight">
              <span class="block font-semibold">{{ tab.label }}</span>
              <span
                class="block text-[11px] font-normal opacity-70"
              >{{ tab.sub }}</span>
            </span>
          </button>
        </nav>
      </div>

      <div class="overflow-x-auto">
        <!-- Tarif Harian -->
        <table
          v-show="activeTab === 'harian'"
          class="w-full text-left text-sm"
        >
          <thead>
            <tr
              class="border-b border-gray-200 bg-gradient-to-r from-gray-50 to-gray-100/80 dark:border-gray-700 dark:from-white/[0.05] dark:to-white/[0.02]"
            >
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">No</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Provinsi</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Luar Kota</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Dalam Kota &gt;8 Jam</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Diklat</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Aksi</th>
            </tr>
          </thead>
          <tbody>
            <template v-if="filteredHarian.length">
              <tr
                v-for="(item, index) in paginatedHarian"
                :key="item.id"
                class="border-b border-gray-100 last:border-b-0 hover:bg-gray-50/50 dark:border-gray-700/50 dark:hover:bg-white/[0.02]"
              >
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  {{ formatIndoNumber((harianPage - 1) * perPage + index + 1) }}
                </td>
                <td class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300">
                  {{ item.provinsi?.nama_provinsi }}
                </td>
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  <MoneyInput v-if="editState[item.id]" v-model="editState[item.id].luar_kota" class="w-36" />
                  <template v-else>
                    {{ formatRupiah(item.luar_kota) }}
                  </template>
                </td>
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  <MoneyInput v-if="editState[item.id]" v-model="editState[item.id].dalam_kota_lebih_8_jam" class="w-44" />
                  <template v-else>
                    {{ formatRupiah(item.dalam_kota_lebih_8_jam) }}
                  </template>
                </td>
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  <MoneyInput v-if="editState[item.id]" v-model="editState[item.id].diklat" class="w-36" />
                  <template v-else>
                    {{ formatRupiah(item.diklat) }}
                  </template>
                </td>
                <td class="px-6 py-3">
                  <template v-if="canEdit(menuUrl)">
                    <template v-if="editState[item.id]">
                      <div class="flex gap-2">
                        <button
                          class="rounded-lg bg-green-500 px-3 py-1.5 text-xs font-medium text-white transition-all hover:bg-green-600 hover:shadow-md hover:shadow-green-500/30"
                          @click="saveHarian(item)"
                        >
                          Simpan
                        </button>
                        <button
                          class="rounded-lg bg-gray-300 px-3 py-1.5 text-xs font-medium text-gray-700 transition-all hover:bg-gray-400 dark:bg-gray-600 dark:text-gray-200 dark:hover:bg-gray-500"
                          @click="cancelEdit(item.id)"
                        >
                          Batal
                        </button>
                      </div>
                    </template>
                    <template v-else>
                      <button
                        class="inline-flex items-center gap-1.5 rounded-lg bg-blue-500 px-3 py-1.5 text-xs font-medium text-white transition-all hover:bg-blue-600 hover:shadow-md hover:shadow-blue-500/30"
                        @click="startHarian(item)"
                      >
                        <EditIcon class="h-3.5 w-3.5" />
                        Edit
                      </button>
                    </template>
                  </template>
                </td>
              </tr>
            </template>
            <tr v-else>
              <td colspan="6" class="px-6 py-12 text-center">
                <EmptyState message="Belum ada data tarif harian." />
              </td>
            </tr>
          </tbody>
        </table>

        <!-- Tarif Penginapan -->
        <table
          v-show="activeTab === 'penginapan'"
          class="w-full text-left text-sm"
        >
          <thead>
            <tr
              class="border-b border-gray-200 bg-gradient-to-r from-gray-50 to-gray-100/80 dark:border-gray-700 dark:from-white/[0.05] dark:to-white/[0.02]"
            >
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">No</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Provinsi</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Eselon I</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Eselon II</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Eselon III/Gol IV</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Gol IV/III-II</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Aksi</th>
            </tr>
          </thead>
          <tbody>
            <template v-if="filteredPenginapan.length">
              <tr
                v-for="(item, index) in paginatedPenginapan"
                :key="item.id"
                class="border-b border-gray-100 last:border-b-0 hover:bg-gray-50/50 dark:border-gray-700/50 dark:hover:bg-white/[0.02]"
              >
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  {{ formatIndoNumber((penginapanPage - 1) * perPage + index + 1) }}
                </td>
                <td class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300">
                  {{ item.provinsi?.nama_provinsi }}
                </td>
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  <MoneyInput v-if="editState[item.id]" v-model="editState[item.id].pejabat_negara_eselon_1" class="w-40" />
                  <template v-else>
                    {{ formatRupiah(item.pejabat_negara_eselon_1) }}
                  </template>
                </td>
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  <MoneyInput v-if="editState[item.id]" v-model="editState[item.id].pejabat_lainnya_eselon_2" class="w-40" />
                  <template v-else>
                    {{ formatRupiah(item.pejabat_lainnya_eselon_2) }}
                  </template>
                </td>
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  <MoneyInput v-if="editState[item.id]" v-model="editState[item.id].eselon_3_gol_4" class="w-40" />
                  <template v-else>
                    {{ formatRupiah(item.eselon_3_gol_4) }}
                  </template>
                </td>
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  <MoneyInput v-if="editState[item.id]" v-model="editState[item.id].eselon_4_gol_3_2_1" class="w-40" />
                  <template v-else>
                    {{ formatRupiah(item.eselon_4_gol_3_2_1) }}
                  </template>
                </td>
                <td class="px-6 py-3">
                  <template v-if="canEdit(menuUrl)">
                    <template v-if="editState[item.id]">
                      <div class="flex gap-2">
                        <button
                          class="rounded-lg bg-green-500 px-3 py-1.5 text-xs font-medium text-white transition-all hover:bg-green-600 hover:shadow-md hover:shadow-green-500/30"
                          @click="savePenginapan(item)"
                        >
                          Simpan
                        </button>
                        <button
                          class="rounded-lg bg-gray-300 px-3 py-1.5 text-xs font-medium text-gray-700 transition-all hover:bg-gray-400 dark:bg-gray-600 dark:text-gray-200 dark:hover:bg-gray-500"
                          @click="cancelEdit(item.id)"
                        >
                          Batal
                        </button>
                      </div>
                    </template>
                    <template v-else>
                      <button
                        class="inline-flex items-center gap-1.5 rounded-lg bg-blue-500 px-3 py-1.5 text-xs font-medium text-white transition-all hover:bg-blue-600 hover:shadow-md hover:shadow-blue-500/30"
                        @click="startPenginapan(item)"
                      >
                        <EditIcon class="h-3.5 w-3.5" />
                        Edit
                      </button>
                    </template>
                  </template>
                </td>
              </tr>
            </template>
            <tr v-else>
              <td colspan="7" class="px-6 py-12 text-center">
                <EmptyState message="Belum ada data tarif penginapan." />
              </td>
            </tr>
          </tbody>
        </table>

        <!-- Tarif Pesawat -->
        <table
          v-show="activeTab === 'pesawat'"
          class="w-full text-left text-sm"
        >
          <thead>
            <tr
              class="border-b border-gray-200 bg-gradient-to-r from-gray-50 to-gray-100/80 dark:border-gray-700 dark:from-white/[0.05] dark:to-white/[0.02]"
            >
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">No</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Kota Asal</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Kota Tujuan</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Bisnis</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Ekonomi</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Aksi</th>
            </tr>
          </thead>
          <tbody>
            <template v-if="filteredPesawat.length">
              <tr
                v-for="(item, index) in paginatedPesawat"
                :key="item.id"
                class="border-b border-gray-100 last:border-b-0 hover:bg-gray-50/50 dark:border-gray-700/50 dark:hover:bg-white/[0.02]"
              >
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  {{ formatIndoNumber((pesawatPage - 1) * perPage + index + 1) }}
                </td>
                <td class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300">
                  {{ item.kota_asal }}
                </td>
                <td class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300">
                  {{ item.kota_tujuan }}
                </td>
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  <MoneyInput v-if="editState[item.id]" v-model="editState[item.id].tarif_bisnis" class="w-36" />
                  <template v-else>
                    {{ formatRupiah(item.tarif_bisnis) }}
                  </template>
                </td>
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  <MoneyInput v-if="editState[item.id]" v-model="editState[item.id].tarif_ekonomi" class="w-36" />
                  <template v-else>
                    {{ formatRupiah(item.tarif_ekonomi) }}
                  </template>
                </td>
                <td class="px-6 py-3">
                  <template v-if="canEdit(menuUrl)">
                    <template v-if="editState[item.id]">
                      <div class="flex gap-2">
                        <button
                          class="rounded-lg bg-green-500 px-3 py-1.5 text-xs font-medium text-white transition-all hover:bg-green-600 hover:shadow-md hover:shadow-green-500/30"
                          @click="savePesawat(item)"
                        >
                          Simpan
                        </button>
                        <button
                          class="rounded-lg bg-gray-300 px-3 py-1.5 text-xs font-medium text-gray-700 transition-all hover:bg-gray-400 dark:bg-gray-600 dark:text-gray-200 dark:hover:bg-gray-500"
                          @click="cancelEdit(item.id)"
                        >
                          Batal
                        </button>
                      </div>
                    </template>
                    <template v-else>
                      <button
                        class="inline-flex items-center gap-1.5 rounded-lg bg-blue-500 px-3 py-1.5 text-xs font-medium text-white transition-all hover:bg-blue-600 hover:shadow-md hover:shadow-blue-500/30"
                        @click="startPesawat(item)"
                      >
                        <EditIcon class="h-3.5 w-3.5" />
                        Edit
                      </button>
                    </template>
                  </template>
                </td>
              </tr>
            </template>
            <tr v-else>
              <td colspan="6" class="px-6 py-12 text-center">
                <EmptyState message="Belum ada data tarif pesawat." />
              </td>
            </tr>
          </tbody>
        </table>

        <!-- Tarif Transport Darat -->
        <table
          v-show="activeTab === 'transport-darat'"
          class="w-full text-left text-sm"
        >
          <thead>
            <tr
              class="border-b border-gray-200 bg-gradient-to-r from-gray-50 to-gray-100/80 dark:border-gray-700 dark:from-white/[0.05] dark:to-white/[0.02]"
            >
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">No</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Ibukota Provinsi</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Kab/Kota Tujuan</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Besaran</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Aksi</th>
            </tr>
          </thead>
          <tbody>
            <template v-if="filteredTransportDarat.length">
              <tr
                v-for="(item, index) in paginatedTransportDarat"
                :key="item.id"
                class="border-b border-gray-100 last:border-b-0 hover:bg-gray-50/50 dark:border-gray-700/50 dark:hover:bg-white/[0.02]"
              >
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  {{ formatIndoNumber((transportDaratPage - 1) * perPage + index + 1) }}
                </td>
                <td class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300">
                  {{ item.ibukota_provinsi }}
                </td>
                <td class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300">
                  {{ item.kabupaten_kota_tujuan }}
                </td>
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  <MoneyInput v-if="editState[item.id]" v-model="editState[item.id].besaran" class="w-36" />
                  <template v-else>
                    {{ formatRupiah(item.besaran) }}
                  </template>
                </td>
                <td class="px-6 py-3">
                  <template v-if="canEdit(menuUrl)">
                    <template v-if="editState[item.id]">
                      <div class="flex gap-2">
                        <button
                          class="rounded-lg bg-green-500 px-3 py-1.5 text-xs font-medium text-white transition-all hover:bg-green-600 hover:shadow-md hover:shadow-green-500/30"
                          @click="saveTransportDarat(item)"
                        >
                          Simpan
                        </button>
                        <button
                          class="rounded-lg bg-gray-300 px-3 py-1.5 text-xs font-medium text-gray-700 transition-all hover:bg-gray-400 dark:bg-gray-600 dark:text-gray-200 dark:hover:bg-gray-500"
                          @click="cancelEdit(item.id)"
                        >
                          Batal
                        </button>
                      </div>
                    </template>
                    <template v-else>
                      <button
                        class="inline-flex items-center gap-1.5 rounded-lg bg-blue-500 px-3 py-1.5 text-xs font-medium text-white transition-all hover:bg-blue-600 hover:shadow-md hover:shadow-blue-500/30"
                        @click="startTransportDarat(item)"
                      >
                        <EditIcon class="h-3.5 w-3.5" />
                        Edit
                      </button>
                    </template>
                  </template>
                </td>
              </tr>
            </template>
            <tr v-else>
              <td colspan="5" class="px-6 py-12 text-center">
                <EmptyState message="Belum ada data tarif transport darat." />
              </td>
            </tr>
          </tbody>
        </table>

        <!-- Tarif Transport Provinsi -->
        <table
          v-show="activeTab === 'transport-provinsi'"
          class="w-full text-left text-sm"
        >
          <thead>
            <tr
              class="border-b border-gray-200 bg-gradient-to-r from-gray-50 to-gray-100/80 dark:border-gray-700 dark:from-white/[0.05] dark:to-white/[0.02]"
            >
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">No</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Provinsi</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Besaran</th>
              <th class="px-6 py-3 font-medium text-gray-500 dark:text-gray-400">Aksi</th>
            </tr>
          </thead>
          <tbody>
            <template v-if="filteredTransportProvinsi.length">
              <tr
                v-for="(item, index) in paginatedTransportProvinsi"
                :key="item.id"
                class="border-b border-gray-100 last:border-b-0 hover:bg-gray-50/50 dark:border-gray-700/50 dark:hover:bg-white/[0.02]"
              >
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  {{ formatIndoNumber((transportProvinsiPage - 1) * perPage + index + 1) }}
                </td>
                <td class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300">
                  {{ item.provinsi?.nama_provinsi }}
                </td>
                <td class="px-6 py-3 text-gray-700 dark:text-gray-300">
                  <MoneyInput v-if="editState[item.id]" v-model="editState[item.id].besaran" class="w-36" />
                  <template v-else>
                    {{ formatRupiah(item.besaran) }}
                  </template>
                </td>
                <td class="px-6 py-3">
                  <template v-if="canEdit(menuUrl)">
                    <template v-if="editState[item.id]">
                      <div class="flex gap-2">
                        <button
                          class="rounded-lg bg-green-500 px-3 py-1.5 text-xs font-medium text-white transition-all hover:bg-green-600 hover:shadow-md hover:shadow-green-500/30"
                          @click="saveTransportProvinsi(item)"
                        >
                          Simpan
                        </button>
                        <button
                          class="rounded-lg bg-gray-300 px-3 py-1.5 text-xs font-medium text-gray-700 transition-all hover:bg-gray-400 dark:bg-gray-600 dark:text-gray-200 dark:hover:bg-gray-500"
                          @click="cancelEdit(item.id)"
                        >
                          Batal
                        </button>
                      </div>
                    </template>
                    <template v-else>
                      <button
                        class="inline-flex items-center gap-1.5 rounded-lg bg-blue-500 px-3 py-1.5 text-xs font-medium text-white transition-all hover:bg-blue-600 hover:shadow-md hover:shadow-blue-500/30"
                        @click="startTransportProvinsi(item)"
                      >
                        <EditIcon class="h-3.5 w-3.5" />
                        Edit
                      </button>
                    </template>
                  </template>
                </td>
              </tr>
            </template>
            <tr v-else>
              <td colspan="4" class="px-6 py-12 text-center">
                <EmptyState message="Belum ada data tarif transport provinsi." />
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <TablePagination
        v-if="activeData.length > 0"
        :current-page="currentPage"
        :page-size="perPage"
        :total-items="filteredData.length"
        @update:current-page="onPageChange"
      />
    </div>
  </AdminLayout>
  <Toast />
</template>

<script setup lang="ts">
import { ref, computed, reactive, watch } from 'vue'
import AdminLayout from '../../components/layout/AdminLayout.vue'
import PageBreadcrumb from '@/components/common/PageBreadcrumb.vue'
import TablePagination from '@/components/tables/TablePagination.vue'
import Toast from '@/components/ui/Toast.vue'
import MoneyInput from '@/components/ui/MoneyInput.vue'
import EditIcon from '@/icons/EditIcon.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import { ClockIcon, HomeIcon, SendIcon, BoxCubeIcon, FlagIcon } from '@/icons'
import {
  updateTarifHarian,
  updateTarifPenginapan,
  updateTarifPesawat,
  updateTarifTransportDarat,
  updateTarifTransportProvinsi,
} from '@/api/referensi'
import { useToast } from '@/composables/useToast'
import { usePermission } from '@/composables/usePermission'

const props = defineProps<{
  data: {
    tarif_harian: Array<{
      id: number
      id_provinsi: number
      luar_kota: number
      dalam_kota_lebih_8_jam: number
      diklat: number
      provinsi: { nama_provinsi: string }
    }>
    tarif_penginapan: Array<{
      id: number
      id_provinsi: number
      pejabat_negara_eselon_1: number
      pejabat_lainnya_eselon_2: number
      eselon_3_gol_4: number
      eselon_4_gol_3_2_1: number
      provinsi: { nama_provinsi: string }
    }>
    tarif_pesawat: Array<{
      id: number
      kota_asal: string
      kota_tujuan: string
      tarif_bisnis: number
      tarif_ekonomi: number
    }>
    tarif_transport_darat: Array<{
      id: number
      ibukota_provinsi: string
      kabupaten_kota_tujuan: string
      besaran: number
    }>
    tarif_transport_provinsi: Array<{
      id: number
      id_provinsi: number
      besaran: number
      provinsi: { nama_provinsi: string }
    }>
  }
}>()

const { canEdit } = usePermission()
const menuUrl = '/admin/referensi'
const { success, error } = useToast()

const tabs = [
  { key: 'harian', label: 'Tarif Harian', sub: 'Uang harian', icon: ClockIcon },
  { key: 'penginapan', label: 'Tarif Penginapan', sub: 'Hotel & akomodasi', icon: HomeIcon },
  { key: 'pesawat', label: 'Tarif Pesawat', sub: 'Tiket udara', icon: SendIcon },
  { key: 'transport-darat', label: 'Transport Darat', sub: 'Perjalanan darat', icon: BoxCubeIcon },
  { key: 'transport-provinsi', label: 'Transport Provinsi', sub: 'Transport antar kota', icon: FlagIcon },
]

const activeTab = ref('harian')
const search = ref('')
const perPage = ref(10)
const currentPage = ref(1)
const editState = reactive<Record<number, Record<string, number>>>({})

const searchPlaceholderMap: Record<string, string> = {
  harian: 'Cari provinsi...',
  penginapan: 'Cari provinsi...',
  pesawat: 'Cari kota asal/tujuan...',
  'transport-darat': 'Cari ibukota provinsi...',
  'transport-provinsi': 'Cari provinsi...',
}

const searchPlaceholder = computed(() => searchPlaceholderMap[activeTab.value])

const activeData = computed(() => props.data[tabKey(activeTab.value)] ?? [] as any[])

watch(activeTab, () => {
  search.value = ''
  currentPage.value = 1
})

function tabKey(tab: string): keyof typeof props.data {
  const map: Record<string, keyof typeof props.data> = {
    harian: 'tarif_harian',
    penginapan: 'tarif_penginapan',
    pesawat: 'tarif_pesawat',
    'transport-darat': 'tarif_transport_darat',
    'transport-provinsi': 'tarif_transport_provinsi',
  }
  return map[tab]
}

const filteredData = computed(() => {
  const list = activeData.value
  if (!search.value) return list
  const q = search.value.toLowerCase()
  return list.filter((item: any) =>
    Object.values(item)
      .filter((v) => typeof v === 'string')
      .some((v) => (v as string).toLowerCase().includes(q)) ||
    item.provinsi?.nama_provinsi?.toLowerCase().includes(q),
  )
})

const paginatedData = computed(() => {
  const start = (currentPage.value - 1) * perPage.value
  return filteredData.value.slice(start, start + perPage.value)
})

const currentDataPage = computed(() => currentPage.value)

const filteredHarian = computed(() => filteredData.value)
const paginatedHarian = computed(() => paginatedData.value)
const filteredPenginapan = computed(() => filteredData.value)
const paginatedPenginapan = computed(() => paginatedData.value)
const filteredPesawat = computed(() => filteredData.value)
const paginatedPesawat = computed(() => paginatedData.value)
const filteredTransportDarat = computed(() => filteredData.value)
const paginatedTransportDarat = computed(() => paginatedData.value)
const filteredTransportProvinsi = computed(() => filteredData.value)
const paginatedTransportProvinsi = computed(() => paginatedData.value)

const harianPage = computed(() => currentPage.value)
const penginapanPage = computed(() => currentPage.value)
const pesawatPage = computed(() => currentPage.value)
const transportDaratPage = computed(() => currentPage.value)
const transportProvinsiPage = computed(() => currentPage.value)

function onPageChange(page: number) {
  currentPage.value = page
}

function onPerPageChange(size: number) {
  perPage.value = size
  currentPage.value = 1
}

function formatRupiah(val: number): string {
  return new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR', maximumFractionDigits: 0 }).format(val)
}

function formatIndoNumber(val: number): string {
  return new Intl.NumberFormat('id-ID').format(val)
}

function startHarian(item: (typeof props.data.tarif_harian)[0]) {
  editState[item.id] = {
    luar_kota: item.luar_kota,
    dalam_kota_lebih_8_jam: item.dalam_kota_lebih_8_jam,
    diklat: item.diklat,
  }
}

function startPenginapan(item: (typeof props.data.tarif_penginapan)[0]) {
  editState[item.id] = {
    pejabat_negara_eselon_1: item.pejabat_negara_eselon_1,
    pejabat_lainnya_eselon_2: item.pejabat_lainnya_eselon_2,
    eselon_3_gol_4: item.eselon_3_gol_4,
    eselon_4_gol_3_2_1: item.eselon_4_gol_3_2_1,
  }
}

function startPesawat(item: (typeof props.data.tarif_pesawat)[0]) {
  editState[item.id] = {
    tarif_bisnis: item.tarif_bisnis,
    tarif_ekonomi: item.tarif_ekonomi,
  }
}

function startTransportDarat(item: (typeof props.data.tarif_transport_darat)[0]) {
  editState[item.id] = { besaran: item.besaran }
}

function startTransportProvinsi(item: (typeof props.data.tarif_transport_provinsi)[0]) {
  editState[item.id] = { besaran: item.besaran }
}

function cancelEdit(id: number) {
  delete editState[id]
}

async function saveHarian(item: (typeof props.data.tarif_harian)[0]) {
  try {
    await updateTarifHarian(item.id, editState[item.id])
    item.luar_kota = editState[item.id].luar_kota
    item.dalam_kota_lebih_8_jam = editState[item.id].dalam_kota_lebih_8_jam
    item.diklat = editState[item.id].diklat
    delete editState[item.id]
    success('Data tarif harian berhasil diperbarui.')
  } catch {
    error('Gagal menyimpan data tarif harian.')
  }
}

async function savePenginapan(item: (typeof props.data.tarif_penginapan)[0]) {
  try {
    await updateTarifPenginapan(item.id, editState[item.id])
    item.pejabat_negara_eselon_1 = editState[item.id].pejabat_negara_eselon_1
    item.pejabat_lainnya_eselon_2 = editState[item.id].pejabat_lainnya_eselon_2
    item.eselon_3_gol_4 = editState[item.id].eselon_3_gol_4
    item.eselon_4_gol_3_2_1 = editState[item.id].eselon_4_gol_3_2_1
    delete editState[item.id]
    success('Data tarif penginapan berhasil diperbarui.')
  } catch {
    error('Gagal menyimpan data tarif penginapan.')
  }
}

async function savePesawat(item: (typeof props.data.tarif_pesawat)[0]) {
  try {
    await updateTarifPesawat(item.id, editState[item.id])
    item.tarif_bisnis = editState[item.id].tarif_bisnis
    item.tarif_ekonomi = editState[item.id].tarif_ekonomi
    delete editState[item.id]
    success('Data tarif pesawat berhasil diperbarui.')
  } catch {
    error('Gagal menyimpan data tarif pesawat.')
  }
}

async function saveTransportDarat(item: (typeof props.data.tarif_transport_darat)[0]) {
  try {
    await updateTarifTransportDarat(item.id, editState[item.id])
    item.besaran = editState[item.id].besaran
    delete editState[item.id]
    success('Data tarif transport darat berhasil diperbarui.')
  } catch {
    error('Gagal menyimpan data tarif transport darat.')
  }
}

async function saveTransportProvinsi(item: (typeof props.data.tarif_transport_provinsi)[0]) {
  try {
    await updateTarifTransportProvinsi(item.id, editState[item.id])
    item.besaran = editState[item.id].besaran
    delete editState[item.id]
    success('Data tarif transport provinsi berhasil diperbarui.')
  } catch {
    error('Gagal menyimpan data tarif transport provinsi.')
  }
}
</script>

<style scoped>
.tab-icon-pop {
  animation: tab-icon-pop 0.45s cubic-bezier(0.34, 1.56, 0.64, 1);
}

@keyframes tab-icon-pop {
  0% {
    transform: scale(0.6) rotate(-8deg);
  }
  55% {
    transform: scale(1.18) rotate(4deg);
  }
  100% {
    transform: scale(1) rotate(0deg);
  }
}
</style>
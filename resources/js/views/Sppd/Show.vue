<template>
  <AdminLayout>
    <PageBreadcrumb :page-title="`SPPD ${sppd.nomor_sppd}`" />

    <div
      v-if="$page.props.flash?.success"
      class="mb-4 rounded-lg border border-green-200 bg-green-50 p-4 text-sm text-green-700 dark:border-green-800 dark:bg-green-900/30 dark:text-green-300"
    >
      {{ $page.props.flash.success }}
    </div>

    <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
      <div class="flex flex-wrap items-center gap-3">
        <StatusBadge :status="sppd.status" />
      </div>
      <div class="flex flex-wrap items-center gap-3">
        <Link
          href="/sppd"
          class="inline-flex items-center gap-2 rounded-lg border border-gray-300 bg-white px-4 py-2.5 text-sm font-medium text-gray-700 shadow-sm transition-colors hover:bg-gray-50 dark:border-gray-600 dark:bg-white/[0.03] dark:text-gray-200 dark:hover:bg-white/[0.06]"
        >
          Kembali
        </Link>
        <Link
          :href="`/sppd/${sppd.id}/cetak`"
          class="inline-flex items-center gap-2 rounded-lg bg-brand-500 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-brand-600 focus:outline-none focus:ring-2 focus:ring-brand-500 focus:ring-offset-2 dark:focus:ring-offset-gray-900"
        >
          Cetak SPPD
        </Link>
      </div>
    </div>

    <div class="mt-4 grid gap-6 md:grid-cols-2">
      <div class="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-white/[0.03]">
        <h3 class="mb-4 border-b border-gray-100 pb-3 text-base font-semibold text-gray-900 dark:border-gray-800 dark:text-white/90">
          Informasi SPPD
        </h3>
        <dl class="grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-2">
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Nomor SPPD</dt>
            <dd class="mt-1 text-sm font-semibold text-gray-900 dark:text-gray-100">{{ sppd.nomor_sppd }}</dd>
          </div>
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Status</dt>
            <dd class="mt-1"><StatusBadge :status="sppd.status" /></dd>
          </div>
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Atas Nama</dt>
            <dd class="mt-1 text-sm font-medium text-gray-900 dark:text-gray-100">{{ sppd.atas_nama }}</dd>
          </div>
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">NIP</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ sppd.nip || '-' }}</dd>
          </div>
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Pangkat / Golongan</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ sppd.pangkat_golongan || '-' }}</dd>
          </div>
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Jabatan</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ sppd.jabatan || '-' }}</dd>
          </div>
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Tanggal Mulai</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ formatTanggal(sppd.tanggal_mulai) }}</dd>
          </div>
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Tanggal Selesai</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ formatTanggal(sppd.tanggal_selesai) }}</dd>
          </div>
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Lama Hari</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ sppd.lama_hari }} hari</dd>
          </div>
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Asal Daerah</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ sppd.asal_daerah }}</dd>
          </div>
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Tujuan Daerah</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ sppd.tujuan_daerah }}</dd>
          </div>
          <div>
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Provinsi Tujuan</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">
              {{ getNamaProvinsi(sppd.provinsi_tujuan) }}
            </dd>
          </div>
          <div class="sm:col-span-2">
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Keperluan</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ sppd.keperluan || '-' }}</dd>
          </div>
          <div class="sm:col-span-2">
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Total Biaya</dt>
            <dd class="mt-1 text-lg font-semibold text-gray-900 dark:text-gray-100">{{ formatRupiah(sppd.total_biaya) }}</dd>
          </div>
          <div v-if="sppd.creator">
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Dibuat Oleh</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ sppd.creator.name }}</dd>
          </div>
          <div v-if="sppd.approver">
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Disetujui Oleh</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ sppd.approver.name }}</dd>
          </div>
          <div v-if="sppd.payer">
            <dt class="text-xs font-medium uppercase tracking-wide text-gray-500 dark:text-gray-400">Dibayar Oleh</dt>
            <dd class="mt-1 text-sm text-gray-700 dark:text-gray-300">{{ sppd.payer.name }}</dd>
          </div>
        </dl>
      </div>

      <div class="rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-white/[0.03]">
        <h3 class="mb-4 border-b border-gray-100 pb-2 text-base font-semibold text-gray-900 dark:border-gray-800 dark:text-white/90">
          Aksi
        </h3>
        <div class="flex flex-col gap-3">
          <button
            v-if="sppd.status === 'draft' && canEdit(menuUrl)"
            type="button"
            :disabled="updatingStatus"
            class="inline-flex items-center justify-center gap-2 rounded-lg bg-brand-500 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-brand-600 disabled:cursor-not-allowed disabled:opacity-60"
            @click="changeStatus('proses')"
          >
            Kirim / Proses SPPD
          </button>
          <button
            v-if="sppd.status === 'proses' && canEdit(menuUrl)"
            type="button"
            :disabled="updatingStatus"
            class="inline-flex items-center justify-center gap-2 rounded-lg bg-emerald-600 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-emerald-700 disabled:cursor-not-allowed disabled:opacity-60"
            @click="changeStatus('selesai')"
          >
            Tandai Selesai
          </button>
          <button
            v-if="sppd.status !== 'batal' && canDelete(menuUrl)"
            type="button"
            :disabled="updatingStatus"
            class="inline-flex items-center justify-center gap-2 rounded-lg bg-red-600 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-red-700 disabled:cursor-not-allowed disabled:opacity-60"
            @click="changeStatus('batal')"
          >
            Batalkan SPPD
          </button>
          <p v-if="canEdit(menuUrl) || canDelete(menuUrl)" class="mt-2 text-xs text-gray-500 dark:text-gray-400">
            Ubah status untuk melanjutkan alur persetujuan SPPD.
          </p>

          <div class="mt-1 border-t border-gray-100 pt-4 dark:border-gray-800">
            <h4 class="mb-3 text-xs font-semibold uppercase tracking-wide text-gray-500 dark:text-gray-400">
              Kelengkapan Dokumen
            </h4>
            <div class="flex flex-col gap-4">
              <FileDropzone
                label="Surat Tugas"
                :url="sppd.file_surat_tugas_url"
                :editable="canEdit(menuUrl)"
                :busy="uploadingJenis === 'surat_tugas'"
                @select="handleDokumenSelected('surat_tugas', $event)"
                @remove="handleDokumenRemove('surat_tugas')"
              />
              <FileDropzone
                label="SPPD"
                :url="sppd.file_sppd_url"
                :editable="canEdit(menuUrl)"
                :busy="uploadingJenis === 'sppd'"
                @select="handleDokumenSelected('sppd', $event)"
                @remove="handleDokumenRemove('sppd')"
              />
              <FileDropzone
                label="Laporan"
                :url="sppd.file_laporan_url"
                :editable="canEdit(menuUrl)"
                :busy="uploadingJenis === 'laporan'"
                @select="handleDokumenSelected('laporan', $event)"
                @remove="handleDokumenRemove('laporan')"
              />
            </div>
            <p v-if="dokumenError" class="mt-3 text-sm text-red-600 dark:text-red-400">{{ dokumenError }}</p>
          </div>
        </div>
      </div>
    </div>

    <div class="mt-6 rounded-xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-white/[0.03]">
      <div class="mb-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <h3 class="text-base font-semibold text-gray-900 dark:text-white/90">Rincian Biaya</h3>
        <button
          v-if="sppd.status === 'draft' && canEdit(menuUrl)"
          type="button"
          class="inline-flex items-center justify-center gap-2 rounded-lg border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 transition-colors hover:bg-gray-50 dark:border-gray-600 dark:bg-white/[0.03] dark:text-gray-200 dark:hover:bg-white/[0.06]"
          @click="showCalcForm = !showCalcForm"
        >
          {{ showCalcForm ? 'Tutup Form' : 'Hitung & Simpan Rincian' }}
        </button>
      </div>

      <input
        ref="buktiInput"
        type="file"
        accept=".pdf,.jpg,.jpeg,.png,.webp"
        class="hidden"
        @change="onBuktiSelected"
      />

      <p v-if="uploadError" class="mb-4 rounded-lg bg-red-50 px-4 py-2.5 text-sm text-red-600 dark:bg-red-500/10 dark:text-red-400">
        {{ uploadError }}
      </p>

      <div v-if="showCalcForm" class="mb-6 rounded-lg border border-gray-200 bg-gray-50 p-4 dark:border-gray-700 dark:bg-white/[0.03]">
        <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
          <div>
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Provinsi Tujuan</label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <FlagIcon class="h-4 w-4" />
              </span>
              <select
                v-model="calcForm.provinsi_tujuan"
                class="w-full rounded-lg border border-gray-300 bg-white px-3 py-2 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900 dark:text-gray-100 dark:focus:border-blue-400"
              >
              <option v-for="item in provinsi" :key="item.id_provinsi" :value="item.id_provinsi">
                {{ item.nama_provinsi }}
              </option>
            </select>
          </div>
          </div>
          <div>
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Mulai</label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <CalenderIcon class="h-4 w-4" />
              </span>
              <input
                v-model="calcForm.tanggal_mulai"
                type="date"
                class="w-full rounded-lg border border-gray-300 bg-white px-3 py-2 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900 dark:text-gray-100 dark:focus:border-blue-400"
              />
            </div>
          </div>
          <div>
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Tanggal Selesai</label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <CalenderIcon class="h-4 w-4" />
              </span>
              <input
                v-model="calcForm.tanggal_selesai"
                type="date"
                class="w-full rounded-lg border border-gray-300 bg-white px-3 py-2 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900 dark:text-gray-100 dark:focus:border-blue-400"
              />
            </div>
          </div>
          <div>
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Golongan</label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <BarChartIcon class="h-4 w-4" />
              </span>
              <select
                v-model="calcForm.golongan"
                class="w-full rounded-lg border border-gray-300 bg-white px-3 py-2 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900 dark:text-gray-100 dark:focus:border-blue-400"
              >
              <option v-for="opt in golonganOptions" :key="opt.value" :value="opt.value">
                {{ opt.label }}
              </option>
            </select>
          </div>
          </div>
          <div v-if="calcForm.transport_udara">
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Kota Asal Penerbangan</label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <SendIcon class="h-4 w-4" />
              </span>
              <input
                v-model="calcForm.kota_asal_pesawat"
                type="text"
                placeholder="Contoh: Banda Aceh"
                class="w-full rounded-lg border border-gray-300 bg-white px-3 py-2 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900 dark:text-gray-100 dark:focus:border-blue-400"
              />
            </div>
          </div>
          <div v-if="calcForm.transport_udara">
            <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Kota Tujuan Penerbangan</label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <BoxCubeIcon class="h-4 w-4" />
              </span>
              <input
                v-model="calcForm.kota_tujuan_pesawat"
                type="text"
                placeholder="Contoh: Jakarta"
                class="w-full rounded-lg border border-gray-300 bg-white px-3 py-2 pl-10 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900 dark:text-gray-100 dark:focus:border-blue-400"
              />
            </div>
          </div>
        </div>

        <div class="mt-4 flex flex-wrap items-center gap-5">
          <label class="flex items-center gap-2 text-sm text-gray-700 dark:text-gray-300">
            <input v-model="calcForm.transport_udara" type="checkbox" class="h-4 w-4 rounded border-gray-300 text-blue-600 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900" />
            Transport Udara
          </label>
          <label class="flex items-center gap-2 text-sm text-gray-700 dark:text-gray-300">
            <input v-model="calcForm.transport_darat_pp" type="checkbox" class="h-4 w-4 rounded border-gray-300 text-blue-600 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900" />
            Transport Darat PP (Lokal Tujuan)
          </label>
          <label class="flex items-center gap-2 text-sm text-gray-700 dark:text-gray-300">
            <input v-model="calcForm.taksi_bandara" type="checkbox" class="h-4 w-4 rounded border-gray-300 text-blue-600 focus:ring-brand-500 dark:border-gray-600 dark:bg-gray-900" />
            Taksi Bandara
          </label>
        </div>

        <div class="mt-4 flex flex-wrap items-center gap-3">
          <button
            type="button"
            :disabled="calculating"
            class="inline-flex items-center gap-2 rounded-lg bg-brand-500 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-brand-600 disabled:cursor-not-allowed disabled:opacity-60"
            @click="handleCalculate"
          >
            {{ calculating ? 'Menghitung...' : 'Hitung Rincian' }}
          </button>
          <button
            v-if="calcResult"
            type="button"
            :disabled="savingRincian"
            class="inline-flex items-center gap-2 rounded-lg bg-emerald-600 px-4 py-2.5 text-sm font-medium text-white shadow-sm transition-colors hover:bg-emerald-700 disabled:cursor-not-allowed disabled:opacity-60"
            @click="handleSaveRincian"
          >
            {{ savingRincian ? 'Menyimpan...' : 'Simpan Rincian' }}
          </button>
        </div>

        <p v-if="calcError" class="mt-3 text-sm text-red-600 dark:text-red-400">{{ calcError }}</p>

        <div v-if="calcResult" class="mt-4 overflow-x-auto rounded-lg border border-gray-200 bg-white dark:border-gray-700 dark:bg-gray-900">
          <table class="w-full table-auto text-left">
            <thead>
              <tr class="border-b border-gray-200 bg-gray-50 dark:border-gray-700 dark:bg-white/[0.04]">
                <th class="px-3 py-2 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">No</th>
                <th class="px-3 py-2 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Uraian</th>
                <th class="px-3 py-2 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Hari</th>
                <th class="px-3 py-2 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Satuan</th>
                <th class="px-3 py-2 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Jumlah</th>
                <th class="px-3 py-2 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Keterangan</th>
                <th class="px-3 py-2 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Bukti</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(item, index) in calcResult.rincian" :key="index" class="border-b border-gray-100 dark:border-gray-800">
                <td class="px-3 py-2 text-sm text-gray-700 dark:text-gray-300">{{ index + 1 }}</td>
                <td class="px-3 py-2 text-sm text-gray-700 dark:text-gray-300">{{ item.uraian }}</td>
                <td class="px-3 py-2 text-right text-sm text-gray-700 dark:text-gray-300">{{ item.hari }}</td>
                <td class="px-3 py-2 text-right text-sm text-gray-700 dark:text-gray-300">{{ formatRupiah(item.satuan) }}</td>
                <td class="px-3 py-2 text-right text-sm font-medium text-gray-900 dark:text-gray-100">{{ formatRupiah(item.jumlah) }}</td>
                <td class="px-3 py-2 text-sm text-gray-700 dark:text-gray-300">{{ item.keterangan }}</td>
                <td class="px-3 py-2">
                  <div class="flex items-center justify-center gap-2">
                    <template v-if="item.bukti_url">
                      <a
                        :href="item.bukti_url"
                        target="_blank"
                        rel="noopener"
                        class="inline-flex items-center gap-1.5 text-xs font-medium text-brand-600 hover:underline dark:text-brand-400"
                        title="Lihat bukti"
                      >
                        <PaperclipIcon class="h-4 w-4" />
                        Lihat
                      </a>
                      <button
                        type="button"
                        class="text-gray-400 transition-colors hover:text-error-500 dark:hover:text-error-500"
                        title="Hapus bukti"
                        @click="removeBukti('calc', index)"
                      >
                        <TrashIcon class="h-4 w-4" />
                      </button>
                    </template>
                    <button
                      v-else
                      type="button"
                      :disabled="uploadingKey === `calc-${index}`"
                      class="inline-flex items-center gap-1.5 rounded-lg border border-gray-300 px-2.5 py-1.5 text-xs font-medium text-gray-600 transition-colors hover:bg-gray-50 disabled:cursor-not-allowed disabled:opacity-60 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-white/[0.05]"
                      title="Unggah bukti"
                      @click="triggerUpload('calc', index)"
                    >
                      <PaperclipIcon class="h-3.5 w-3.5" />
                      {{ uploadingKey === `calc-${index}` ? 'Mengunggah...' : 'Upload' }}
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
            <tfoot>
              <tr class="bg-gray-50 dark:bg-white/[0.04]">
                <td colspan="4" class="px-3 py-2 text-right text-sm font-semibold text-gray-900 dark:text-gray-100">Total Biaya</td>
                <td class="px-3 py-2 text-right text-sm font-semibold text-gray-900 dark:text-gray-100">{{ formatRupiah(calcResult.total_biaya) }}</td>
                <td class="px-3 py-2 text-sm text-gray-600 dark:text-gray-400">Lama: {{ calcResult.lama_hari }} hari</td>
                <td class="px-3 py-2"></td>
              </tr>
              <tr v-if="calcResult.terbilang">
                <td colspan="7" class="px-3 py-2 text-sm italic text-gray-600 dark:text-gray-400">
                  Terbilang: {{ calcResult.terbilang }}
                </td>
              </tr>
            </tfoot>
          </table>
        </div>
      </div>

      <div v-if="sppd.rincian && sppd.rincian.length > 0" class="overflow-x-auto">
        <table class="w-full table-auto text-left">
          <thead>
            <tr class="border-b border-gray-200 bg-gradient-to-r from-gray-50 to-gray-100/80 dark:border-gray-700 dark:from-white/[0.05] dark:to-white/[0.02]">
              <th class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">No</th>
              <th class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Uraian</th>
              <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Hari</th>
              <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Satuan</th>
              <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Jumlah</th>
              <th class="px-4 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Keterangan</th>
              <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Bukti</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in sppd.rincian" :key="item.id" class="border-b border-gray-100 transition-colors hover:bg-gray-50/50 dark:border-gray-800 dark:hover:bg-white/[0.02]">
              <td class="px-4 py-3 text-sm text-gray-700 dark:text-gray-300">{{ index + 1 }}</td>
              <td class="px-4 py-3 text-sm text-gray-700 dark:text-gray-300">{{ item.uraian }}</td>
              <td class="px-4 py-3 text-right text-sm text-gray-700 dark:text-gray-300">{{ item.hari }}</td>
              <td class="px-4 py-3 text-right text-sm text-gray-700 dark:text-gray-300">{{ formatRupiah(item.satuan) }}</td>
              <td class="px-4 py-3 text-right text-sm font-medium text-gray-900 dark:text-gray-100">{{ formatRupiah(item.jumlah) }}</td>
              <td class="px-4 py-3 text-sm text-gray-700 dark:text-gray-300">{{ item.keterangan || '-' }}</td>
              <td class="px-4 py-3">
                <div class="flex items-center justify-center gap-2">
                  <a
                    v-if="item.bukti_url"
                    :href="item.bukti_url"
                    target="_blank"
                    rel="noopener"
                    class="inline-flex items-center gap-1.5 text-sm font-medium text-brand-600 hover:underline dark:text-brand-400"
                    title="Lihat bukti"
                  >
                    <PaperclipIcon class="h-4 w-4" />
                    Lihat
                  </a>
                  <button
                    v-if="canEdit(menuUrl) && item.bukti_url"
                    type="button"
                    class="text-gray-400 transition-colors hover:text-error-500 dark:hover:text-error-500"
                    title="Hapus bukti"
                    @click="removeBukti('saved', index)"
                  >
                    <TrashIcon class="h-4 w-4" />
                  </button>
                  <button
                    v-else-if="canEdit(menuUrl)"
                    type="button"
                    :disabled="uploadingKey === `saved-${index}`"
                    class="inline-flex items-center gap-1.5 rounded-lg border border-gray-300 px-2.5 py-1.5 text-xs font-medium text-gray-600 transition-colors hover:bg-gray-50 disabled:cursor-not-allowed disabled:opacity-60 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-white/[0.05]"
                    title="Unggah bukti"
                    @click="triggerUpload('saved', index)"
                  >
                    <PaperclipIcon class="h-3.5 w-3.5" />
                    {{ uploadingKey === `saved-${index}` ? 'Mengunggah...' : 'Upload' }}
                  </button>
                  <span v-if="!item.bukti_url && !canEdit(menuUrl)" class="text-xs text-gray-400 dark:text-gray-500">-</span>
                </div>
              </td>
            </tr>
          </tbody>
          <tfoot>
            <tr class="bg-gray-50 dark:bg-white/[0.04]">
              <td colspan="4" class="px-4 py-3 text-right text-sm font-semibold text-gray-900 dark:text-gray-100">Total Biaya</td>
              <td class="px-4 py-3 text-right text-sm font-semibold text-gray-900 dark:text-gray-100">{{ formatRupiah(sppd.total_biaya) }}</td>
              <td class="px-4 py-3" colspan="2"></td>
            </tr>
          </tfoot>
        </table>
      </div>
      <EmptyState v-else message="Belum ada rincian biaya untuk SPPD ini." />
    </div>
  </AdminLayout>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import AdminLayout from '../../components/layout/AdminLayout.vue'
import PageBreadcrumb from '@/components/common/PageBreadcrumb.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import StatusBadge from '@/components/ui/StatusBadge.vue'
import FileDropzone from '@/components/ui/FileDropzone.vue'
import { calculateSppd, storeRincian, updateSppd, uploadBukti, uploadDokumen, deleteDokumen } from '@/api/sppd'
import type { CalculatePayload, Golongan, CalculateResult, FileDokumenJenis } from '@/types/sppd'
import { router, Link } from '@inertiajs/vue3'
import { usePermission } from '@/composables/usePermission'
import FlagIcon from '@/icons/FlagIcon.vue'
import CalenderIcon from '@/icons/CalenderIcon.vue'
import BarChartIcon from '@/icons/BarChartIcon.vue'
import SendIcon from '@/icons/SendIcon.vue'
import BoxCubeIcon from '@/icons/BoxCubeIcon.vue'
import PaperclipIcon from '@/icons/PaperclipIcon.vue'
import TrashIcon from '@/icons/TrashIcon.vue'

interface SppdProp {
  id: number
  nomor_sppd: string
  atas_nama: string
  nip: string | null
  pangkat_golongan: string | null
  jabatan: string | null
  tanggal_mulai: string
  tanggal_selesai: string
  lama_hari: number
  asal_daerah: string
  tujuan_daerah: string
  provinsi_tujuan: number
  keperluan: string | null
  status: 'draft' | 'proses' | 'selesai' | 'batal'
  total_biaya: number
  created_at: string
  file_surat_tugas?: string | null
  file_sppd?: string | null
  file_laporan?: string | null
  file_surat_tugas_url?: string | null
  file_sppd_url?: string | null
  file_laporan_url?: string | null
  provinsi?: { id_provinsi: number; nama_provinsi: string } | null
  rincian?: {
    id: number
    jenis_biaya: string
    uraian: string
    hari: number
    satuan: number
    jumlah: number
    keterangan: string | null
    bukti: string | null
    bukti_url: string | null
  }[]
  creator?: { id: number; name: string } | null
  approver?: { id: number; name: string } | null
  payer?: { id: number; name: string } | null
}

const props = defineProps<{
  sppd: SppdProp
  provinsi: { id_provinsi: number; nama_provinsi: string }[]
}>()

const { canEdit, canDelete } = usePermission()
const menuUrl = '/sppd'

const formatRupiah = (value: number): string => {
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumFractionDigits: 0,
  }).format(value)
}

const formatTanggal = (dateStr: string): string => {
  if (!dateStr) return '-'
  const date = new Date(dateStr)
  return date.toLocaleDateString('id-ID', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
  })
}

const getNamaProvinsi = (id: number): string => {
  const found = props.provinsi.find((item) => item.id_provinsi === id)
  return found ? found.nama_provinsi : '-'
}

const golonganOptions: { value: Golongan; label: string }[] = [
  { value: 'eselon_1', label: 'Eselon I / Pejabat Negara' },
  { value: 'eselon_2', label: 'Eselon II' },
  { value: 'eselon_3', label: 'Eselon III' },
  { value: 'eselon_4', label: 'Eselon IV / Golongan III, II, I' },
]

const showCalcForm = ref(false)

const calcForm = ref<{
  provinsi_tujuan: number
  tanggal_mulai: string
  tanggal_selesai: string
  golongan: Golongan
  transport_udara: boolean
  transport_darat_pp: boolean
  taksi_bandara: boolean
  kota_asal_pesawat: string
  kota_tujuan_pesawat: string
}>({
  provinsi_tujuan: props.sppd.provinsi_tujuan,
  tanggal_mulai: props.sppd.tanggal_mulai,
  tanggal_selesai: props.sppd.tanggal_selesai,
  golongan: 'eselon_4',
  transport_udara: false,
  transport_darat_pp: false,
  taksi_bandara: false,
  kota_asal_pesawat: '',
  kota_tujuan_pesawat: '',
})

const calculating = ref(false)
const calcResult = ref<CalculateResult | null>(null)
const calcError = ref('')
const savingRincian = ref(false)
const updatingStatus = ref(false)
const buktiInput = ref<HTMLInputElement | null>(null)
const uploadTarget = ref<{ scope: 'saved' | 'calc'; index: number } | null>(null)
const uploadingKey = ref<string | null>(null)
const uploadError = ref('')
const uploadingJenis = ref<FileDokumenJenis | null>(null)
const dokumenError = ref('')

const handleDokumenSelected = async (jenis: FileDokumenJenis, file: File): Promise<void> => {
  uploadingJenis.value = jenis
  dokumenError.value = ''
  try {
    await uploadDokumen(props.sppd.id, jenis, file)
    router.reload()
  } catch {
    const labelMap: Record<FileDokumenJenis, string> = {
      surat_tugas: 'Surat Tugas',
      sppd: 'SPPD',
      laporan: 'Laporan',
    }
    const nama = labelMap[jenis]
    dokumenError.value = `Gagal mengunggah dokumen ${nama}. Gunakan format PDF/JPG/PNG/WEBP maksimal 10 MB.`
  } finally {
    uploadingJenis.value = null
  }
}

const handleDokumenRemove = async (jenis: FileDokumenJenis): Promise<void> => {
  const labelMap: Record<FileDokumenJenis, string> = {
    surat_tugas: 'Surat Tugas',
    sppd: 'SPPD',
    laporan: 'Laporan',
  }
  const nama = labelMap[jenis]
  if (!window.confirm(`Hapus dokumen ${nama}?`)) return
  uploadingJenis.value = jenis
  dokumenError.value = ''
  try {
    await deleteDokumen(props.sppd.id, jenis)
    router.reload()
  } catch {
    dokumenError.value = 'Gagal menghapus dokumen. Silakan coba lagi.'
  } finally {
    uploadingJenis.value = null
  }
}

const triggerUpload = (scope: 'saved' | 'calc', index: number): void => {
  uploadTarget.value = { scope, index }
  uploadError.value = ''
  buktiInput.value?.click()
}

const onBuktiSelected = async (event: Event): Promise<void> => {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]
  input.value = ''
  const target = uploadTarget.value
  if (!file || !target) return
  uploadingKey.value = `${target.scope}-${target.index}`
  uploadError.value = ''
  try {
    const res = await uploadBukti(file)
    if (target.scope === 'calc') {
      const item = calcResult.value?.rincian[target.index]
      if (item) {
        item.bukti = res.path
        item.bukti_url = res.url
      }
    } else {
      const list = (props.sppd.rincian ?? []).map((item, index) =>
        index === target.index ? { ...item, bukti: res.path, bukti_url: res.url } : item,
      )
      await storeRincian(props.sppd.id, list)
      router.reload()
    }
  } catch {
    uploadError.value = 'Gagal mengunggah bukti. Gunakan format PDF/JPG/PNG/WEBP maksimal 5 MB.'
  } finally {
    uploadingKey.value = null
    uploadTarget.value = null
  }
}

const removeBukti = async (scope: 'saved' | 'calc', index: number): Promise<void> => {
  uploadError.value = ''
  if (scope === 'calc') {
    const item = calcResult.value?.rincian[index]
    if (item) {
      item.bukti = null
      item.bukti_url = null
    }
    return
  }
  const list = (props.sppd.rincian ?? []).map((item, i) =>
    i === index ? { ...item, bukti: null, bukti_url: null } : item,
  )
  try {
    await storeRincian(props.sppd.id, list)
    router.reload()
  } catch {
    uploadError.value = 'Gagal menghapus bukti. Silakan coba lagi.'
  }
}

const handleCalculate = async (): Promise<void> => {
  calculating.value = true
  calcError.value = ''
  try {
    const payload: CalculatePayload = {
      provinsi_tujuan: calcForm.value.provinsi_tujuan,
      tanggal_mulai: calcForm.value.tanggal_mulai,
      tanggal_selesai: calcForm.value.tanggal_selesai,
      golongan: calcForm.value.golongan,
      transport_udara: calcForm.value.transport_udara || undefined,
      transport_darat_pp: calcForm.value.transport_darat_pp || undefined,
      taksi_bandara: calcForm.value.taksi_bandara || undefined,
      kota_asal_pesawat: calcForm.value.kota_asal_pesawat || null,
      kota_tujuan_pesawat: calcForm.value.kota_tujuan_pesawat || null,
    }
    calcResult.value = await calculateSppd(payload)
  } catch {
    calcError.value = 'Gagal menghitung rincian. Periksa kembali data yang diisi.'
  } finally {
    calculating.value = false
  }
}

const handleSaveRincian = async (): Promise<void> => {
  if (!calcResult.value) return
  savingRincian.value = true
  try {
    await storeRincian(props.sppd.id, calcResult.value.rincian)
    router.reload()
  } catch {
    calcError.value = 'Gagal menyimpan rincian. Silakan coba lagi.'
  } finally {
    savingRincian.value = false
  }
}

const changeStatus = async (status: 'proses' | 'selesai' | 'batal'): Promise<void> => {
  updatingStatus.value = true
  try {
    await updateSppd(props.sppd.id, { status } as never)
    router.reload()
  } catch {
    calcError.value = 'Gagal mengubah status SPPD.'
  } finally {
    updatingStatus.value = false
  }
}
</script>
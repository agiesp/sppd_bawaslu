<template>
  <AdminLayout>
    <PageBreadcrumb :pageTitle="pageTitle" />

    <div
      v-if="page.props.flash?.success"
      class="mb-4 rounded-lg border border-green-200 bg-green-50 p-4 text-sm text-green-700 dark:border-green-800 dark:bg-green-900/30 dark:text-green-300"
    >
      {{ page.props.flash.success }}
    </div>

    <form novalidate @submit.prevent="handleSimpan">
      <div
        class="rounded-2xl border border-gray-200 bg-white p-6 dark:border-gray-800 dark:bg-white/[0.03]"
      >
        <div class="mb-6">
          <h3 class="text-base font-semibold text-gray-800 dark:text-white/90">Data SPPD</h3>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            {{ deskripsiData }}
          </p>
        </div>

        <div class="grid grid-cols-1 gap-5 lg:grid-cols-2">
          <div class="lg:col-span-2">
            <label for="pegawai" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Pilih Pegawai <span class="text-xs font-normal text-gray-400 dark:text-gray-500">(opsional, isi otomatis)</span>
            </label>
            <PegawaiSelect v-model="selectedPegawaiId" :pegawais="pegawais" @change="onPegawaiChange" />
          </div>

          <div class="lg:col-span-2">
            <label for="nomor_sppd" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Nomor SPPD <span v-if="!isEdit" class="text-xs font-normal text-gray-400 dark:text-gray-500">(opsional, dibuat otomatis jika kosong)</span>
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <DocsIcon class="h-4 w-4" />
              </span>
              <input
                id="nomor_sppd"
                v-model="form.nomor_sppd"
                type="text"
                placeholder="Contoh: SPD-26090001"
                :class="[inputClass, { 'border-error-500 focus:border-error-500 focus:ring-error-500/10': form.errors.nomor_sppd }]"
              />
            </div>
            <p v-if="form.errors.nomor_sppd" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.nomor_sppd }}
            </p>
          </div>

          <div>
            <label for="atas_nama" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Atas Nama<span class="text-error-500">*</span>
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <UserCircleIcon class="h-4 w-4" />
              </span>
              <input
                id="atas_nama"
                v-model="form.atas_nama"
                type="text"
                placeholder="Nama pelaksana dinas"
                :class="[inputClass, { 'border-error-500 focus:border-error-500 focus:ring-error-500/10': form.errors.atas_nama }]"
              />
            </div>
            <p v-if="form.errors.atas_nama" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.atas_nama }}
            </p>
          </div>

          <div>
            <label for="nip" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              NIP
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <GridIcon class="h-4 w-4" />
              </span>
              <input
                id="nip"
                v-model="form.nip"
                type="text"
                placeholder="Nomor Induk Pegawai"
                :class="inputClass"
              />
            </div>
            <p v-if="form.errors.nip" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.nip }}
            </p>
          </div>

          <div>
            <label for="pangkat_golongan" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Pangkat / Golongan
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <BarChartIcon class="h-4 w-4" />
              </span>
              <input
                id="pangkat_golongan"
                v-model="form.pangkat_golongan"
                type="text"
                placeholder="Pangkat dan golongan"
                :class="inputClass"
              />
            </div>
            <p v-if="form.errors.pangkat_golongan" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.pangkat_golongan }}
            </p>
          </div>

          <div>
            <label for="jabatan" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Jabatan
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <UserGroupIcon class="h-4 w-4" />
              </span>
              <input
                id="jabatan"
                v-model="form.jabatan"
                type="text"
                placeholder="Jabatan pelaksana dinas"
                :class="inputClass"
              />
            </div>
            <p v-if="form.errors.jabatan" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.jabatan }}
            </p>
          </div>

          <div>
            <label for="tanggal_mulai" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Tanggal Mulai<span class="text-error-500">*</span>
            </label>
            <DatePicker
              id="tanggal_mulai"
              v-model="form.tanggal_mulai"
              placeholder="Pilih tanggal mulai"
              :error="!!form.errors.tanggal_mulai"
            />
            <p v-if="form.errors.tanggal_mulai" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.tanggal_mulai }}
            </p>
          </div>

          <div>
            <label for="tanggal_selesai" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Tanggal Selesai<span class="text-error-500">*</span>
            </label>
            <DatePicker
              id="tanggal_selesai"
              v-model="form.tanggal_selesai"
              placeholder="Pilih tanggal selesai"
              :error="!!form.errors.tanggal_selesai"
            />
            <p v-if="form.errors.tanggal_selesai" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.tanggal_selesai }}
            </p>
          </div>

          <div>
            <label for="provinsi_tujuan" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Provinsi Tujuan<span class="text-error-500">*</span>
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <FlagIcon class="h-4 w-4" />
              </span>
              <select
                id="provinsi_tujuan"
                v-model="form.provinsi_tujuan"
                @change="onProvinsiChange"
                :class="[inputClass, { 'border-error-500 focus:border-error-500 focus:ring-error-500/10': form.errors.provinsi_tujuan }]"
              >
                <option value="">-- Pilih Provinsi --</option>
                <option v-for="p in provinsi" :key="p.id_provinsi" :value="p.id_provinsi">
                  {{ p.id_provinsi }} - {{ p.nama_provinsi }}
                </option>
              </select>
            </div>
            <p v-if="form.errors.provinsi_tujuan" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.provinsi_tujuan }}
            </p>
          </div>

          <div>
            <label for="tujuan_daerah" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Tujuan Daerah<span class="text-error-500">*</span>
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <GridIcon class="h-4 w-4" />
              </span>
              <input
                id="tujuan_daerah"
                v-model="form.tujuan_daerah"
                type="text"
                placeholder="Ibu kota provinsi tujuan"
                :class="[inputClass, { 'border-error-500 focus:border-error-500 focus:ring-error-500/10': form.errors.tujuan_daerah }]"
              />
            </div>
            <p v-if="form.errors.tujuan_daerah" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.tujuan_daerah }}
            </p>
          </div>

          <div class="lg:col-span-2">
            <label for="keperluan" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Keperluan
            </label>
            <div class="group relative">
              <span
                class="absolute left-0 top-3.5 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <DocsIcon class="h-4 w-4" />
              </span>
              <textarea
                id="keperluan"
                v-model="form.keperluan"
                rows="3"
                placeholder="Keperluan perjalanan dinas"
                :class="inputClass"
              ></textarea>
            </div>
            <p v-if="form.errors.keperluan" class="mt-1.5 text-sm text-red-600 dark:text-red-400">
              {{ form.errors.keperluan }}
            </p>
          </div>
        </div>
      </div>

      <div
        class="mt-6 rounded-2xl border border-gray-200 bg-white p-6 dark:border-gray-800 dark:bg-white/[0.03]"
      >
        <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <h3 class="text-base font-semibold text-gray-800 dark:text-white/90">Perhitungan Biaya</h3>
            <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
              Atur parameter perjalanan dinas lalu hitung estimasi biaya. Baris Uang Saku dan Tiket Pesawat muncul di tabel rincian, nominal (Rp) dan jumlah hari dapat diubah langsung.
            </p>
          </div>
          <button
            type="button"
            :disabled="calculating"
            class="inline-flex items-center justify-center gap-2 rounded-lg bg-brand-500 px-5 py-2.5 text-sm font-medium text-white shadow-theme-xs transition-colors hover:bg-brand-600 disabled:cursor-not-allowed disabled:bg-brand-300"
            @click="handleCalculate"
          >
            {{ calculating ? 'Menghitung...' : 'Hitung Biaya' }}
          </button>
        </div>

       

        <div class="grid grid-cols-1 gap-5 lg:grid-cols-3 mt-6">
          <div>
            <label for="golongan" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
              Golongan
            </label>
            <div class="group relative">
              <span
                class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
              >
                <BarChartIcon class="h-4 w-4" />
              </span>
              <select id="golongan" v-model="golongan" :class="inputClass">
                <option v-for="opt in golonganOptions" :key="opt.value" :value="opt.value">
                  {{ opt.label }}
                </option>
              </select>
            </div>
          </div>

          
        </div>

         <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400 mt-6">
          Jenis SPPD<span class="text-error-500">*</span>
        </label>

        <div class="grid grid-cols-1 gap-3 sm:grid-cols-2 ">
          <label class="group relative flex cursor-pointer select-none items-center gap-3 rounded-xl border p-3.5 transition-all duration-200" :class="jenisSppdCard('dalam')">
            <input v-model="jenisSppd" type="radio" name="jenis_sppd" value="dalam" class="peer sr-only" />
            <span
              class="flex h-5 w-5 shrink-0 items-center justify-center rounded-full border-2 transition-all duration-200"
              :class="jenisSppd === 'dalam' ? 'border-brand-500' : 'border-gray-300 group-hover:border-brand-400 dark:border-gray-600'"
            >
              <span class="h-2.5 w-2.5 rounded-full transition-all duration-200" :class="jenisSppd === 'dalam' ? 'scale-100 bg-brand-500' : 'scale-50 bg-transparent'"></span>
            </span>
            <span class="block">
              <span class="block text-sm font-medium" :class="jenisSppd === 'dalam' ? 'text-brand-700 dark:text-brand-300' : 'text-gray-700 dark:text-gray-300'">SPPD Dalam Daerah</span>
              <span class="block text-xs text-gray-400">Tanpa pesawat, taksi & uang saku</span>
            </span>
          </label>

          <label class="group relative flex cursor-pointer select-none items-center gap-3 rounded-xl border p-3.5 transition-all duration-200" :class="jenisSppdCard('luar')">
            <input v-model="jenisSppd" type="radio" name="jenis_sppd" value="luar" class="peer sr-only" />
            <span
              class="flex h-5 w-5 shrink-0 items-center justify-center rounded-full border-2 transition-all duration-200"
              :class="jenisSppd === 'luar' ? 'border-brand-500' : 'border-gray-300 group-hover:border-brand-400 dark:border-gray-600'"
            >
              <span class="h-2.5 w-2.5 rounded-full transition-all duration-200" :class="jenisSppd === 'luar' ? 'scale-100 bg-brand-500' : 'scale-50 bg-transparent'"></span>
            </span>
            <span class="block">
              <span class="block text-sm font-medium" :class="jenisSppd === 'luar' ? 'text-brand-700 dark:text-brand-300' : 'text-gray-700 dark:text-gray-300'">SPPD Luar Daerah</span>
              <span class="block text-xs text-gray-400">Boleh pakai pesawat, taksi & uang saku</span>
            </span>
          </label>
        </div>

        

        <div class="mt-6">
          <div class="mb-3 flex items-center gap-2">
            <h4 class="text-sm font-semibold text-gray-800 dark:text-white/90">Transportasi</h4>
            <span class="rounded-full bg-gray-100 px-2 py-0.5 text-[11px] font-medium text-gray-500 dark:bg-gray-800 dark:text-gray-400">opsional</span>
          </div>

          <div class="grid grid-cols-1 gap-3 sm:grid-cols-2">
            <label
              class="group relative flex cursor-pointer select-none items-center gap-3 rounded-xl border p-3.5 transition-all duration-200"
              :class="[
                daerahDalam
                  ? 'pointer-events-none cursor-not-allowed border-gray-200 bg-gray-50 opacity-50 dark:border-gray-700 dark:bg-gray-800 dark:opacity-40'
                  : '',
                transportUdara
                  ? 'border-brand-500 bg-brand-50/80 shadow-sm ring-1 ring-brand-500/20 dark:border-brand-500 dark:bg-brand-500/10 dark:ring-brand-500/30'
                  : 'border-gray-200 bg-white hover:border-brand-300 hover:bg-brand-50/40 dark:border-gray-700 dark:bg-white/[0.02] dark:hover:border-brand-500/40 dark:hover:bg-brand-500/5',
              ]"
            >
              <input v-model="transportUdara" type="checkbox" class="peer sr-only" :disabled="daerahDalam" />
              <span
                class="flex h-5 w-5 shrink-0 items-center justify-center rounded-md border-2 transition-all duration-200"
                :class="
                  transportUdara
                    ? 'border-transparent bg-gradient-to-br from-brand-500 to-brand-400 shadow-sm shadow-brand-500/40'
                    : 'border-gray-300 bg-white group-hover:border-brand-400 group-hover:shadow-sm dark:border-gray-600 dark:bg-white/[0.05]'
                "
              >
                <CheckIcon
                  class="h-3.5 w-3.5 transition-all duration-200"
                  :class="transportUdara ? 'scale-100 opacity-100' : 'scale-50 opacity-0'"
                />
              </span>
              <span
                class="text-sm font-medium transition-colors"
                :class="
                  transportUdara
                    ? 'text-brand-700 dark:text-brand-300'
                    : 'text-gray-700 dark:text-gray-300'
                "
              >
                Transportasi Udara (Pesawat)
              </span>
            </label>

            <label
              class="group relative flex cursor-pointer select-none items-center gap-3 rounded-xl border p-3.5 transition-all duration-200"
              :class="
                transportDarat
                  ? 'border-brand-500 bg-brand-50/80 shadow-sm ring-1 ring-brand-500/20 dark:border-brand-500 dark:bg-brand-500/10 dark:ring-brand-500/30'
                  : 'border-gray-200 bg-white hover:border-brand-300 hover:bg-brand-50/40 dark:border-gray-700 dark:bg-white/[0.02] dark:hover:border-brand-500/40 dark:hover:bg-brand-500/5'
              "
            >
              <input v-model="transportDarat" type="checkbox" class="peer sr-only" />
              <span
                class="flex h-5 w-5 shrink-0 items-center justify-center rounded-md border-2 transition-all duration-200"
                :class="
                  transportDarat
                    ? 'border-transparent bg-gradient-to-br from-brand-500 to-brand-400 shadow-sm shadow-brand-500/40'
                    : 'border-gray-300 bg-white group-hover:border-brand-400 group-hover:shadow-sm dark:border-gray-600 dark:bg-white/[0.05]'
                "
              >
                <CheckIcon
                  class="h-3.5 w-3.5 transition-all duration-200"
                  :class="transportDarat ? 'scale-100 opacity-100' : 'scale-50 opacity-0'"
                />
              </span>
              <span
                class="text-sm font-medium transition-colors"
                :class="
                  transportDarat
                    ? 'text-brand-700 dark:text-brand-300'
                    : 'text-gray-700 dark:text-gray-300'
                "
              >
                Kendaraan Umum (PP)
              </span>
            </label>

            <label
              class="group relative flex cursor-pointer select-none items-center gap-3 rounded-xl border p-3.5 transition-all duration-200"
              :class="
                transportKendaraanDinas
                  ? 'border-brand-500 bg-brand-50/80 shadow-sm ring-1 ring-brand-500/20 dark:border-brand-500 dark:bg-brand-500/10 dark:ring-brand-500/30'
                  : 'border-gray-200 bg-white hover:border-brand-300 hover:bg-brand-50/40 dark:border-gray-700 dark:bg-white/[0.02] dark:hover:border-brand-500/40 dark:hover:bg-brand-500/5'
              "
            >
              <input v-model="transportKendaraanDinas" type="checkbox" class="peer sr-only" />
              <span
                class="flex h-5 w-5 shrink-0 items-center justify-center rounded-md border-2 transition-all duration-200"
                :class="
                  transportKendaraanDinas
                    ? 'border-transparent bg-gradient-to-br from-brand-500 to-brand-400 shadow-sm shadow-brand-500/40'
                    : 'border-gray-300 bg-white group-hover:border-brand-400 group-hover:shadow-sm dark:border-gray-600 dark:bg-white/[0.05]'
                "
              >
                <CheckIcon
                  class="h-3.5 w-3.5 transition-all duration-200"
                  :class="transportKendaraanDinas ? 'scale-100 opacity-100' : 'scale-50 opacity-0'"
                />
              </span>
              <span
                class="text-sm font-medium transition-colors"
                :class="
                  transportKendaraanDinas
                    ? 'text-brand-700 dark:text-brand-300'
                    : 'text-gray-700 dark:text-gray-300'
                "
              >
                Transportasi Kendaraan Dinas (PP)
              </span>
            </label>

            <label
              class="group relative flex cursor-pointer select-none items-center gap-3 rounded-xl border p-3.5 transition-all duration-200"
              :class="[
                daerahDalam
                  ? 'pointer-events-none cursor-not-allowed border-gray-200 bg-gray-50 opacity-50 dark:border-gray-700 dark:bg-gray-800 dark:opacity-40'
                  : '',
                taksiBandara
                  ? 'border-brand-500 bg-brand-50/80 shadow-sm ring-1 ring-brand-500/20 dark:border-brand-500 dark:bg-brand-500/10 dark:ring-brand-500/30'
                  : 'border-gray-200 bg-white hover:border-brand-300 hover:bg-brand-50/40 dark:border-gray-700 dark:bg-white/[0.02] dark:hover:border-brand-500/40 dark:hover:bg-brand-500/5',
              ]"
            >
              <input v-model="taksiBandara" type="checkbox" class="peer sr-only" :disabled="daerahDalam" />
              <span
                class="flex h-5 w-5 shrink-0 items-center justify-center rounded-md border-2 transition-all duration-200"
                :class="
                  taksiBandara
                    ? 'border-transparent bg-gradient-to-br from-brand-500 to-brand-400 shadow-sm shadow-brand-500/40'
                    : 'border-gray-300 bg-white group-hover:border-brand-400 group-hover:shadow-sm dark:border-gray-600 dark:bg-white/[0.05]'
                "
              >
                <CheckIcon
                  class="h-3.5 w-3.5 transition-all duration-200"
                  :class="taksiBandara ? 'scale-100 opacity-100' : 'scale-50 opacity-0'"
                />
              </span>
              <span
                class="text-sm font-medium transition-colors"
                :class="
                  taksiBandara
                    ? 'text-brand-700 dark:text-brand-300'
                    : 'text-gray-700 dark:text-gray-300'
                "
              >
                Taksi Bandara (PP)
              </span>
            </label>

            <label
              class="group relative flex cursor-pointer select-none items-center gap-3 rounded-xl border p-3.5 transition-all duration-200"
              :class="[
                daerahDalam
                  ? 'pointer-events-none cursor-not-allowed border-gray-200 bg-gray-50 opacity-50 dark:border-gray-700 dark:bg-gray-800 dark:opacity-40'
                  : '',
                uangSakuAktif
                  ? 'border-brand-500 bg-brand-50/80 shadow-sm ring-1 ring-brand-500/20 dark:border-brand-500 dark:bg-brand-500/10 dark:ring-brand-500/30'
                  : 'border-gray-200 bg-white hover:border-brand-300 hover:bg-brand-50/40 dark:border-gray-700 dark:bg-white/[0.02] dark:hover:border-brand-500/40 dark:hover:bg-brand-500/5',
              ]"
            >
              <input v-model="uangSakuAktif" type="checkbox" class="peer sr-only" :disabled="daerahDalam" />
              <span
                class="flex h-5 w-5 shrink-0 items-center justify-center rounded-md border-2 transition-all duration-200"
                :class="
                  uangSakuAktif
                    ? 'border-transparent bg-gradient-to-br from-brand-500 to-brand-400 shadow-sm shadow-brand-500/40'
                    : 'border-gray-300 bg-white group-hover:border-brand-400 group-hover:shadow-sm dark:border-gray-600 dark:bg-white/[0.05]'
                "
              >
                <CheckIcon
                  class="h-3.5 w-3.5 transition-all duration-200"
                  :class="uangSakuAktif ? 'scale-100 opacity-100' : 'scale-50 opacity-0'"
                />
              </span>
              <span
                class="text-sm font-medium transition-colors"
                :class="
                  uangSakuAktif
                    ? 'text-brand-700 dark:text-brand-300'
                    : 'text-gray-700 dark:text-gray-300'
                "
              >
                Uang Saku
              </span>
            </label>
          </div>

          <div v-if="transportUdara" class="mt-4 rounded-xl border border-brand-100 bg-brand-50/40 p-4 dark:border-brand-900/40 dark:bg-brand-500/5">
            <p class="mb-3 text-xs font-semibold uppercase tracking-wider text-brand-600 dark:text-brand-400">Rute Pesawat</p>
            <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
              <div>
                <label for="kota_asal_pesawat" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
                  Kota Asal Pesawat
                </label>
                <div class="group relative">
                  <span
                    class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                  >
                    <SendIcon class="h-4 w-4" />
                  </span>
                  <input
                    id="kota_asal_pesawat"
                    v-model="kotaAsal"
                    type="text"
                    placeholder="Contoh: Banda Aceh"
                    :class="inputClass"
                  />
                </div>
              </div>
              <div>
                <label for="kota_tujuan_pesawat" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
                  Kota Tujuan Pesawat
                </label>
                <div class="group relative">
                  <span
                    class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3.5 text-gray-400 transition-colors group-focus-within:text-blue-500 dark:text-gray-500 dark:group-focus-within:text-blue-400"
                  >
                    <BoxCubeIcon class="h-4 w-4" />
                  </span>
                  <input
                    id="kota_tujuan_pesawat"
                    v-model="kotaTujuan"
                    type="text"
                    placeholder="Contoh: Jakarta"
                    :class="inputClass"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>

  

        <p v-if="calcError" class="mt-4 rounded-lg bg-red-50 px-4 py-2.5 text-sm text-red-600 dark:bg-red-500/10 dark:text-red-400">
          {{ calcError }}
        </p>

        <p v-if="uploadError" class="mt-4 rounded-lg bg-red-50 px-4 py-2.5 text-sm text-red-600 dark:bg-red-500/10 dark:text-red-400">
          {{ uploadError }}
        </p>

        <input
          ref="buktiInput"
          type="file"
          accept=".pdf,.jpg,.jpeg,.png,.webp"
          class="hidden"
          @change="onBuktiSelected"
        />

        <div class="mt-6 overflow-hidden rounded-xl border border-gray-200 dark:border-gray-800">
          <template v-if="result">
            <div class="overflow-x-auto">
              <table class="w-full table-auto text-left">
                <thead>
                  <tr class="border-b border-gray-200 bg-gray-50 dark:border-gray-800 dark:bg-white/[0.03]">
                    <th class="px-4 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Uraian</th>
                    <th class="px-4 py-3 text-center text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Hari</th>
                    <th class="px-4 py-3 text-right text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Satuan</th>
                    <th class="px-4 py-3 text-right text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Jumlah</th>
                    <th class="px-4 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Keterangan</th>
                    <th class="px-4 py-3 text-center text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Bukti</th>
                    <th class="px-4 py-3 text-center text-[11px] font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                      <span class="sr-only">Aksi</span>
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr
                    v-for="(item, index) in result.rincian"
                    :key="index"
                    class="border-b border-gray-100 last:border-0 dark:border-gray-800"
                  >
                    <td class="px-4 py-3">
                      <input
                        v-model="item.uraian"
                        type="text"
                        class="w-full min-w-[10rem] rounded-lg border border-gray-300 bg-white px-2 py-1.5 text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100"
                      />
                    </td>
                    <td class="px-4 py-3 text-center">
                      <input
                        v-model.number="item.hari"
                        type="number"
                        min="0"
                        class="w-20 rounded-lg border border-gray-300 bg-white px-2 py-1.5 text-center text-sm text-gray-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100"
                        @input="onRincianChange(item)"
                      />
                    </td>
                    <td class="px-4 py-3 text-right">
                      <div class="ml-auto w-36">
                        <MoneyInput
                          :model-value="item.satuan"
                          @update:model-value="onSatuanChange(item, $event)"
                        />
                      </div>
                    </td>
                    <td class="px-4 py-3 text-right text-sm font-medium text-gray-800 dark:text-white/90">{{ formatRupiah(item.jumlah) }}</td>
                    <td class="px-4 py-3 text-sm text-gray-500 dark:text-gray-400">{{ item.keterangan }}</td>
                    <td class="px-4 py-3">
                      <div class="flex items-center justify-center gap-2">
                        <template v-if="item.bukti_url">
                          <a
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
                            type="button"
                            class="text-gray-400 transition-colors hover:text-error-500 dark:hover:text-error-500"
                            title="Hapus bukti"
                            @click="removeBukti(index)"
                          >
                            <TrashIcon class="h-4 w-4" />
                          </button>
                        </template>
                        <button
                          v-else
                          type="button"
                          :disabled="uploadingIndex === index"
                          class="inline-flex items-center gap-1.5 rounded-lg border border-gray-300 px-2.5 py-1.5 text-xs font-medium text-gray-600 transition-colors hover:bg-gray-50 disabled:cursor-not-allowed disabled:opacity-60 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-white/[0.05]"
                          title="Unggah bukti"
                          @click="triggerUpload(index)"
                        >
                          <PaperclipIcon class="h-3.5 w-3.5" />
                          {{ uploadingIndex === index ? 'Mengunggah...' : 'Upload' }}
                        </button>
                      </div>
                    </td>
                    <td class="px-4 py-3 text-center">
                      <button
                        type="button"
                        class="text-gray-400 transition-colors hover:text-error-500 dark:hover:text-error-500"
                        title="Hapus rincian"
                        @click="removeRincian(index)"
                      >
                        <TrashIcon class="h-4 w-4" />
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="flex flex-col gap-2 border-t border-gray-200 bg-gray-50 px-4 py-4 dark:border-gray-800 dark:bg-white/[0.03] sm:flex-row sm:items-center sm:justify-between">
              <div class="text-sm text-gray-600 dark:text-gray-300">
                Lama Perjalanan: <span class="font-semibold text-gray-800 dark:text-white/90">{{ result.lama_hari }} hari</span>
              </div>
              <div class="text-sm text-gray-600 dark:text-gray-300">
                Total Biaya: <span class="text-lg font-bold text-gray-900 dark:text-white">{{ formatRupiah(result.total_biaya) }}</span>
              </div>
            </div>
            <div class="border-t border-gray-200 bg-gray-50 px-4 py-4 dark:border-gray-800 dark:bg-white/[0.03]">
              <p class="text-sm text-gray-600 dark:text-gray-300">
                <span class="font-semibold text-gray-800 dark:text-white/90">Terbilang: </span>
                {{ result.terbilang }} Rupiah
              </p>
            </div>
          </template>
          <EmptyState v-else message="Klik 'Hitung Biaya' untuk menampilkan rincian biaya perjalanan dinas." />
        </div>
      </div>

      <div class="mt-6 flex flex-col-reverse justify-end gap-3 sm:flex-row">
        <Link
          href="/sppd"
          class="inline-flex items-center justify-center rounded-lg bg-white px-5 py-2.5 text-sm font-medium text-gray-700 ring-1 ring-inset ring-gray-300 transition-colors hover:bg-gray-50 dark:bg-gray-800 dark:text-gray-400 dark:ring-gray-700 dark:hover:bg-white/[0.03]"
        >
          Batal
        </Link>
        <button
          type="submit"
          :disabled="saving"
          class="inline-flex items-center justify-center rounded-lg bg-brand-500 px-5 py-2.5 text-sm font-medium text-white shadow-theme-xs transition-colors hover:bg-brand-600 disabled:cursor-not-allowed disabled:bg-brand-300"
        >
          {{ saving ? 'Menyimpan...' : isEdit ? 'Simpan Perubahan' : 'Simpan SPPD' }}
        </button>
      </div>
    </form>
  </AdminLayout>
</template>

<script setup lang="ts">
import { computed, ref, watch } from 'vue'
import { Link, router, useForm, usePage } from '@inertiajs/vue3'
import { isAxiosError } from 'axios'
import AdminLayout from '../../components/layout/AdminLayout.vue'
import PageBreadcrumb from '@/components/common/PageBreadcrumb.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import DatePicker from '@/components/ui/DatePicker.vue'
import PegawaiSelect, { type PegawaiSelectOption } from '@/components/ui/PegawaiSelect.vue'
import MoneyInput from '@/components/ui/MoneyInput.vue'
import { calculateSppd, createSppd, updateSppd, storeRincian, uploadBukti } from '@/api/sppd'
import type { CalculatePayload, CalculateResult, CalculateRincian, Golongan, SppdRincian } from '@/types/sppd'
import type { Pegawai, Provinsi } from '@/types/pegawai'
import { UserCircleIcon, GridIcon, BarChartIcon, UserGroupIcon, FlagIcon, DocsIcon, SendIcon, BoxCubeIcon, TrashIcon, PaperclipIcon, CheckIcon, Calendar2Line, InfoIcon } from '@/icons'

interface SppdForm {
  nomor_sppd: string
  atas_nama: string
  nip: string
  pangkat_golongan: string
  jabatan: string
  tanggal_mulai: string
  tanggal_selesai: string
  tujuan_daerah: string
  provinsi_tujuan: number | ''
  keperluan: string
}

interface SppdProp {
  id: number
  nomor_sppd: string
  atas_nama: string
  nip: string | null
  pangkat_golongan: string | null
  jabatan: string | null
  tanggal_mulai: string
  tanggal_selesai: string
  tujuan_daerah: string
  provinsi_tujuan: number
  keperluan: string | null
  jenis_sppd: 'dalam' | 'luar'
  status: string
  lama_hari: number
  total_biaya: number
  rincian?: SppdRincian[]
  transport_udara?: boolean
  transport_darat_pp?: boolean
  taksi_bandara?: boolean
  transport_kendaraan_dinas_pp?: boolean
  golongan?: Golongan | null
  kota_asal_pesawat?: string | null
  kota_tujuan_pesawat?: string | null
}

const props = defineProps<{
  provinsi: Provinsi[]
  pegawais: PegawaiSelectOption[]
  sppd?: SppdProp | null
}>()

const isEdit = Boolean(props.sppd)
const pageTitle = isEdit ? 'Edit SPPD' : 'Buat SPPD'
const deskripsiData = isEdit
  ? `Ubah data pelaksana perjalanan dinas (${props.sppd?.nomor_sppd}).`
  : 'Lengkapi data pelaksana perjalanan dinas.'

interface PagePropsShape {
  flash?: {
    success?: string
  }
  [key: string]: unknown
}

const page = usePage<PagePropsShape>()

const inputClass =
  'w-full rounded-lg border border-gray-300 bg-white px-4 pl-10 py-2.5 text-sm text-gray-900 placeholder-gray-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 dark:border-gray-600 dark:bg-white/[0.05] dark:text-gray-100 dark:placeholder-gray-500 dark:focus:border-blue-400'

const form = useForm<SppdForm>({
  nomor_sppd: props.sppd?.nomor_sppd ?? '',
  atas_nama: props.sppd?.atas_nama ?? '',
  nip: props.sppd?.nip ?? '',
  pangkat_golongan: props.sppd?.pangkat_golongan ?? '',
  jabatan: props.sppd?.jabatan ?? '',
  tanggal_mulai: props.sppd?.tanggal_mulai.slice(0, 10) ?? '',
  tanggal_selesai: props.sppd?.tanggal_selesai.slice(0, 10) ?? '',
  tujuan_daerah: props.sppd?.tujuan_daerah ?? '',
  provinsi_tujuan: props.sppd?.provinsi_tujuan ?? '',
  keperluan: props.sppd?.keperluan ?? '',
})

const lamaHari = computed<number>(() => {
  if (!form.tanggal_mulai || !form.tanggal_selesai) return 0
  const start = new Date(form.tanggal_mulai).getTime()
  const end = new Date(form.tanggal_selesai).getTime()
  if (Number.isNaN(start) || Number.isNaN(end) || end < start) return 0
  return Math.floor((end - start) / 86400000) + 1
})

const selectedPegawaiId = ref<number | ''>(
  props.sppd?.nip
    ? (props.pegawais.find((p) => p.nip === props.sppd?.nip)?.id ?? '')
    : '',
)
const golongan = ref<Golongan>(props.sppd?.golongan ?? 'eselon_1')
const transportUdara = ref(Boolean(props.sppd?.transport_udara))
const transportDarat = ref(Boolean(props.sppd?.transport_darat_pp))
const transportKendaraanDinas = ref(Boolean(props.sppd?.transport_kendaraan_dinas_pp))
const taksiBandara = ref(Boolean(props.sppd?.taksi_bandara))
const kotaAsal = ref(props.sppd?.kota_asal_pesawat ?? '')
const kotaTujuan = ref(props.sppd?.kota_tujuan_pesawat ?? '')
const savedUangSaku = props.sppd?.rincian?.find((item) => item.jenis_biaya === 'uang_saku')
const uangSaku = ref<number>(savedUangSaku?.satuan ?? 0)
const uangSakuHari = ref<number>(savedUangSaku?.hari ?? 0)
const uangSakuAktif = ref<boolean>(Boolean(savedUangSaku))

const jenisSppd = ref<'dalam' | 'luar'>(props.sppd?.jenis_sppd ?? 'luar')
const daerahDalam = computed(() => jenisSppd.value === 'dalam')
const jenisSppdCard = (opt: 'dalam' | 'luar'): string =>
  jenisSppd.value === opt
    ? 'border-brand-500 bg-brand-50/80 ring-1 ring-brand-500/20 dark:border-brand-500 dark:bg-brand-500/10 dark:ring-brand-500/30'
    : 'border-gray-200 bg-white hover:border-brand-300 hover:bg-brand-50/40 dark:border-gray-700 dark:bg-white/[0.02] dark:hover:border-brand-500/40 dark:hover:bg-brand-500/5'

watch(jenisSppd, (value) => {
  if (value === 'dalam') {
    transportUdara.value = false
    taksiBandara.value = false
    uangSakuAktif.value = false
  }
})

const result = ref<CalculateResult | null>(null)
const rincian = ref<CalculateRincian[]>([])
const calculating = ref(false)
const saving = ref(false)
const calcError = ref('')
const buktiInput = ref<HTMLInputElement | null>(null)
const uploadTargetIndex = ref<number | null>(null)
const uploadingIndex = ref<number | null>(null)
const uploadError = ref('')

const rincianTersimpan = props.sppd?.rincian
if (rincianTersimpan && rincianTersimpan.length > 0 && props.sppd) {
  result.value = {
    rincian: rincianTersimpan.map((item) => ({
      jenis_biaya: item.jenis_biaya,
      uraian: item.uraian,
      hari: item.hari,
      satuan: item.satuan,
      jumlah: item.jumlah,
      keterangan: item.keterangan ?? '',
      bukti: item.bukti ?? null,
      bukti_url: item.bukti_url ?? null,
    })),
    total_biaya: props.sppd.total_biaya ?? 0,
    lama_hari: props.sppd.lama_hari ?? 0,
    terbilang: terbilang(props.sppd.total_biaya ?? 0),
  }
}

const golonganOptions: { value: Golongan; label: string }[] = [
  { value: 'eselon_1', label: 'Eselon I' },
  { value: 'eselon_2', label: 'Eselon II' },
  { value: 'eselon_3', label: 'Eselon III' },
  { value: 'eselon_4', label: 'Gol IV' },
]

const formatRupiah = (value: number): string =>
  new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumFractionDigits: 0,
  }).format(value || 0)

function terbilang(angka: number): string {
  const huruf = ['', 'satu', 'dua', 'tiga', 'empat', 'lima', 'enam', 'tujuh', 'delapan', 'sembilan', 'sepuluh', 'sebelas']
  const n = Math.floor(Math.abs(Number(angka) || 0))
  if (n < 12) return huruf[n]
  if (n < 20) return `${huruf[n - 10]} belas`
  if (n < 100) {
    const x = Math.floor(n / 10)
    const sisa = n % 10
    return `${x === 1 ? 'se' : `${huruf[x]} `}puluh${sisa > 0 ? ` ${huruf[sisa]}` : ''}`
  }
  if (n < 200) return `seratus ${terbilang(n - 100)}`
  if (n < 1000) {
    const x = Math.floor(n / 100)
    const sisa = n % 100
    return `${huruf[x]} ratus${sisa > 0 ? ` ${terbilang(sisa)}` : ''}`
  }
  if (n < 2000) return `seribu ${terbilang(n - 1000)}`
  if (n < 1000000) {
    const x = Math.floor(n / 1000)
    const sisa = n % 1000
    return `${terbilang(x)} ribu${sisa > 0 ? ` ${terbilang(sisa)}` : ''}`
  }
  if (n < 1000000000) {
    const x = Math.floor(n / 1000000)
    const sisa = n % 1000000
    return `${terbilang(x)} juta${sisa > 0 ? ` ${terbilang(sisa)}` : ''}`
  }
  return String(n)
}

const recalcTotal = (): void => {
  if (!result.value) return
  result.value.total_biaya = result.value.rincian.reduce(
    (sum, item) => sum + (Number(item.jumlah) || 0),
    0,
  )
  result.value.terbilang = terbilang(result.value.total_biaya)
}

const onRincianChange = (item: CalculateRincian): void => {
  item.hari = Math.max(0, Number(item.hari) || 0)
  item.satuan = Math.max(0, Number(item.satuan) || 0)
  item.jumlah = item.hari * item.satuan
  if (item.jenis_biaya === 'uang_saku') {
    uangSaku.value = item.satuan
    uangSakuHari.value = item.hari
  }
  recalcTotal()
}

const removeRincian = (index: number): void => {
  if (!result.value) return
  const [removed] = result.value.rincian.splice(index, 1)
  if (removed?.jenis_biaya === 'uang_saku') {
    uangSakuAktif.value = false
    uangSaku.value = 0
    uangSakuHari.value = 0
  }
  if (removed?.jenis_biaya === 'transport_dinas_pp') {
    transportKendaraanDinas.value = false
  }
  if (
    removed?.jenis_biaya === 'transport_darat' &&
    !result.value.rincian.some((i) => i.jenis_biaya === 'transport_darat')
  ) {
    transportDarat.value = false
  }
  recalcTotal()
}

const onSatuanChange = (item: CalculateRincian, value: number): void => {
  item.satuan = Number(value) || 0
  onRincianChange(item)
}

const triggerUpload = (index: number): void => {
  uploadTargetIndex.value = index
  uploadError.value = ''
  buktiInput.value?.click()
}

const onBuktiSelected = async (event: Event): Promise<void> => {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]
  input.value = ''
  const index = uploadTargetIndex.value
  if (!file || index === null || !result.value) return
  uploadingIndex.value = index
  uploadError.value = ''
  try {
    const res = await uploadBukti(file)
    const item = result.value.rincian[index]
    if (item) {
      item.bukti = res.path
      item.bukti_url = res.url
    }
  } catch {
    uploadError.value = 'Gagal mengunggah bukti. Gunakan format PDF/JPG/PNG/WEBP maksimal 5 MB.'
  } finally {
    uploadingIndex.value = null
    uploadTargetIndex.value = null
  }
}

const removeBukti = (index: number): void => {
  const item = result.value?.rincian[index]
  if (!item) return
  item.bukti = null
  item.bukti_url = null
  uploadError.value = ''
}

const onPegawaiChange = (): void => {
  const pegawai = props.pegawais.find((p) => p.id === selectedPegawaiId.value)
  if (!pegawai) {
    form.atas_nama = ''
    form.nip = ''
    form.pangkat_golongan = ''
    form.jabatan = ''
    return
  }
  form.atas_nama = pegawai.nama_pegawai
  form.nip = pegawai.nip ?? ''
  form.pangkat_golongan = pegawai.pangkat_golongan ?? ''
  form.jabatan = pegawai.jabatan ?? ''
}

const onProvinsiChange = (): void => {
  const prov = props.provinsi.find((p) => p.id_provinsi === form.provinsi_tujuan)
  if (prov) {
    form.tujuan_daerah = prov.ibukota
  }
}

const buildCalculatePayload = (): CalculatePayload => ({
  provinsi_tujuan: Number(form.provinsi_tujuan),
  tanggal_mulai: form.tanggal_mulai,
  tanggal_selesai: form.tanggal_selesai,
  golongan: golongan.value,
  jenis_sppd: jenisSppd.value,
  transport_udara: transportUdara.value,
  transport_darat_pp: transportDarat.value,
  transport_kendaraan_dinas_pp: transportKendaraanDinas.value,
  taksi_bandara: taksiBandara.value,
  kota_asal_pesawat: transportUdara.value ? kotaAsal.value || null : null,
  kota_tujuan_pesawat: transportUdara.value ? kotaTujuan.value || null : null,
  uang_saku: uangSakuAktif.value ? Number(uangSaku.value) || 0 : 0,
  uang_saku_hari: uangSakuAktif.value ? Number(uangSakuHari.value) || lamaHari.value || 0 : 0,
})

const handleCalculate = async (): Promise<void> => {
  if (form.provinsi_tujuan === '') {
    calcError.value = 'Pilih provinsi tujuan terlebih dahulu.'
    return
  }
  if (!form.tanggal_mulai || !form.tanggal_selesai) {
    calcError.value = 'Lengkapi tanggal mulai dan tanggal selesai.'
    return
  }
  if (form.tanggal_selesai < form.tanggal_mulai) {
    calcError.value = 'Tanggal selesai tidak boleh sebelum tanggal mulai.'
    return
  }
  calcError.value = ''
  calculating.value = true
  try {
    const res = await calculateSppd(buildCalculatePayload())
    result.value = res
    rincian.value = res.rincian
  } catch {
    calcError.value = 'Gagal menghitung biaya. Silakan coba kembali.'
  } finally {
    calculating.value = false
  }
}

const saveRincian = async (id: number): Promise<void> => {
  if (!result.value?.rincian?.length) return
  await storeRincian(id, result.value.rincian)
}

const handleSimpan = async (): Promise<void> => {
  saving.value = true
  try {
    const payload = {
      nomor_sppd: form.nomor_sppd || null,
      atas_nama: form.atas_nama,
      nip: form.nip || null,
      pangkat_golongan: form.pangkat_golongan || null,
      jabatan: form.jabatan || null,
      tanggal_mulai: form.tanggal_mulai,
      tanggal_selesai: form.tanggal_selesai,
      tujuan_daerah: form.tujuan_daerah,
      provinsi_tujuan: Number(form.provinsi_tujuan),
      keperluan: form.keperluan || null,
      jenis_sppd: jenisSppd.value,
      transport_udara: transportUdara.value,
      transport_darat_pp: transportDarat.value,
      transport_kendaraan_dinas_pp: transportKendaraanDinas.value,
      taksi_bandara: taksiBandara.value,
      golongan: golongan.value,
      kota_asal_pesawat: transportUdara.value ? kotaAsal.value || null : null,
      kota_tujuan_pesawat: transportUdara.value ? kotaTujuan.value || null : null,
    }

    if (isEdit && props.sppd) {
      await updateSppd(props.sppd.id, {
        ...payload,
        status: props.sppd.status === 'batal' ? 'draft' : undefined,
      })
      await saveRincian(props.sppd.id)
    } else {
      const res = await createSppd(payload)
      await saveRincian(res.sppd.id)
    }

    form.clearErrors()
    router.visit('/sppd')
  } catch (error) {
    if (isAxiosError(error) && error.response?.status === 422) {
      const errors = error.response.data?.errors ?? {}
      form.clearErrors().setError(errors)
    }
  } finally {
    saving.value = false
  }
}
</script>
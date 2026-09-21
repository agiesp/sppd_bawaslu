@include('laporan.partials.kop', [
    'judul' => $judul,
    'orientasi' => 'A4 portrait',
    'filter' => $filter,
])

@if (!$data['sppd'])
    <p class="msg">SPPD dengan nomor tersebut tidak ditemukan.</p>
@else
    @php($s = $data['sppd'])
    <table class="data">
        <tbody>
            <tr><td style="width:28%;font-weight:bold">Nomor SPPD</td><td>: {{ $s->nomor_sppd }}</td></tr>
            <tr><td style="font-weight:bold">Atas Nama</td><td>: {{ $s->atas_nama }}</td></tr>
            <tr><td style="font-weight:bold">NIP</td><td>: {{ $s->nip ?: '-' }}</td></tr>
            <tr><td style="font-weight:bold">Pangkat / Golongan</td><td>: {{ $s->pangkat_golongan ?: '-' }}</td></tr>
            <tr><td style="font-weight:bold">Jabatan</td><td>: {{ $s->jabatan ?: '-' }}</td></tr>
            <tr>
                <td style="font-weight:bold">Tanggal Perjalanan</td>
                <td>: {{ $s->tanggal_mulai->format('d-m-Y') }} s/d {{ $s->tanggal_selesai->format('d-m-Y') }} ({{ $s->lama_hari }} hari)</td>
            </tr>
            <tr>
                <td style="font-weight:bold">Tujuan</td>
                <td>: {{ $s->tujuan_daerah }} ({{ $s->provinsi?->nama_provinsi ?: '-' }})</td>
            </tr>
            <tr><td style="font-weight:bold">Keperluan</td><td>: {{ $s->keperluan ?: '-' }}</td></tr>
        </tbody>
    </table>

    <table class="data" style="margin-top:14px">
        <thead>
            <tr>
                <th style="width:5%">No</th>
                <th style="width:42%">Perincian Biaya</th>
                <th style="width:8%">Hari</th>
                <th style="width:15%">Satuan</th>
                <th style="width:15%">Jumlah</th>
                <th style="width:15%">Keterangan</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($s->rincian as $i => $r)
                <tr>
                    <td class="ctr">{{ $i + 1 }}</td>
                    <td>{{ $r->uraian }}</td>
                    <td class="ctr">{{ $r->hari }}</td>
                    <td class="num">Rp {{ number_format($r->satuan, 0, ',', '.') }}</td>
                    <td class="num">Rp {{ number_format($r->jumlah, 0, ',', '.') }}</td>
                    <td>{{ $r->keterangan ?: '-' }}</td>
                </tr>
            @empty
                <tr><td colspan="6" class="ctr">Belum ada rincian biaya.</td></tr>
            @endforelse
            <tr class="total">
                <td colspan="4" class="ctr" style="text-align:right">Jumlah Biaya</td>
                <td class="num">Rp {{ number_format($s->total_biaya, 0, ',', '.') }}</td>
                <td></td>
            </tr>
        </tbody>
    </table>
    <p class="terbilang">Terbilang: {{ $data['terbilang'] }} rupiah</p>
@endif

@include('laporan.partials.penutup', ['tanggal' => $tanggal])
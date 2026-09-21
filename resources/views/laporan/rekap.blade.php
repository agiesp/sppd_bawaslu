@include('laporan.partials.kop', [
    'judul' => $judul,
    'orientasi' => 'A4 landscape',
    'filter' => $filter,
])

<table class="data">
    <thead>
        <tr>
            <th style="width:4%">No</th>
            <th style="width:13%">Nomor SPPD</th>
            <th style="width:14%">Atas Nama</th>
            <th style="width:13%">NIP / Jabatan</th>
            <th style="width:11%">Tujuan</th>
            <th style="width:14%">Tanggal</th>
            <th style="width:6%">Hari</th>
            <th style="width:8%">Status</th>
            <th style="width:12%">Total Biaya</th>
        </tr>
    </thead>
    <tbody>
        @forelse ($data['rows'] as $i => $row)
            <tr>
                <td class="ctr">{{ $i + 1 }}</td>
                <td class="ctr">{{ $row['nomor_sppd'] }}</td>
                <td>{{ $row['atas_nama'] }}</td>
                <td>{!! ($row['nip'] ?: '-') . '<br>' . ($row['jabatan'] ?: '-') !!}</td>
                <td>{{ $row['tujuan_daerah'] }} ({{ $row['provinsi'] }})</td>
                <td class="ctr">{{ $row['tanggal_mulai'] }} s/d {{ $row['tanggal_selesai'] }}</td>
                <td class="ctr">{{ $row['lama_hari'] }}</td>
                <td class="ctr">{{ $row['status'] }}</td>
                <td class="num">{{ number_format($row['total_biaya'], 0, ',', '.') }}</td>
            </tr>
        @empty
            <tr>
                <td colspan="9" class="ctr">Tidak ada data SPPD pada periode tersebut.</td>
            </tr>
        @endforelse
        <tr class="total">
            <td colspan="6" class="ctr">Jumlah</td>
            <td class="ctr">{{ $data['grand_jumlah'] }} SPPD</td>
            <td class="ctr">{{ $data['grand_hari'] }} hari</td>
            <td class="num">Rp {{ number_format($data['grand_total'], 0, ',', '.') }}</td>
        </tr>
    </tbody>
</table>

@include('laporan.partials.penutup', ['tanggal' => $tanggal])
@include('laporan.partials.kop', [
    'judul' => $judul,
    'orientasi' => 'A4 portrait',
    'filter' => $filter,
])

<table class="data">
    <thead>
        <tr>
            <th style="width:4%">No</th>
            <th style="width:18%">Nama Pegawai</th>
            <th style="width:15%">NIP</th>
            <th style="width:20%">Pangkat / Golongan</th>
            <th style="width:18%">Jabatan</th>
            <th style="width:8%">Jumlah SPPD</th>
            <th style="width:8%">Jumlah Hari</th>
            <th style="width:12%">Total Biaya</th>
        </tr>
    </thead>
    <tbody>
        @forelse ($data['rows'] as $i => $row)
            <tr>
                <td class="ctr">{{ $i + 1 }}</td>
                <td>{{ $row['atas_nama'] }}</td>
                <td class="ctr">{{ $row['nip'] ?: '-' }}</td>
                <td>{{ $row['pangkat'] ?: '-' }}</td>
                <td>{{ $row['jabatan'] ?: '-' }}</td>
                <td class="ctr">{{ $row['jumlah_sppd'] }}</td>
                <td class="ctr">{{ $row['jumlah_hari'] }}</td>
                <td class="num">Rp {{ number_format($row['total_biaya'], 0, ',', '.') }}</td>
            </tr>
        @empty
            <tr>
                <td colspan="8" class="ctr">Tidak ada data SPPD pada periode tersebut.</td>
            </tr>
        @endforelse
        <tr class="total">
            <td colspan="5" class="ctr">Jumlah</td>
            <td class="ctr">{{ $data['grand_jumlah'] }} SPPD</td>
            <td class="ctr">{{ $data['grand_hari'] }} hari</td>
            <td class="num">Rp {{ number_format($data['grand_total'], 0, ',', '.') }}</td>
        </tr>
    </tbody>
</table>

@include('laporan.partials.penutup', ['tanggal' => $tanggal])
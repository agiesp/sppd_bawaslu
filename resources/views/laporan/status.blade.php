@include('laporan.partials.kop', [
    'judul' => $judul,
    'orientasi' => 'A4 portrait',
    'filter' => $filter,
])

<table class="data">
    <thead>
        <tr>
            <th style="width:4%">No</th>
            <th style="width:30%">Status</th>
            <th style="width:18%">Jumlah SPPD</th>
            <th style="width:18%">Jumlah Hari</th>
            <th style="width:30%">Total Biaya</th>
        </tr>
    </thead>
    <tbody>
        @forelse ($data['rows'] as $i => $row)
            <tr>
                <td class="ctr">{{ $i + 1 }}</td>
                <td>{{ $row['status'] }}</td>
                <td class="ctr">{{ $row['jumlah_sppd'] }}</td>
                <td class="ctr">{{ $row['jumlah_hari'] }}</td>
                <td class="num">Rp {{ number_format($row['total_biaya'], 0, ',', '.') }}</td>
            </tr>
        @empty
            <tr>
                <td colspan="5" class="ctr">Tidak ada data SPPD pada periode tersebut.</td>
            </tr>
        @endforelse
        <tr class="total">
            <td colspan="2" class="ctr">Jumlah</td>
            <td class="ctr">{{ $data['grand_jumlah'] }} SPPD</td>
            <td class="ctr">{{ $data['grand_hari'] }} hari</td>
            <td class="num">Rp {{ number_format($data['grand_total'], 0, ',', '.') }}</td>
        </tr>
    </tbody>
</table>

@include('laporan.partials.penutup', ['tanggal' => $tanggal])
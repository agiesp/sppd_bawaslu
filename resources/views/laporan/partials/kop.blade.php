<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <title>{{ $judul }}</title>
    <style>
        @page { margin: 14mm; }
        * { box-sizing: border-box; }
        body {
            font-family: 'DejaVu Sans', Arial, sans-serif;
            font-size: 11px;
            line-height: 1.4;
            color: #111;
            margin: 0;
            padding: 0;
        }
        .kop {
            text-align: center;
            margin-bottom: 10px;
        }
        .kop h1 { font-size: 16px; margin: 0 0 2px; text-transform: uppercase; letter-spacing: 0.5px; }
        .kop h2 { font-size: 15px; margin: 0 0 2px; text-transform: uppercase; }
        .kop p { font-size: 11px; margin: 0; }
        .garis {
            border-bottom: 3px double #111;
            border-top: 1px solid #111;
            height: 5px;
            margin: 8px 0 14px;
        }
        h3.judul { text-align: center; font-size: 13px; text-transform: uppercase; text-decoration: underline; margin: 0 0 8px; }
        table.keterangan { width: 60%; margin: 0 auto 12px; font-size: 11px; border-collapse: collapse; }
        table.keterangan td { padding: 1px 4px; vertical-align: top; }
        table.keterangan td.k { font-weight: bold; }
        table.data { width: 100%; border-collapse: collapse; font-size: 10px; }
        table.data th {
            border: 1px solid #111;
            background: #e8e8e8;
            padding: 5px 4px;
            text-align: center;
            font-weight: bold;
        }
        table.data td { border: 1px solid #111; padding: 4px; vertical-align: top; }
        table.data .num { text-align: right; }
        table.data .ctr { text-align: center; }
        table.data tr.total td { font-weight: bold; background: #f2f2f2; }
        .terbilang { margin-top: 8px; font-size: 11px; font-style: italic; }
        .msg { text-align: center; font-size: 12px; padding: 30px 0; }
        table.ttd { width: 100%; margin-top: 42px; border-collapse: collapse; font-size: 11px; }
        table.ttd td { text-align: center; vertical-align: top; }
        table.ttd .ttd-kiri { width: 50%; }
        table.ttd .ttd-kanan { width: 50%; }
        .space { height: 55px; }
        .u { text-decoration: underline; font-weight: bold; }
        .page-break { page-break-before: always; }
    </style>
</head>
<body>

    <div class="kop">
        <h1>Pemerintah Kabupaten Pidie</h1>
        <h2>Badan Awas Rakyat Kabupaten Pidie</h2>
        <p>Jl. Tgk. Di Lamjabat, Kec. Sakti, Kab. Pidie, Prov. Aceh</p>
    </div>
    <div class="garis"></div>

    <h3 class="judul">{{ $judul }}</h3>

    <table class="keterangan">
        @if (!empty($filter))
            @foreach ($filter as $label => $value)
                <tr>
                    <td class="k">{{ $label }}</td>
                    <td class="k">:</td>
                    <td>{{ $value }}</td>
                </tr>
            @endforeach
        @endif
    </table>
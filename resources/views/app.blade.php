<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" class="h-full light">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        @php
            $appName = config('app.name', 'SPPD Bawaslu');
            try {
                $favicon = \App\Models\Setting::where('key', 'app_favicon')->value('value');
            } catch (\Throwable $e) {
                $favicon = null;
            }
        @endphp
        <title>{{ $appName }}</title>
        @if($favicon)
            <link rel="icon" type="image/x-icon" href="{{ $favicon }}">
        @endif
        @vite(['resources/js/app.js'])
        <script src="https://cdn.lordicon.com/lordicon.js"></script>
    </head>
    <body class="h-full bg-gray-50 dark:bg-dark-900 dark:text-gray-100">
        @inertia
    </body>
</html>
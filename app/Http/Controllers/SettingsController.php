<?php

namespace App\Http\Controllers;

use App\Models\Setting;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Inertia\Response;

class SettingsController extends Controller
{
    public function index(): Response
    {
        $settings = Setting::where('is_active', true)
            ->orderBy('group')->orderBy('order')->get()
            ->groupBy('group');

        return Inertia::render('System/Index', [
            'settings' => $settings,
        ]);
    }

    public function update(Request $request)
    {
        $fileKeys = ['app_logo', 'app_favicon', 'login_background'];

        $allowed = Setting::where('is_active', true)->pluck('key');

        $fields = $request->only($allowed->all());

        foreach ($fields as $key => $value) {
            if (in_array($key, $fileKeys)) {
                continue;
            }
            Setting::where('key', $key)->update(['value' => $value]);
        }

        foreach ($fileKeys as $fileKey) {
            if ($request->hasFile($fileKey)) {
                $this->storeFileSetting($request, $fileKey);
            }
        }

        return response()->json([
            'message' => 'Pengaturan sistem berhasil disimpan.',
            'settings' => $this->settingsForResponse(),
        ]);
    }

    private function storeFileSetting(Request $request, string $key)
    {
        $file = $request->file($key);

        $old = Setting::where('key', $key)->value('value');
        if ($old) {
            $oldPath = str_replace('/storage/', '', $old);
            \Storage::disk('public')->delete($oldPath);
        }

        $path = $file->store('settings', 'public');
        $url = '/storage/' . $path;

        Setting::where('key', $key)->update(['value' => $url]);
    }

    private function settingsForResponse()
    {
        return Setting::where('is_active', true)
            ->orderBy('group')->orderBy('order')->get()
            ->groupBy('group');
    }
}
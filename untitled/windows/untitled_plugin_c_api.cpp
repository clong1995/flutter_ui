#include "include/untitled/untitled_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "untitled_plugin.h"

void UntitledPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  untitled::UntitledPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

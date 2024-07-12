#ifndef FLUTTER_PLUGIN_UNTITLED_PLUGIN_H_
#define FLUTTER_PLUGIN_UNTITLED_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace untitled {

class UntitledPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  UntitledPlugin();

  virtual ~UntitledPlugin();

  // Disallow copy and assign.
  UntitledPlugin(const UntitledPlugin&) = delete;
  UntitledPlugin& operator=(const UntitledPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace untitled

#endif  // FLUTTER_PLUGIN_UNTITLED_PLUGIN_H_

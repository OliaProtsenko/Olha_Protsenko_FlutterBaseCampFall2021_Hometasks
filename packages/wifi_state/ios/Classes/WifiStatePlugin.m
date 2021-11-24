#import "WifiStatePlugin.h"
#if __has_include(<wifi_state/wifi_state-Swift.h>)
#import <wifi_state/wifi_state-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "wifi_state-Swift.h"
#endif

@implementation WifiStatePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWifiStatePlugin registerWithRegistrar:registrar];
}
@end

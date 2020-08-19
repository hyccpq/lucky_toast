#import "LuckyToastPlugin.h"
#if __has_include(<lucky_toast/lucky_toast-Swift.h>)
#import <lucky_toast/lucky_toast-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lucky_toast-Swift.h"
#endif

@implementation LuckyToastPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLuckyToastPlugin registerWithRegistrar:registrar];
}
@end

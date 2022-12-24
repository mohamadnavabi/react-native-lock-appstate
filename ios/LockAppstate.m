#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(LockAppstate, NSObject)

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

@end

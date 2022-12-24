import UIKit

@objc(LockAppstate)
class LockAppstate: NSObject {
    private var listenersStarted = false
    private let center = CFNotificationCenterGetDarwinNotifyCenter()
    private var eventEmitter: RCTEventEmitter!

    private override init() {
        super.init()
        startListeners()
    }
    
    deinit {
        stopListeners()
    }
    
    private let displayStatusChangedCallback: CFNotificationCallback = { _, cfObserver, cfName, _, _ in guard let lockState = cfName?.rawValue as? String else {
            return
        }

        let catcher = Unmanaged<LockAppstate>.fromOpaque(UnsafeRawPointer(OpaquePointer(cfObserver)!)).takeUnretainedValue()
        catcher.displayStatusChanged(lockState)
    }
    
    private func displayStatusChanged(_ lockState: String) {
        if (lockState == "com.apple.springboard.lockcomplete") {
            EventEmitter.sharedInstance.dispatch(name: "onLocked", body: "sleepLock")
        } else {
            // TODO: check power button pressed
        }
    }

    fileprivate func startListeners() {
        if !listenersStarted {
            self.listenersStarted = true
            CFNotificationCenterAddObserver(center, Unmanaged.passUnretained(self).toOpaque(), displayStatusChangedCallback, "com.apple.springboard.lockcomplete" as CFString, nil, .deliverImmediately)
            
//            CFNotificationCenterAddObserver(center, Unmanaged.passUnretained(self).toOpaque(), displayStatusChangedCallback, "com.apple.springboard.lockstate" as CFString, nil, .deliverImmediately)
        }
    }

     fileprivate func stopListeners() {
         if listenersStarted {
             CFNotificationCenterRemoveEveryObserver(center, Unmanaged.passRetained(self).toOpaque())
             listenersStarted = false
         }
     }
}

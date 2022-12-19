import UIKit

@objc(LockAppstate)
class LockAppstate: NSObject {
    private var listenersStarted = false
    
    override init(){
        super.init()
        print("hereeeeee Hello World")
        startListeners()
    }
    
    deinit {
        print("hereeeeee Hello World end")

        stopListeners()
    }

    //    MARK: listening
     fileprivate func startListeners() {
         if !listenersStarted {
             self.listenersStarted = true
             CFNotificationCenterAddObserver(center, Unmanaged.passRetained(self).toOpaque(), { (center, observer, name, object, userInfo) in
                 // send the equivalent internal notification
                 NotificationCenter.default.post(name: NSNotification.Name.SomeInternalExtensionAction, object: nil)
             }, Self.notificationName, nil, .deliverImmediately)
         }
     }

     fileprivate func stopListeners() {
         if listenersStarted {
             CFNotificationCenterRemoveEveryObserver(center, Unmanaged.passRetained(self).toOpaque())
             listenersStarted = false
         }
     }
}

final public class ExtensionEvent: NSObject {
    public static func post() {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFNotificationName(rawValue: ExtensionListener.notificationName), nil, nil, true)
    }
}

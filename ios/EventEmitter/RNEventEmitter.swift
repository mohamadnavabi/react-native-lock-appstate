import Foundation

@objc(RNEventEmitter)
open class RNEventEmitter: RCTEventEmitter {
    
    override init() {
        super.init()
        EventEmitter.sharedInstance.registerEventEmitter(eventEmitter: self)
    }
    
    /// Base overide for RCTEventEmitter.
    ///
    /// - Returns: all supported events
    @objc open override func supportedEvents() -> [String] {
        return EventEmitter.sharedInstance.allEvents
    }
    
    public override static func requiresMainQueueSetup() -> Bool {
      return true
    }
}

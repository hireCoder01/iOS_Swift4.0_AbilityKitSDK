import Foundation
import AudioToolbox

/**
 A handler called when a mute check is complete.
 
 @param lapse The amount of time the check took.
 @param muted Whether the phone is muted.
 */
typealias MuteCheckCompletionHandler = ((_ lapse: TimeInterval, _ muted: Bool) -> Void)

class MuteChecker: NSObject {
    
    var soundId: SystemSoundID = 0
    private var startTime: Date?
    
    /**
     The completion block to be called once the check is complete. May be
     changed after initialization.
     */
    private var completionBlk: MuteCheckCompletionHandler?
    
    /**
     Initializes the mute checker with a completion block.
     
     @param completionBlk The block to call after a completion check.
     @return An initialized MuteChecker instance.
     */
    
    init(withCompletionBlk: @escaping MuteCheckCompletionHandler) {
        
        super.init()
        
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "MuteChecker",
                                        withExtension: "caf") else {
            assertionFailure("File Not found")
            return
        }
        
        if AudioServicesCreateSystemSoundID(url as CFURL,
                                            &self.soundId) == kAudioServicesNoError {
            
            let rawPointer = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
            AudioServicesAddSystemSoundCompletion(self.soundId, nil, nil,
                                                  { (systemSoundID, voidPointer) in
                let muteChecker = unsafeBitCast(voidPointer, to: MuteChecker.self)
                muteChecker.completed()
            }, rawPointer)
            
            var yes = 1
            AudioServicesSetProperty(kAudioServicesPropertyIsUISound, UInt32(MemoryLayout.size(ofValue:self.soundId)), &self.soundId, UInt32(MemoryLayout.size(ofValue:yes)), &yes)
            self.completionBlk = withCompletionBlk
        } else {
            print("Error setting up Sound ID")
        }
    }
    
    private func playMuteSound() {
        
        self.startTime = Date()
        AudioServicesPlaySystemSound(self.soundId);
    }
    
    private func completed() {
        
        let now = Date()
        let t = now.timeIntervalSince(self.startTime!)
        let muted = (t >= 0.2 ? false : true)
        self.completionBlk!(t, muted)
    }
    
    /**
     Performs the mute check.  Upon completion, the completionBlk handler will be called.
     */
    func check() {
        
        if self.startTime == nil {
            self.playMuteSound()
        } else {
            let now = Date()
            let lastCheck = now.timeIntervalSince(self.startTime!)
            if lastCheck > 1 { //prevent checking interval shorter then the sound length
                self.playMuteSound()
            }
        }
    }
    
    deinit {
        
        print("\(#function)")
        AudioServicesRemoveSystemSoundCompletion(self.soundId)
        AudioServicesDisposeSystemSoundID(self.soundId)
    }
}

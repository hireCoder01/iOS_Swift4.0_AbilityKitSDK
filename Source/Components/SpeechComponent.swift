import AVFoundation

private let SPEECH_QUEUE_MAX = 3

class SpeechComponent: NSObject {

    private var talkingNow = false
    private var speechQueue: Array<String> = []
    private var speechSynthesizer = AVSpeechSynthesizer()
    
    private var speechUtterance: AVSpeechUtterance? = nil
    private var muteChecker: MuteChecker? = nil
    
    private static let sharedManager: SpeechComponent = {
        let sharedManager = SpeechComponent()
        return sharedManager
    }()
    
    private lazy var currentSession: AVAudioSession = {
        return AVAudioSession.sharedInstance()
    }()
    
    private var isTalkingNow: Bool {
        return self.talkingNow
    }
    
    var isQueueEmpty: Bool {
        return self.speechQueue.count == 0
    }
    
    var isHeadsetConnected: Bool {
        let audioRoute = AVAudioSession.sharedInstance().currentRoute
        for output in audioRoute.outputs {
            return output.portType == AVAudioSessionPortHeadphones
        }
        return false
    }
    
    class func shared() -> SpeechComponent {
        
        return sharedManager
    }
    
    private override init() {
        super.init()
        
        self.speechSynthesizer.delegate = self
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(audioHintHandle(hintNotification:)), name:
            NSNotification.Name.AVAudioSessionSilenceSecondaryAudioHint,
            object: self.currentSession)
    }
    
    @objc func audioHintHandle(hintNotification: Notification) {
        
    }
    
    private func speakNow(_ phrase: String) {
        
        if phrase.isEmpty {
            print("Empty phrase.")
            return
        }
        
        self.talkingNow = true
        self.speechSynthesizer.stopSpeaking(at: .immediate)
        self.speechUtterance = AVSpeechUtterance(string: phrase)
        
        if self.muteChecker == nil {
            self.muteChecker = MuteChecker.init(withCompletionBlk: { (lapsed, muted) in
                
                if muted {
                    self.talkingNow = false
                    self.speechQueue.removeAll()
                    self.speechUtterance = nil
                    return
                }
                do {
                    try self.currentSession.setActive(true)
                    self.speechSynthesizer.speak(self.speechUtterance!)
                } catch {
                    print("ERROR IN SESSION: \(error.localizedDescription)")
                }
                defer {
                    self.speechUtterance = nil
                }
            })
        }
        
        self.muteChecker?.check()
    }
    
    private func stopSpeakingAndClearSpeechQueue(willClearSpeechQueue: Bool) {
        
        if (willClearSpeechQueue){
            self.speechQueue.removeAll()
        }
        
        if self.isTalkingNow {
            self.speechUtterance = nil
            self.speechSynthesizer.stopSpeaking(at: .immediate)
            do {
                try self.currentSession.setActive(false)
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
        defer {
            self.talkingNow = false
        }
    }
    
    func speak(phrase: String) {
        
        if phrase.isEmpty {
            
            print("Defensive check triggered, got speaking phrase with zero length.")
            return
        }
        
        if !self.isTalkingNow {
            self.speakNow(phrase)
        } else {
            
            self.speechQueue.append(phrase)
            if self.speechQueue.count >= SPEECH_QUEUE_MAX {
                
                self.stopSpeakingAndClearSpeechQueue(willClearSpeechQueue: false)
                let nextPhrase = self.speechQueue[0]
                self.speechQueue.remove(at: 0)
                self.speakNow(nextPhrase)
            }
        }
    }
    
    deinit {
        print("\(#function)")
    }
}

extension SpeechComponent: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didStart utterance: AVSpeechUtterance) {
        
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didFinish utterance: AVSpeechUtterance) {
        
        if (synthesizer == self.speechSynthesizer) {
            
            self.talkingNow = false
            if (self.speechQueue.count > 0) {
                let nextPhrase = self.speechQueue[0]
                self.speechQueue.remove(at: 0)
                self.speakNow(nextPhrase)
            }
        }
    }
}

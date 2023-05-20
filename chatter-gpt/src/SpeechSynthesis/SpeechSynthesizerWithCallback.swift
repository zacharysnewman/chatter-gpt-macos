
import AVFoundation

class SpeechSynthesizerWithCallback: NSObject, AVSpeechSynthesizerDelegate {

    private let synthesizer = AVSpeechSynthesizer()
    let stoppedSpeakingCallback: () -> Void

    init(stoppedSpeakingCallback: @escaping () -> Void) {
        self.stoppedSpeakingCallback = stoppedSpeakingCallback
        super.init()
        synthesizer.delegate = self
    }

    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AppSettings.voice
        utterance.rate = 0.5
        self.synthesizer.speak(utterance)
        while(synthesizer.isSpeaking) {
            Thread.sleep(forTimeInterval: 0.5)
        }
    }
    
    func stopSpeaking() {
        self.synthesizer.stopSpeaking(at: .word)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.stoppedSpeakingCallback()
    }
}

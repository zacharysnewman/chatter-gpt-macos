
import AVFoundation

class TextToSpeech {
    // Create an AVSpeechSynthesizer to synthesize the speech from the utterance
    static var synthesizer: SpeechSynthesizerWithCallback?
    
    static func speak(text: String, startedSpeakingCallback: () -> Void, stoppedSpeakingCallback: @escaping () -> Void) {
        self.synthesizer = SpeechSynthesizerWithCallback(stoppedSpeakingCallback: stoppedSpeakingCallback)
        self.synthesizer?.speak(text: text)
        startedSpeakingCallback()
    }
    
    static func stopSpeaking() {
        self.synthesizer?.stopSpeaking()
    }
}

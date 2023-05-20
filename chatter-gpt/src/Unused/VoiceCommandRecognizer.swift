
import Foundation
import AppKit

class VoiceCommandRecognizer: NSObject {
    let recognizer = NSSpeechRecognizer()!
    let commands = ["Hey Jarvis", "Goodbye Jarvis"]

    func startListening() {
        recognizer.listensInForegroundOnly = false;
        recognizer.blocksOtherRecognizers = false;
        recognizer.commands = commands
        recognizer.delegate = self
        recognizer.startListening()
    }

    func stopListening() {
        recognizer.stopListening()
    }
}

extension VoiceCommandRecognizer: NSSpeechRecognizerDelegate {
    func speechRecognizer(_ sender: NSSpeechRecognizer, didRecognizeCommand command: String?) {
        guard let command = command else { return }
        switch command {
        case "Goodbye Jarvis":
            print("Goodbye Jarvis command recognized")
//            TextToSpeech.speak(text: "Goodbye.")
//            SpeechToText.stopRecording()
        case "Hey Jarvis":
            print("Hey Jarvis command recognized")
//            TextToSpeech.speak(text: "Yes?")
//            SpeechToText.startRecording()
        default:
            break
        }
    }
}

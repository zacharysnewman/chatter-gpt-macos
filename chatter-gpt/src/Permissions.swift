
import Foundation
import AVFoundation
import Speech

class Permissions {
    
    // MARK: - Speech Recognition
    
    static func checkSpeechRecognitionPermissions() -> SFSpeechRecognizerAuthorizationStatus {
        return SFSpeechRecognizer.authorizationStatus()
    }
    
    static func requestSpeechRecognitionPermissions() -> Bool {
        let status = SFSpeechRecognizer.authorizationStatus()
        if status == .notDetermined {
            SFSpeechRecognizer.requestAuthorization { status in
                if status != .authorized {
                    print("Speech recognition permission not granted.")
                }
            }
        }
        return status == .authorized
    }
    
    static func getSpeechRecognitionPrivacySettingsLink() -> URL {
        let privacySettingsURL = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_SpeechRecognition")!
        return privacySettingsURL
    }
    
    // MARK: - Microphone
    
    static func checkMicrophonePermissions() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
//        let audioEngine = AVAudioEngine()
//        let inputNode = audioEngine.inputNode
//        let recordingFormat = inputNode.outputFormat(forBus: 0)
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, time in
//            // do nothing
//        }
//        audioEngine.prepare()
//        do {
//            try audioEngine.start()
//            inputNode.removeTap(onBus: 0)
//            return true
//        } catch {
//            print("Microphone permission not granted.")
//            return false
//        }
    }
    
    static func requestMicrophonePermissions() -> Bool {
//        AVCaptureDevice.requestAccess(for: AVMediaType.audio, completionHandler: (Bool) -> Void)
        // not needed for macOS, as permission is automatically requested
        return true
    }
    
    static func getMicrophonePrivacySettingsLink() -> URL {
        let privacySettingsURL = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Microphone")!
        return privacySettingsURL
    }
}

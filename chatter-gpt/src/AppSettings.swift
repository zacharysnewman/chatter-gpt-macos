
import Foundation
import AVFoundation

class AppSettings {
    static let canListen: () -> Bool = { return Permissions.checkMicrophonePermissions() && Permissions.checkSpeechRecognitionPermissions() == .authorized && UserDefaults.standard.string(forKey: "apiKey") ?? "" != "" && UserDefaults.standard.string(forKey: "aiName") ?? "" != "" && !isSpeaking && !isListening
    }

    static let voice = AVSpeechSynthesisVoice(language: "en-UK")
    
    private(set) static var APIKey: String = UserDefaults.standard.string(forKey: "apiKey") ?? ""
    static func setAPIKey(apiKey: String) {
        APIKey = apiKey
    }
    
    private(set) static var AIName: String = UserDefaults.standard.string(forKey: "aiName") ?? ""
    static func setAIName(aiName: String) {
        AIName = aiName.lowercased()
    }
    
    static var isSpeaking = false
    static var isListening = false
}

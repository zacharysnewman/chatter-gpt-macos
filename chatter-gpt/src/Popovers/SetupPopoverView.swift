
import SwiftUI

struct SetupPopoverView: View {
    @State private var apiKey = UserDefaults.standard.string(forKey: "apiKey") ?? ""
    @State private var aiName = UserDefaults.standard.string(forKey: "aiName") ?? ""
    
    let popover: NSPopover
    
    init(popover: NSPopover) {
        self.popover = popover
    }
    
    var body: some View {
        let speechRecognitionStatus = Permissions.checkSpeechRecognitionPermissions()
        VStack(alignment: .leading, spacing: 10) {
            if(!Permissions.checkMicrophonePermissions()) {
                Button(action: {
                    let url = Permissions.getMicrophonePrivacySettingsLink()
                    NSWorkspace.shared.open(url)
                }) {
                    Text("Microphone")
                }
                .frame(maxWidth: .infinity)
            }
            
            if(speechRecognitionStatus != .authorized) {
                Button(action: {
                    if(speechRecognitionStatus == .denied) {
                        let url = Permissions.getSpeechRecognitionPrivacySettingsLink()
                        NSWorkspace.shared.open(url)
                    } else {
                        Permissions.requestSpeechRecognitionPermissions()
                    }
                }) {
                    Text("Speech Recognition")
                }
                .frame(maxWidth: .infinity)
            }
            Button(action: {
                if let url = URL(string: "https://platform.openai.com/account/api-keys") {
                    NSWorkspace.shared.open(url)
                }
            }) {
                Text("Manage API Keys ↗")
            }
            .buttonStyle(.link)
            .frame(maxWidth: .infinity)
            HStack {
                Text("API Key:")
                Spacer()
                SecureField("", text: $apiKey)
                    .frame(width: 150)
            }
            HStack {
                Text("AI Name:")
                Spacer()
                TextField("", text: $aiName)
                    .frame(width: 150)
            }
            Button("Save") {
                UserDefaults.standard.set(apiKey, forKey: "apiKey")
                UserDefaults.standard.set(aiName, forKey: "aiName")
                AppSettings.setAIName(aiName: aiName)
                AppDelegate.stopListening()
                self.popover.performClose(nil)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: 250)
    }
}

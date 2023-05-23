
import SwiftUI
import Foundation
import AppKit
import Speech

@main
struct TrayApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
      AppDelegate.shared = self.appDelegate
    }
    var body: some Scene { Settings{} }
}

class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    static let speechRecognizer = SpeechRecognizer(onRecognizedCallback: onSpeechRecognized, onNotRecognizedCallback: onNoSpeechRecognized)
    static let audioStreamer = AudioStreamer(recordingCallback: onAudioStream)
    
    static var statusBarItem: NSStatusItem?
    static var shared : AppDelegate!
    
    static var errorPopover: NSPopover!
    var pluginsPopover: NSPopover!
    var setupPopover: NSPopover!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        initializeMenu()
        initializeSetupPopover()
        initializeErrorPopover()
        initializePluginsPopover()
        NSApp.setActivationPolicy(.accessory) // Hides app in dock
    }
    
    func menuWillOpen(_ menu: NSMenu) {
        AppDelegate.updateStartListeningItem()
    }
           
    @objc func toggleSetupPopover(_ sender: AnyObject?) {
       if setupPopover.isShown {
           setupPopover.performClose(sender)
       } else {
           if let button = AppDelegate.statusBarItem?.button {
               setupPopover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
           }
       }
    }
    
    @objc func togglePluginsPopover(_ sender: AnyObject?) {
        if self.pluginsPopover.isShown {
            self.pluginsPopover.performClose(sender)
       } else {
           if let button = AppDelegate.statusBarItem?.button {
               self.pluginsPopover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
           }
       }
    }
    
    func initializeMenu() {
        let startListeningMenuItem = NSMenuItem(title: "Start Listening", action: #selector(onStartListeningClick), keyEquivalent: "")
        let stopListeningMenuItem = NSMenuItem(title: "Stop Listening", action: #selector(onStopListeningClick), keyEquivalent: "")
        let stopTalkingMenuItem = NSMenuItem(title: "Stop Talking", action: #selector(onStopTalkingClick), keyEquivalent: "")
        let setupMenuItem = NSMenuItem(title: "Setup", action: #selector(onSetupClicked), keyEquivalent: "")
        let pluginsMenuItem = NSMenuItem(title: "Plugins", action: #selector(onPluginsClicked), keyEquivalent: "")
        let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(onQuitClick), keyEquivalent: "")
        
        AppDelegate.statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        AppDelegate.statusBarItem?.button?.title = "Chatter"
        AppDelegate.statusBarItem?.menu = NSMenu()
        AppDelegate.statusBarItem?.menu?.delegate = self
        AppDelegate.statusBarItem?.menu?.addItem(startListeningMenuItem)
        AppDelegate.statusBarItem?.menu?.addItem(stopListeningMenuItem)
        AppDelegate.statusBarItem?.menu?.addItem(stopTalkingMenuItem)
        AppDelegate.statusBarItem?.menu?.addItem(setupMenuItem)
//        AppDelegate.statusBarItem?.menu?.addItem(pluginsMenuItem)
        AppDelegate.statusBarItem?.menu?.addItem(quitMenuItem)
        
        stopListeningMenuItem.isHidden = true
        stopTalkingMenuItem.isHidden = true
    }
    
    func initializeSetupPopover() {
        self.setupPopover = NSPopover()
        let popoverView = SetupPopoverView(popover: self.setupPopover)
        self.setupPopover.contentSize = NSSize(width: 250, height: 150)
        self.setupPopover.contentViewController = NSHostingController(rootView: popoverView)
        self.setupPopover.behavior = .transient // Add this to dismiss the popover when clicking outside of it
    }
    
    func initializeErrorPopover() {
        AppDelegate.errorPopover = NSPopover()
        AppDelegate.errorPopover.contentSize = NSSize(width: 250, height: 150)
        AppDelegate.errorPopover.behavior = .transient // Add this to dismiss the popover when clicking outside of it
    }
    
    func initializePluginsPopover() {
        self.pluginsPopover = NSPopover()
        let popoverView = PluginsPopoverView(popover: self.pluginsPopover)
        self.pluginsPopover.contentSize = NSSize(width: 250, height: 150)
        self.pluginsPopover.contentViewController = NSHostingController(rootView: popoverView)
        self.pluginsPopover.behavior = .transient // Add this to dismiss the popover when clicking outside of it
    }
    
    static func displayErrorPopover(errorMessage: String) {
        AppDelegate.stopListening()
        TextToSpeech.speak(text: "Something went wrong.", startedSpeakingCallback: AppDelegate.onStartedSpeaking, stoppedSpeakingCallback: AppDelegate.onStoppedSpeaking)
        DispatchQueue.main.async {
            let popoverView = ErrorPopoverView(errorMessage: errorMessage)
            AppDelegate.errorPopover.contentViewController = NSHostingController(rootView: popoverView)
            if let button = AppDelegate.statusBarItem?.button {
                AppDelegate.errorPopover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    static func updateStartListeningItem() {
        AppDelegate.getMenuItemByTitle(title: "Start Listening")?.isHidden = !AppSettings.canListen()
    }
    
    @objc func onStartListeningClick() {
        print("Start Listening clicked")
        AppDelegate.startListening()
    }
    
    static func startListening() {
        AppSettings.isListening = true
        AppDelegate.audioStreamer.startRecording()
        AppDelegate.speechRecognizer.startRecognizing()
        AppDelegate.getMenuItemByTitle(title: "Start Listening")?.isHidden = true
        AppDelegate.getMenuItemByTitle(title: "Stop Listening")?.isHidden = false
    }
    
    @objc func onStopListeningClick() {
        print("Stop Listening clicked")
        AppDelegate.stopListening()
    }
    
    static func stopListening() {
        AppDelegate.speechRecognizer.stopRecognizing()
        AppDelegate.audioStreamer.stopRecording()
        AppDelegate.getMenuItemByTitle(title: "Stop Listening")?.isHidden = true
        AppDelegate.getMenuItemByTitle(title: "Start Listening")?.isHidden = false
        AppSettings.isListening = false
    }

    @objc func onStopTalkingClick() {
        print("Stop Talking clicked")
        TextToSpeech.stopSpeaking()
    }
    
    @objc func onSetupClicked() {
        print("Setup clicked")
        AppDelegate.stopListening()
        toggleSetupPopover(self)
    }
    
    @objc func onPluginsClicked() {
        print("Plugins clicked")
        
    }

    @objc func onQuitClick() {
        print("Quit Requested")
        if(AppDelegate.speechRecognizer.isRecognizing) {
            AppDelegate.speechRecognizer.stopRecognizing()
        }
        NSApp.terminate(self)
    }
    
    static func onAudioStream(buffer: AVAudioPCMBuffer) {
        AppDelegate.speechRecognizer.appendTo(buffer: buffer)
    }
    
    // TODO: Move internal functionality to ChatAPI. Also, while waiting there should be a sound that indicates it's pending a response
    static func onSpeechRecognized(transcription: String) {
        print("Final: \(transcription)")
        let processedTranscription: String = TextProcessing.processTranscription(transcription: transcription)
        print("Processed: \(processedTranscription)")
        print(AppSettings.AIName)
        if(transcription.lowercased().contains(AppSettings.AIName.lowercased())) {
            TextToSpeech.speak(text: "Let me see", startedSpeakingCallback: {}, stoppedSpeakingCallback: {})
            print("Sending request")
            let parameters: [String: Any] = [
                "model": "gpt-3.5-turbo",
                "messages": [
                    ["role": "system", "content": "You are my personal AI assistant named \(AppSettings.AIName)"],
                    ["role": "user", "content": "From now on, except for with code, please answer in 1-3 sentences and surround any important information such as dates, numbers, and formulas in your response with the <copy> tag. And surround any code with the <code> tag instead."],
                    ["role": "user", "content": processedTranscription]
                ]
//                "prompt": transcription,
//                "max_tokens": 100,
//                "temperature": 0.5
            ]
            // TODO: Split into an API class (return speakableText, copyableText, cleanedText)
            OpenAIChatAPI.createCompletion(parameters: parameters) { data, response, error in
                guard error == nil else {
                    print("Error: \(error!)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                // Use the response data to extract the response body and process it
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonObject1 = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let error = jsonObject1["error"] as? [String: Any],
                           let message = error["message"] as? String {
                            AppDelegate.displayErrorPopover(errorMessage: message)
                        }
                    if let jsonObject = json as? [String: Any],
                        let choicesArray = jsonObject["choices"] as? [[String: Any]],
                        let firstChoice = choicesArray.first,
                        let messageObject = firstChoice["message"] as? [String: Any],
                        let content = messageObject["content"] as? String {
                            print(content)
                            let (cleaned, matches) = TextProcessing.getCopyableItems(input: content)
                            print(cleaned)
                            let combinedString = matches.joined(separator: "\n")
                            if(matches.count > 0) {
                                Clipboard.copyToClipboard(text: combinedString)
                            } else {
                                Clipboard.copyToClipboard(text: cleaned)
                            }
                            TextToSpeech.speak(text: cleaned, startedSpeakingCallback: onStartedSpeaking, stoppedSpeakingCallback: onStoppedSpeaking)
                        }
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        AppDelegate.speechRecognizer.startRecognizing()
    }
    
    static func onNoSpeechRecognized() {
        AppDelegate.speechRecognizer.startRecognizing()
    }
    
    static func onStartedSpeaking() {
        AppSettings.isSpeaking = true
        AppDelegate.stopListening()
        AppDelegate.getMenuItemByTitle(title: "Start Listening")?.isHidden = true
        AppDelegate.getMenuItemByTitle(title: "Stop Talking")?.isHidden = false
    }
    
    static func onStoppedSpeaking() {
        AppDelegate.getMenuItemByTitle(title: "Stop Talking")?.isHidden = true
        AppDelegate.startListening()
        AppSettings.isSpeaking = false
    }
    
    static func getMenuItemByTitle(title: String) -> NSMenuItem? {
        return AppDelegate.statusBarItem?.menu?.item(withTitle: title)
    }
}

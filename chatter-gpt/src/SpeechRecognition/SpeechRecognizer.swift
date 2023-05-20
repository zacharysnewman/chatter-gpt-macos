
import Foundation
import Speech

// A class that handles speech recognition
class SpeechRecognizer {
    private let onRecognizedCallback: (String) -> Void
    private let onNotRecognizedCallback: () -> Void
    private let speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    var isRecognizing = false
    private var lastTranscription: String?
    
    init(onRecognizedCallback: @escaping (String) -> Void, onNotRecognizedCallback: @escaping () -> Void) {
        self.speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
        self.onRecognizedCallback = onRecognizedCallback
        self.onNotRecognizedCallback = onNotRecognizedCallback
    }
    
    func startRecognizing() {
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let guardedRecognitionRequest = recognitionRequest else {
            return
        }
        
        guardedRecognitionRequest.requiresOnDeviceRecognition = true
        guardedRecognitionRequest.shouldReportPartialResults = true
        
        // This is the callback task that handles processing transcription
        recognitionTask = recognitionCallback(speechRecognizer: speechRecognizer, recognitionRequest: guardedRecognitionRequest)
        
        self.isRecognizing = true
    }
    
    func appendTo(buffer: AVAudioPCMBuffer) {
        if(self.isRecognizing) {
            self.recognitionRequest?.append(buffer)
        }
    }
    
    // If the timer expires, stop the recognition and execute processing steps
    
    func stopRecognizing() {
        self.isRecognizing = false
        let transcription = self.lastTranscription ?? ""
        
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
        self.recognitionRequest?.endAudio()
        self.recognitionRequest = nil
        
        self.lastTranscription = ""
        self.invalidateTimer()
        
        // Speech Recognized Callback
        if(transcription != "") {
            self.onRecognizedCallback(transcription)
        } else {
            self.onNotRecognizedCallback()
        }
    }
    
    func recognitionCallback(speechRecognizer: SFSpeechRecognizer?, recognitionRequest: SFSpeechAudioBufferRecognitionRequest) -> SFSpeechRecognitionTask? {
        var previousTranscription: String = ""

        // This is the callback task that handles processing transcription
        return speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            if result != nil {
                let rawTranscription = result?.bestTranscription.formattedString ?? ""
                if(previousTranscription != rawTranscription) {
//                    print("Previous: \(previousTranscription), Raw: \(rawTranscription)")
                    self.lastTranscription = rawTranscription

                    // After each change to transcription value, (re)start a timer for 1-2 seconds
                    self.resetTimer()

                    previousTranscription = rawTranscription
                }
            }
            if error != nil {
                print("Error: \(error?.localizedDescription ?? "")")
            }
        })
    }
    
    // Timer //
    private var timer: Timer?

    private func resetTimer() {
        invalidateTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] timer in
            self?.stopRecognizing()
        }
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
}


import Foundation
import Speech

// A class that handles speech recognition
class OldSpeechRecognizer {
    let speechRecognizer: SFSpeechRecognizer?
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    var lastTranscription: String?
    
    
    init() {
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    }
    
    func startRecognizing(callback: @escaping (String) -> Void) {
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            return
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        // This is the callback task that handles processing transcription
        recognitionTask = recognitionCallback(speechRecognizer: speechRecognizer, recognitionRequest: recognitionRequest, callback: callback)
        
        // Continuously appends recorded input to speech recognition request
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }
    
    func pauseRecognizing() {
        
    }
    
    func resumeRecognizing() {
        
    }
    
    func stopRecognizing(callback: @escaping (String) -> Void) {
        // If the timer expires, stop the recognition and execute processing steps
        let transcription = self.lastTranscription ?? ""
    
        self.audioEngine.inputNode.removeTap(onBus: 0)
        self.audioEngine.stop()
        
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
        
        self.recognitionRequest?.endAudio()
        self.recognitionRequest = nil
        
        self.lastTranscription = ""
        
        self.invalidateTimer()
        
        // Speech Recognized Callback
        if(transcription != "") {
            callback(transcription)
        }
    }
    
    func recognitionCallback(speechRecognizer: SFSpeechRecognizer?, recognitionRequest: SFSpeechAudioBufferRecognitionRequest, callback: @escaping (String) -> Void) -> SFSpeechRecognitionTask? {
        var previousTranscription: String = ""
        
        // This is the callback task that handles processing transcription
        return speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            if result != nil {
                let rawTranscription = result?.bestTranscription.formattedString ?? ""
                if(previousTranscription != rawTranscription) {
//                    print("Previous: \(previousTranscription), Raw: \(rawTranscription)")
                    self.lastTranscription = rawTranscription
                    
                    // After each change to transcription value, (re)start a timer for 1-2 seconds
                    self.resetTimer(callback: callback)
                    
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
    
    private func resetTimer(callback: @escaping (String) -> Void) {
        invalidateTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] timer in
//            self?.stopRecognizing(callback: callback)
        }
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
}

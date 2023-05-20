
import Speech
import AVFoundation

class SpeechToText {
    private let speechRecognizer = SFSpeechRecognizer()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    func startRecognition() {
//        switch AVCaptureDevice.authorizationStatus(for: .audio) {
//        case .authorized: // The user has previously granted access to the camera.
//          // proceed with recording
//            print("authorized")
//        case .notDetermined: // The user has not yet been asked for camera access.
//          AVCaptureDevice.requestAccess(for: .audio) { granted in
//              print("not determined?")
//
//            if granted {
//              // proceed with recording
//                print("granted")
//            }
//          }
//
//        case .denied: // The user has previously denied access.
//            print("denied")
//
//        case .restricted: // The user can't grant access due to restrictions.
//            print("restricted")
//
//        @unknown default:
//          fatalError()
//        }
        
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.startRecording()
                } else {
                    print("Did not have authorization")
                    print(authStatus.rawValue)
                }
            }
        }
    }
    
    private func initRecording() {
        
    }

    private func startRecording() {
        let node: AVAudioInputNode? = audioEngine.inputNode
        let recordingFormat = node?.outputFormat(forBus: 0)
        node?.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [unowned self] buffer, _ in
            self.recognitionRequest?.append(buffer)
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest?.shouldReportPartialResults = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest!) { [unowned self] result, error in
            var isFinal = false

            if let result = result {
                let transcript = result.bestTranscription.formattedString
                print(transcript)
                isFinal = result.isFinal || transcript.contains("submit")
            }

            if error != nil || isFinal {
                self.audioEngine.stop()
                node?.removeTap(onBus: 0)
                self.recognitionTask?.finish()
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.startRecognition()
            }
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            // Handle the failure case
            print("audio engine failed to start")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
    }
}

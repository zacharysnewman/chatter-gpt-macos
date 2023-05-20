
import Foundation
import Speech

// A class that handles speech recognition
class AudioStreamer {
    private let audioEngine = AVAudioEngine()
    private let recordingCallback: (AVAudioPCMBuffer) -> Void
    
    init(recordingCallback: @escaping (AVAudioPCMBuffer) -> Void) {
        self.recordingCallback = recordingCallback
    }
    
    func startRecording() {
        // Continuously calls callback with recorded input
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recordingCallback(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }
    
    func stopRecording() {
        self.audioEngine.inputNode.removeTap(onBus: 0)
        self.audioEngine.stop()
    }
}

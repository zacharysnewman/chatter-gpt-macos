
import Foundation

class OpenAIChatAPI {
    
    private static let baseURL = "https://api.openai.com/v1/chat/completions"
    
    static func createCompletion(parameters: [String: Any?] = [:], completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let url = URL(string: baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(AppSettings.APIKey)", forHTTPHeaderField: "Authorization")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print("ERRRRRREE")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    // Expected Response:
    /*
     - JSON Object
     - Keys
     -- Response (string, containing the entire response)
     -- Code (array of strings or undefined, containing code portions of the response)
     -- Info (array of strings or undefined, containing important information such as dates, numbers, and formulas)
     */
//    static func sendMessage() {
//        let parameters: [String: Any] = [
//            "model": "gpt-3.5-turbo",
//            "messages": [
//                ["role": "system", "content": "You are my personal AI assistant named \(AppSettings.AIName)"],
//                ["role": "user", "content": "From now on, except for with code, please answer in 1-3 sentences and surround any important information such as dates, numbers, and formulas in your response with the <copy> tag. And surround any code with the <code> tag instead."],
//                ["role": "user", "content": processedTranscription]
//            ]
////                "prompt": transcription,
////                "max_tokens": 100,
////                "temperature": 0.5
//        ]
//        OpenAIChatAPI.createCompletion(parameters: parameters) { data, response, error in
//            guard error == nil else {
//                print("Error: \(error!)")
//                return
//            }
//
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//
//            // Use the response data to extract the response body and process it
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                if let jsonObject1 = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                       let error = jsonObject1["error"] as? [String: Any],
//                       let message = error["message"] as? String {
//                        AppDelegate.displayErrorPopover(errorMessage: message)
//                    }
//                if let jsonObject = json as? [String: Any],
//                    let choicesArray = jsonObject["choices"] as? [[String: Any]],
//                    let firstChoice = choicesArray.first,
//                    let messageObject = firstChoice["message"] as? [String: Any],
//                    let content = messageObject["content"] as? String {
//                        print(content)
//                        let (cleaned, matches) = TextProcessing.getCopyableItems(input: content)
//                        print(cleaned)
//                        let combinedString = matches.joined(separator: "\n")
//                        if(matches.count > 0) {
//                            Clipboard.copyToClipboard(text: combinedString)
//                        } else {
//                            Clipboard.copyToClipboard(text: cleaned)
//                        }
//                        TextToSpeech.speak(text: cleaned, startedSpeakingCallback: onStartedSpeaking, stoppedSpeakingCallback: onStoppedSpeaking)
//                    }
//            } catch {
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//    }
}


import Foundation

class OpenAICompletionAPI {
    
    private static let baseURL = "https://api.openai.com/v1/completions"
    private static let apiKey = "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"

    static func createCompletion(parameters: [String: Any?] = [:], completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let url = URL(string: baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}


//import Foundation
//
//class ChatGPTAPI {
//
//    static let responses = [
//        "I'll look into that",
//        "One moment",
//        "Got it",
//        "let me check",
//        "I'll get back to you",
//        "I'm on it",
//        "just a sec",
//        "hold on",
//        "let me see",
//        "I'll get to it"
//    ]
//
//    static func sendQuery(query: String) -> String {
//        let randomIndex = Int.random(in: 0..<responses.count)
//        return responses[randomIndex]
//    }
//}

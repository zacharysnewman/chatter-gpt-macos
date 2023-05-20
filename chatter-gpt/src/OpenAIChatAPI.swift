
import Foundation

class OpenAIChatAPI {
    
    private static let baseURL = "https://api.openai.com/v1/chat/completions"
    
    static func createCompletion(parameters: [String: Any?] = [:], completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let url = URL(string: baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(AppSettings.APIKey)", forHTTPHeaderField: "Authorization")
        print("DID I GET HERE 1?")
        do {
            print("DID I GET HERE 2?")
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            print("DID I GET HERE 3?")
        } catch {
            print("ERRRRRREE")
        }
        print("DID I GET HERE 4?")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
            print("HERE?")
            }.resume()
        print("DID I GET HERE 5?")
    }
}

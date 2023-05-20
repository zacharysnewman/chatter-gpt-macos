
import Foundation

class TextProcessing {
    static func processTranscription(transcription: String) -> String {
        // check for keyword and continue if present
        var prompt = transcription.lowercased()
        
        // Replace any occurrences of keyword with "you"
        prompt = prompt.replacingOccurrences(of: AppSettings.AIName, with: "you")

        // If the query contains "this" or "these", append ": " and clipboard contents
        if(prompt.contains("this") || prompt.contains("these") || prompt.contains("my code")) {
            prompt += ": " + Clipboard.readFromClipboard()
        }
        return prompt
    }
    
    static func getCopyableItems(input: String) -> (String, [String]) {
        let copyPattern = "<copy>([^<]+)</copy>"
        let copyRegex = try! NSRegularExpression(pattern: copyPattern, options: [])
        let copyMatches = copyRegex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
        
        let codePattern = "<code>([^<]+)</code>"
        let codeRegex = try! NSRegularExpression(pattern: codePattern, options: [])
        let codeMatches = codeRegex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))

        let matches = codeMatches.count > 0 ? codeMatches : copyMatches
        var cleanedInput = input
        var matchedValues = [String]()
        for match in matches.reversed() {
            let range = Range(match.range(at: 1), in: input)!
            let result = input[range]
            cleanedInput = cleanedInput.replacingOccurrences(of: "<copy>\(result)</copy>", with: String(result))
            cleanedInput = cleanedInput.replacingOccurrences(of: "<code>\(result)</code>", with: "")
            matchedValues.append(String(result))
        }
        // TODO: Clean code and copy tags separately so the consuming code can send the previous reply back with the next message (to have an actual conversation)
        return (cleanedInput, matchedValues)
    }
}


import AppKit

class Clipboard {
    static func copyToClipboard(text: String) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(text, forType: .string)
    }

    static func readFromClipboard() -> String {
        let pasteBoard = NSPasteboard.general
        return pasteBoard.string(forType: .string) ?? ""
    }
}


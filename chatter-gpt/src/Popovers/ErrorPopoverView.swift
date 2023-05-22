
import SwiftUI

struct ErrorPopoverView: View {
    private let errorMessage: String
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Error: \(errorMessage)")
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(width: 250)
    }
}

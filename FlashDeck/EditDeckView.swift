import SwiftUI

// View for editing the name of a deck
struct EditDeckView: View {
    @Binding var deck: Deck                // Binding to the deck being edited
    @Environment(\.dismiss) var dismiss   // Environment variable to dismiss the view

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Label for the text editor
                Text("Edit Deck Name:")
                    .font(.headline)
                    .foregroundColor(.primary) // Uses system's default text color (dark/light mode adaptive)

                // TextEditor to update the deck title
                TextEditor(text: $deck.title)
                    .padding(10)
                    .frame(minHeight: 100)
                    .background(Color(.systemGray5)) // Light gray background for a clean, non-intrusive look
                    .cornerRadius(10)
                    .font(.title3)
                    .foregroundColor(.primary)       // Matches current system theme
                    .multilineTextAlignment(.center) // Centers text inside editor

                // Button to save changes and dismiss the sheet
                Button(action: {
                    dismiss() // Close the view (changes are auto-bound through the @Binding)
                }) {
                    Text("Save Changes")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray4)) // Slightly darker gray for contrast
                        .foregroundColor(.primary)
                        .cornerRadius(12)
                }
                .padding(.top, 10)
            }
            .padding() // Padding for the whole VStack
        }
        .background(Color(.systemGray6)) // Soft overall background for the scroll view
        .navigationTitle("Edit Deck")
        .navigationBarTitleDisplayMode(.inline) // Keeps the nav title smaller and inline
    }
}

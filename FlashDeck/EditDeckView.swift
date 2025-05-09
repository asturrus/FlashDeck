import SwiftUI

struct EditDeckView: View {
    @Binding var deck: Deck
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Edit Deck Name:")
                    .font(.headline)
                    .foregroundColor(.primary) // Neutral color for text

                TextEditor(text: $deck.title)
                    .padding(10)
                    .frame(minHeight: 100)
                    .background(Color(.systemGray5)) // Light gray background for TextEditor
                    .cornerRadius(10)
                    .font(.title3)
                    .foregroundColor(.primary) // Text color inside TextEditor
                    .multilineTextAlignment(.center) // Keep text centered

                Button(action: {
                    dismiss()
                }) {
                    Text("Save Changes")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray4)) // Soft, neutral background for buttons
                        .foregroundColor(.primary) // Neutral text color
                        .cornerRadius(12)
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .background(Color(.systemGray6)) // Subtle gray background for the whole view
        .navigationTitle("Edit Deck")
        .navigationBarTitleDisplayMode(.inline)
    }
}

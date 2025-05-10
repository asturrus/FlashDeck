import SwiftUI

// View for editing an existing flashcard
struct EditCardView: View {
    @Binding var card: Card  // Binding to the card being edited, so changes reflect in the parent
    @Environment(\.dismiss) var dismiss  // Used to dismiss the sheet view when done

    var body: some View {
        ScrollView {  // Allows content to scroll in case of small screens or keyboard overlap
            VStack(alignment: .leading, spacing: 20) {  // Stack elements vertically with spacing
                // Label for the question editor
                Text("Edit Question:")
                    .font(.headline)

                // Text editor for modifying the question
                TextEditor(text: $card.question)
                    .padding(10)
                    .frame(minHeight: 100)  // Ensure a reasonable height for input
                    .background(Color(.systemGray6))  // Light gray background
                    .cornerRadius(10)  // Rounded corners for a clean UI
                    .font(.title3)

                // Label for the answer editor
                Text("Edit Answer:")
                    .font(.headline)

                // Text editor for modifying the answer
                TextEditor(text: $card.answer)
                    .padding(10)
                    .frame(minHeight: 100)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .font(.title3)

                // Button to save changes and close the edit view
                Button(action: {
                    dismiss()  // Dismiss the current view and go back
                }) {
                    // Button appearance
                    Text("Save Changes")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)  // Stretch button to full width
                        .background(Color.blue)  // Blue background for prominence
                        .foregroundColor(.white)  // White text color
                        .cornerRadius(12)  // Rounded corners
                }
                .padding(.top, 10)  // Add spacing above the button
            }
            .padding()  // Padding around the entire form
        }
        .navigationTitle("Edit Card")  // Title shown in the navigation bar
        .navigationBarTitleDisplayMode(.inline)  // Use inline style (not large)
    }
}

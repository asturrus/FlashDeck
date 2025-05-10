import SwiftUI

// View for adding a new flashcard to a deck
struct AddCardView: View {
    @Binding var deck: Deck  // Binding to the deck where the new card will be added
    @State private var question: String = ""  // Holds the text for the question input
    @State private var answer: String = ""  // Holds the text for the answer input

    var body: some View {
        ScrollView {  // Allows the content to scroll if it overflows vertically
            VStack(alignment: .leading, spacing: 20) {  // Vertically stacks all form elements with spacing
                // Question input label
                Text("Enter Question:")
                    .font(.headline)

                // Text editor for the question input
                TextEditor(text: $question)
                    .padding(10)
                    .frame(minHeight: 100)  // Ensures a decent height for input area
                    .background(Color(.systemGray6))  // Light gray background
                    .cornerRadius(10)  // Rounded corners for a smooth UI
                    .font(.title3)

                // Answer input label
                Text("Enter Answer:")
                    .font(.headline)

                // Text editor for the answer input
                TextEditor(text: $answer)
                    .padding(10)
                    .frame(minHeight: 100)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .font(.title3)

                // Button to add the card to the deck
                Button(action: {
                    // Create a new card and append it to the deck
                    let newCard = Card(question: question, answer: answer)
                    deck.cards.append(newCard)
                    // Clear inputs after adding
                    question = ""
                    answer = ""
                }) {
                    // Button styling
                    Text("Add Card")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)  // Makes the button span the full width
                        .background(Color.blue)  // Blue background for emphasis
                        .foregroundColor(.white)  // White text color
                        .cornerRadius(12)  // Rounded button edges
                }
                .padding(.top, 10)  // Adds some space above the button
            }
            .padding()  // Padding around the whole VStack
        }
        .navigationTitle("Add New Card")  // Title shown in the navigation bar
        .navigationBarTitleDisplayMode(.inline)  // Shows the title inline (not large style)
    }
}

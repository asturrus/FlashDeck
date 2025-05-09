import SwiftUI

struct AddCardView: View {
    @Binding var deck: Deck
    @State private var question: String = ""
    @State private var answer: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Enter Question:")
                    .font(.headline)

                TextEditor(text: $question)
                    .padding(10)
                    .frame(minHeight: 100)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .font(.title3)

                Text("Enter Answer:")
                    .font(.headline)

                TextEditor(text: $answer)
                    .padding(10)
                    .frame(minHeight: 100)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .font(.title3)

                Button(action: {
                    let newCard = Card(question: question, answer: answer)
                    deck.cards.append(newCard)
                    question = ""
                    answer = ""
                }) {
                    Text("Add Card")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle("Add New Card")
        .navigationBarTitleDisplayMode(.inline)
    }
}

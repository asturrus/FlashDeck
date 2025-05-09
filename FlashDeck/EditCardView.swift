import SwiftUI

struct EditCardView: View {
    @Binding var card: Card
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Edit Question:")
                    .font(.headline)

                TextEditor(text: $card.question)
                    .padding(10)
                    .frame(minHeight: 100)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .font(.title3)

                Text("Edit Answer:")
                    .font(.headline)

                TextEditor(text: $card.answer)
                    .padding(10)
                    .frame(minHeight: 100)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .font(.title3)

                Button(action: {
                    dismiss()
                }) {
                    Text("Save Changes")
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
        .navigationTitle("Edit Card")
        .navigationBarTitleDisplayMode(.inline)
    }
}

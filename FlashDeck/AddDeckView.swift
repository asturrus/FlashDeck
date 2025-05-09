import SwiftUI

struct AddDeckForm: View {
    @Binding var decks: [Deck]  // To add the new deck to the existing list
    @State private var deckName: String = ""  // The name of the new deck
    
    @Environment(\.presentationMode) var presentationMode  // To dismiss the form
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Deck Name")) {
                    TextField("Enter deck name", text: $deckName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                
                Button("Add Deck") {
                    // Add new deck to the list when the button is pressed
                    if !deckName.isEmpty {
                        let newDeck = Deck(title: deckName, cards: [])
                        decks.append(newDeck)
                        deckName = ""  // Reset the text field after adding
                        presentationMode.wrappedValue.dismiss()  // Dismiss the form
                    }
                }
                .padding()
                .disabled(deckName.isEmpty)  // Disable button if deck name is empty
            }
            .navigationTitle("Add New Deck")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()  // Dismiss the form when Cancel is tapped
            })
        }
    }
}

struct AddDeckForm_Previews: PreviewProvider {
    static var previews: some View {
        AddDeckForm(decks: .constant([]))  // Example preview with an empty deck list
    }
}

import SwiftUI

// Main view displaying all decks in a grid layout
struct ContentView: View {
    @ObservedObject var deckStore = DeckStore()  // Observes changes in the deck store (list of all decks)
    @State private var showingAddDeckForm = false  // Controls whether the Add Deck sheet is shown
    @State private var showingEditDeckForm: Deck? = nil  // Holds the deck to be edited (shows Edit Deck sheet when not nil)

    // Defines a grid layout with adaptive column width
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]

    var body: some View {
        NavigationView {  // Wraps everything in a navigation view for navigation bar and stack
            ScrollView {  // Allows vertical scrolling for all decks
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {  // Responsive grid for decks
                    ForEach($deckStore.decks) { $deck in  // Iterate through all decks using bindings
                        NavigationLink(destination: DeckDetailView(deck: $deck)) {  // Navigate to deck detail view when a deck is tapped
                            ZStack {  // Stack background and text
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color(.blue))  // Deck background color
                                    .cornerRadius(30)  // Rounded corners for deck card

                                VStack {  // Deck title and card count
                                    Text(deck.title)
                                        .foregroundColor(Color(.black))
                                        .font(.title2)
                                        .bold()
                                        .multilineTextAlignment(.center)

                                    Text("\(deck.cards.count) Cards")
                                        .foregroundColor(Color(.white))
                                        .font(.subheadline)
                                }
                            }
                        }
                        .contextMenu {  // Context menu for long press or right-click
                            Button(action: {
                                showingEditDeckForm = deck  // Opens edit sheet for this deck
                            }) {
                                Text("Edit Deck")
                                Image(systemName: "pencil")
                            }

                            Button(action: {
                                deleteDeck(deck: deck)  // Deletes the selected deck
                            }) {
                                Text("Delete Deck")
                                Image(systemName: "trash")
                            }
                        }
                        .onLongPressGesture {
                            showingEditDeckForm = deck  // Alternative trigger for editing deck via long press
                        }
                    }
                }
            }
            .padding()  // Adds padding around the grid
            .background(Color(.white))  // Sets the background color of the screen
            .navigationTitle("FlashDeck")  // Title at the top of the screen
            .toolbar {
                // "+" button to open Add Deck form
                Button(action: {
                    showingAddDeckForm.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(Color(.blue))
                }
            }
            // Sheet to add a new deck
            .sheet(isPresented: $showingAddDeckForm) {
                AddDeckForm(decks: $deckStore.decks)
            }
            // Sheet to edit a selected deck (shown when showingEditDeckForm is non-nil)
            .sheet(item: $showingEditDeckForm) { deck in
                if let index = deckStore.decks.firstIndex(where: { $0.id == deck.id }) {
                    EditDeckView(deck: $deckStore.decks[index])
                }
            }
        }
    }

    // Deletes a deck from the deck store
    private func deleteDeck(deck: Deck) {
        if let index = deckStore.decks.firstIndex(where: { $0.id == deck.id }) {
            deckStore.decks.remove(at: index)
        }
    }
}

// Preview provider for Xcode canvas preview
#Preview {
    ContentView()
}

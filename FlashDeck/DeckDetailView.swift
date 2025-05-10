import SwiftUI

// View to display the details of a deck, including all flashcards
struct DeckDetailView: View {
    @Binding var deck: Deck  // Binding to the deck being viewed and modified
    @State private var flippedIndices: Set<Int> = []  // Keeps track of flipped cards by their index
    @State private var selectedCardIndex: Int? = nil  // Index of the card being edited
    @State private var isEditingCard = false  // Controls whether the edit card sheet is showing

    // Defines a responsive grid layout with adaptive column size
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        ScrollView {  // Enables vertical scrolling for the content
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {  // Creates a grid layout for flashcards
                ForEach(deck.cards.indices, id: \.self) { index in  // Iterates over all card indices
                    FlashcardView(card: deck.cards[index], isFlipped: flippedIndices.contains(index))  // Renders each card with its flipped state
                        .onTapGesture {
                            toggleFlip(for: index)  // Toggles flip state when tapped
                        }
                        .padding()  // Adds padding around the card
                        .contextMenu {  // Context menu for card actions (long press or right-click)
                            Button(action: {
                                editCard(at: index)  // Opens edit sheet for selected card by calling private function
                            }) {
                                Text("Edit Card")
                                Image(systemName: "pencil")
                            }

                            Button(action: {
                                deleteCard(at: index)  // Deletes the selected card by calling private function
                            }) {
                                Text("Delete Card")
                                Image(systemName: "trash")
                            }
                        }
                }
            }
        }
        .navigationTitle(deck.title)  // Sets navigation title to the deck title
        .navigationBarTitleDisplayMode(.inline)  // Displays the title in inline mode
        .padding()  // Adds padding around the grid
        .toolbar {
            // Navigation link to AddCardView to allow adding a new card
            NavigationLink(destination: AddCardView(deck: $deck)) {
                Text("Add Card")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
        }
        // Sheet for editing an existing card
        .sheet(isPresented: $isEditingCard) {
            if let index = selectedCardIndex {
                EditCardView(card: $deck.cards[index])  // Presents the edit view for the selected card
            }
        }
    }

    // Toggles the flip state for a given card index
    private func toggleFlip(for index: Int) {
        if flippedIndices.contains(index) {
            flippedIndices.remove(index)
        } else {
            flippedIndices.insert(index)
        }
    }

    // Prepares to edit a card by setting the selected index and showing the sheet
    private func editCard(at index: Int) {
        selectedCardIndex = index
        isEditingCard = true
    }

    // Deletes the card at the specified index from the deck
    private func deleteCard(at index: Int) {
        deck.cards.remove(at: index)
    }
}

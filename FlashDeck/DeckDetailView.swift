import SwiftUI

struct DeckDetailView: View {
    @Binding var deck: Deck
    @State private var flippedIndices: Set<Int> = []
    @State private var selectedCardIndex: Int? = nil
    @State private var isEditingCard = false

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(deck.cards.indices, id: \.self) { index in
                    FlashcardView(card: deck.cards[index], isFlipped: flippedIndices.contains(index))
                        .onTapGesture {
                            toggleFlip(for: index)
                        }
                        .padding()
                        .contextMenu {
                            Button(action: {
                                editCard(at: index)
                            }) {
                                Text("Edit Card")
                                Image(systemName: "pencil")
                            }

                            Button(action: {
                                deleteCard(at: index)
                            }) {
                                Text("Delete Card")
                                Image(systemName: "trash")
                            }
                        }
                }
            }
        }
        .navigationTitle(deck.title)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .toolbar {
            NavigationLink(destination: AddCardView(deck: $deck)) {
                Text("Add Card")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
        }
        // 👇 Sheet for editing card
        .sheet(isPresented: $isEditingCard) {
            if let index = selectedCardIndex {
                EditCardView(card: $deck.cards[index])
            }
        }
    }

    private func toggleFlip(for index: Int) {
        if flippedIndices.contains(index) {
            flippedIndices.remove(index)
        } else {
            flippedIndices.insert(index)
        }
    }

    private func editCard(at index: Int) {
        selectedCardIndex = index
        isEditingCard = true
    }

    private func deleteCard(at index: Int) {
        deck.cards.remove(at: index)
    }
}

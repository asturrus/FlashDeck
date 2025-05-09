import SwiftUI

struct ContentView: View {
    @ObservedObject var deckStore = DeckStore()  // Observe the DeckStore for changes
    @State private var showingAddDeckForm = false
    @State private var showingEditDeckForm: Deck? = nil

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach($deckStore.decks) { $deck in
                        NavigationLink(destination: DeckDetailView(deck: $deck)) {
                            ZStack {
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color(.blue))
                                    .cornerRadius(30)

                                VStack {
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
                        .contextMenu {
                            Button(action: {
                                showingEditDeckForm = deck
                            }) {
                                Text("Edit Deck")
                                Image(systemName: "pencil")
                            }

                            Button(action: {
                                deleteDeck(deck: deck)
                            }) {
                                Text("Delete Deck")
                                Image(systemName: "trash")
                            }
                        }
                        .onLongPressGesture {
                            showingEditDeckForm = deck
                        }
                    }
                }
            }
            .padding()
            .background(Color(.white))
            .navigationTitle("FlashDeck")
            .toolbar {
                Button(action: {
                    showingAddDeckForm.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(Color(.blue))
                }
            }
            .sheet(isPresented: $showingAddDeckForm) {
                AddDeckForm(decks: $deckStore.decks)
            }
            .sheet(item: $showingEditDeckForm) { deck in
                if let index = deckStore.decks.firstIndex(where: { $0.id == deck.id }) {
                    EditDeckView(deck: $deckStore.decks[index])
                }
            }
        }
    }

    private func deleteDeck(deck: Deck) {
        if let index = deckStore.decks.firstIndex(where: { $0.id == deck.id }) {
            deckStore.decks.remove(at: index)
        }
    }
}

#Preview {
    ContentView()
}

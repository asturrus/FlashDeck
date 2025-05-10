import SwiftUI

// Model representing a single flashcard
struct Card: Identifiable, Codable {
    var id = UUID()  // Unique identifier for each card
    var question: String  // The front side of the card (the question)
    var answer: String    // The back side of the card (the answer)
}

// Model representing a deck that contains multiple cards
struct Deck: Identifiable, Codable {
    var id = UUID()  // Unique identifier for each deck
    var title: String  // Title of the deck (e.g., "Math", "Geography")
    var cards: [Card]  // Array of cards belonging to this deck
}

// Observable class that manages all decks and handles persistence
class DeckStore: ObservableObject {
    @Published var decks: [Deck] = [] {  // Publishes changes to the decks array
        didSet {
            saveDecks()  // Automatically save decks when they are modified
        }
    }

    private let decksKey = "decks"  // Key used to store/retrieve decks from UserDefaults

    // Called when DeckStore is initialized
    init() {
        loadDecks()  // Load saved decks from UserDefaults

        // If no decks were loaded (i.e., first launch), add some predefined sample decks
        if decks.isEmpty {
            addPredefinedDecks()
        }
    }

    // Saves decks to UserDefaults using JSON encoding
    func saveDecks() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(decks) {
            UserDefaults.standard.set(encoded, forKey: decksKey)  // Store encoded data under "decks" key
        }
    }

    // Loads decks from UserDefaults using JSON decoding
    func loadDecks() {
        if let savedDecks = UserDefaults.standard.data(forKey: decksKey) {
            let decoder = JSONDecoder()
            if let decodedDecks = try? decoder.decode([Deck].self, from: savedDecks) {
                decks = decodedDecks  // Assign loaded decks to the published variable
            }
        }
    }

    // Adds some default decks and cards for demonstration or first-time users
    private func addPredefinedDecks() {
        let mathDeck = Deck(title: "Math", cards: [
            Card(question: "2 + 2", answer: "4"),
            Card(question: "3 x 3", answer: "9")
        ])
        
        let geographyDeck = Deck(title: "Geography", cards: [
            Card(question: "Capital of France?", answer: "Paris")
        ])
        
        // Append predefined decks to the store
        decks.append(contentsOf: [mathDeck, geographyDeck])
    }
}

import SwiftUI

struct Card: Identifiable, Codable {
    var id = UUID()
    var question: String
    var answer: String
}

struct Deck: Identifiable, Codable {
    var id = UUID()
    var title: String
    var cards: [Card]
}

class DeckStore: ObservableObject {
    @Published var decks: [Deck] = [] {
        didSet {
            saveDecks() // Automatically save whenever decks change
        }
    }

    private let decksKey = "decks"

    init() {
        loadDecks() // Load decks when the app starts
        if decks.isEmpty {  // If no decks are loaded, add predefined ones
            addPredefinedDecks()
        }
    }

    func saveDecks() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(decks) {
            UserDefaults.standard.set(encoded, forKey: decksKey)
        }
    }

    func loadDecks() {
        if let savedDecks = UserDefaults.standard.data(forKey: decksKey) {
            let decoder = JSONDecoder()
            if let decodedDecks = try? decoder.decode([Deck].self, from: savedDecks) {
                decks = decodedDecks
            }
        }
    }

    // Add predefined decks if no decks exist
    private func addPredefinedDecks() {
        let mathDeck = Deck(title: "Math", cards: [
            Card(question: "2 + 2", answer: "4"),
            Card(question: "3 x 3", answer: "9")
        ])
        
        let geographyDeck = Deck(title: "Geography", cards: [
            Card(question: "Capital of France?", answer: "Paris")
        ])
        
        decks.append(contentsOf: [mathDeck, geographyDeck])
    }
}

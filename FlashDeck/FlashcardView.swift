import SwiftUI

// View to display a single flashcard with flip animation
struct FlashcardView: View {
    var card: Card               // The card to display (contains question and answer)
    var isFlipped: Bool          // Indicates whether the card is flipped

    @State private var rotation: Double = 0  // Tracks current rotation for animation (optional in this setup)

    var body: some View {
        ZStack {
            // FRONT of the card (Question Side)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)               // Blue background
                .shadow(radius: 10)             // Adds shadow for depth
                .frame(width: 170, height: 170) // Fixed card size
                .overlay(
                    ScrollView {                // Scrollable text for long questions
                        Text(card.question)
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)     // Allow multiple lines
                            .minimumScaleFactor(0.7) // Shrinks text to fit
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(width: 170, height: 170)  // Confines scroll area to card size
                )
                .rotation3DEffect(                  // Applies 3D rotation to simulate flipping
                    .degrees(isFlipped ? 180 : 0),  // Rotate 180° when flipped
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(isFlipped ? 0 : 1)         // Hide front when flipped

            // BACK of the card (Answer Side)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)              // White background
                .shadow(radius: 10)
                .frame(width: 170, height: 170)
                .overlay(
                    ScrollView {                // Scrollable text for long answers
                        Text(card.answer)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(width: 170, height: 170)
                )
                .rotation3DEffect(              // Flipped in reverse direction
                    .degrees(isFlipped ? 0 : 180),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(isFlipped ? 1 : 0)     // Show only when flipped
        }
        .onChange(of: isFlipped) { flipped in
            // Optional: smoothly adjust the `rotation` state (not directly used in rendering here)
            withAnimation {
                rotation = flipped ? 180 : 0
            }
        }
        .frame(width: 170, height: 170)         // Fixed card size
        .animation(.easeInOut(duration: 0.5), value: isFlipped) // Smooth flip animation
    }
}

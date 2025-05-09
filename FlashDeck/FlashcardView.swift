import SwiftUI

struct FlashcardView: View {
    var card: Card
    var isFlipped: Bool

    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            // Front of the card (Question)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .shadow(radius: 10)
                .frame(width: 170, height: 170)
                .overlay(
                    ScrollView {
                        Text(card.question)
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(width: 170, height: 170)  // Ensures the scrollable area stays within the card size
                )
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(isFlipped ? 0 : 1)

            // Back of the card (Answer)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 10)
                .frame(width: 170, height: 170)
                .overlay(
                    ScrollView {
                        Text(card.answer)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(width: 170, height: 170)  // Ensures the scrollable area stays within the card size
                )
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : 180),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(isFlipped ? 1 : 0)
        }
        .onChange(of: isFlipped) { flipped in
            withAnimation {
                rotation = flipped ? 180 : 0
            }
        }
        .frame(width: 170, height: 170)
        .animation(.easeInOut(duration: 0.5), value: isFlipped)
    }
}

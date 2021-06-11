//
//  ContentView.swift
//  Set
//
//  Created by Sergey Panchenko on 07.06.2021.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    var body: some View {
        VStack {
            CardsDeckView(
                cards: viewModel.cards,
                columnsCount: viewModel.numberOfCardsInRow,
                onCardTap: { card in viewModel.choose(card: card) }
            )
            HStack {
                gameControlButton(title: "Hints: ") {
                    viewModel.hintSet()
                }
                Spacer()
                gameControlButton(title: "Deal+3", disabled: viewModel.isAddingCardsNotAllowed) {
                    viewModel.addCards()
                }
                Spacer()
                gameControlButton(title: "New Game") {
                    viewModel.newGame()
                }
            }
            .padding(.horizontal)
        }
        .background(Color.purple.ignoresSafeArea())
    }
    
    private func gameControlButton(
        title: String,
        disabled: Bool = false,
        onTapAction: @escaping () -> Void
    ) -> some View {
        let contentColor: Color = disabled ? Color(UIColor.lightGray) : .orange
        return Button(action: onTapAction) {
            Text(title)
                .font(.title3)
                .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                    .stroke(contentColor, lineWidth: 3)
        )
        .foregroundColor(contentColor)
        .disabled(disabled)
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}

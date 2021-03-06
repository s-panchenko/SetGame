//
//  SetGameViewModel.swift
//  Set
//
//  Created by Sergey Panchenko on 08.06.2021.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var model = SetGame()
    
    var cards: [Card] {
        model.dealtCards
    }
    
    var numberOfCardsInRow: Int {
        model.numberOfCardsInRow
    }
    
    
    var isAddingCardsNotAllowed: Bool {
        !model.mayAddCards
    }
    
    func newGame() {
        model.startGame()
    }
    
    func addCards() {
        model.addCards()
    }
    
    func choose(card: Card) {
        model.choose(card: card)
    }
    
    func hintSet() {
        model.hintSet()
    }
}

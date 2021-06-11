//
//  CarddsDeck.swift
//  Set
//
//  Created by Sergey Panchenko on 10.06.2021.
//

import Foundation

struct CardsDeck {
    var cardsInDeck: [Card] = []
    let startingNumberOfCardsInDeck = 12
    let maxNumberOfCardsInDeck = 18
    let numberOfCardsInRow = 3
    let numberOfCardsThatShouldBeMatched = 3
    var mayAddCards: Bool { !cardsInDeck.isEmpty && cardsInDeck.count < maxNumberOfCardsInDeck }
    var shouldCardsBeMatches: Bool { cardsInDeck.filter { $0.isChosen }.count == numberOfCardsThatShouldBeMatched }
}

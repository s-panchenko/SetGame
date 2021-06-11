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
    
    var mayAddCards: Bool {
        !cardsInDeck.isEmpty && cardsInDeck.count < maxNumberOfCardsInDeck
    }
    
    var tooFewCards: Bool {
        cardsInDeck.count < startingNumberOfCardsInDeck
    }
    
    
    var cardsThatShouldBeMatched: [Card]? {
        let chosenCards = cardsInDeck.filter { $0.isChosen }
        let chosenCardsCount = chosenCards.count
        guard chosenCardsCount <= numberOfCardsThatShouldBeMatched else {
            fatalError("Incorrect number of chosen cards: \(chosenCardsCount)")
        }
        
        return chosenCardsCount == numberOfCardsThatShouldBeMatched ? chosenCards : nil
    }
    
    mutating func choose(card: Card) {
        let indexOfChosenCard = cardsInDeck.firstIndex { $0.id == card.id }!
        cardsInDeck[indexOfChosenCard].isChosen.toggle()
    }
    
    mutating func unchooseAll() {
        cardsInDeck.indices.forEach { index in
            cardsInDeck[index].isChosen = false
        }
    }
    
    mutating func removeFromDeck(cards: [Card]) {
        cardsInDeck.removeAll { cardFromDeck in
            cards.map { $0.id }.contains(cardFromDeck.id)
        }
    }
}

struct SetOfCards {
    let numberOfCardsInSet = 3
    var cards: (first: Card, second: Card, third: Card)
    
    init(cards: [Card]) {
        guard cards.count == numberOfCardsInSet else {
            fatalError("Incorrect number of cards for set: \(cards.count)")
        }
        self.cards = (cards[0], cards[1], cards[2])
    }
}

extension Array where Element == Card {
    var allSetMatched: Bool {
        let (first, second, third) = SetOfCards(cards: self).cards
        return (first.isMatched(with: second) == first.isMatched(with: third)) &&
            (first.isMatched(with: second) == second.isMatched(with: third))
    }
}

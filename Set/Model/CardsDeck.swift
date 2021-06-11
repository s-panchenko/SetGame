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
        !cardsInDeck.isEmpty && cardsInDeck.count < maxNumberOfCardsInDeck // add check if there are available cards in 81-deck
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
    
    mutating func hintSet() {
        outerLoop: for first in 0..<cardsInDeck.count-2 {
            for second in (first+1)..<cardsInDeck.count-1 {
                for third in (second+1)..<cardsInDeck.count {
                    let possibleSet = [cardsInDeck[first], cardsInDeck[second], cardsInDeck[third]]
                    if possibleSet.allSetMatched {
                        possibleSet.map { $0.id }.forEach { id in
                            let id = cardsInDeck.firstIndex { card in card.id == id }!
                            cardsInDeck[id].isHinted = true
                        }
                        break outerLoop
                    }
                }
            }
        }
    }
}

extension Array where Element == Card {
    var allSetMatched: Bool {
        let (first, second, third) = (self[0], self[1], self[2])
        return (first.isMatched(with: second) == first.isMatched(with: third)) &&
            (first.isMatched(with: second) == second.isMatched(with: third))
    }
}

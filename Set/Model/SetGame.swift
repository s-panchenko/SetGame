//
//  SetGameModel.swift
//  Set
//
//  Created by Sergey Panchenko on 08.06.2021.
//

import Foundation

struct SetGame {
    let maxCardsCount = 81
    let startingNumberOfDealtCards = 12
    let maxNumberOfDealtCards = 18
    let numberOfCardsInRow = 3
    let numberOfCardsThatShouldBeMatched = 3
    
    var cards: [Card] = []
    var dealtCards: [Card] = []
    
    var mayAddCards: Bool {
        !dealtCards.isEmpty && dealtCards.count < maxNumberOfDealtCards // add check if there are available cards in 81-deck
    }
    
    var cardsThatShouldBeMatched: [Card]? {
        let chosenCards = dealtCards.filter { $0.isChosen }
        let chosenCardsCount = chosenCards.count
        guard chosenCardsCount <= numberOfCardsThatShouldBeMatched else {
            fatalError("Incorrect number of chosen cards: \(chosenCardsCount)")
        }
        
        return chosenCardsCount == numberOfCardsThatShouldBeMatched ? chosenCards : nil
    }
    
    mutating func createCardsForGame() {
        cards = []
        Card.CardColor.allCases.forEach { color in
            Card.CardSymbol.allCases.forEach { symbol in
                Card.CardSymbolFilling.allCases.forEach { symbolFilling in
                    Card.SymbolsCount.allCases.forEach { symbolsNumber in
                        let card = Card(color: color, symbol: symbol, symbolsFilling: symbolFilling, symbolsCount: symbolsNumber)
                        cards.append(card)
                    }
                }
            }
        }
        guard cards.count == maxCardsCount else {
            fatalError("Incorrect number of cards created: \(cards.count)")
        }
        cards = cards.shuffled()
    }
    
    mutating func startGame() {
        createCardsForGame()
        dealtCards = Array(cards[..<startingNumberOfDealtCards])
        cards.removeSubrange(..<startingNumberOfDealtCards)
        guard cards.count == maxCardsCount - startingNumberOfDealtCards else {
            fatalError("Incorrect number of cards after game started: \(cards.count)")
        }
    }
    
    mutating func addCards() {
        let cardsCount = cards.count
        if mayAddCards {
            dealtCards = dealtCards + Array(cards[..<numberOfCardsInRow])
            cards.removeSubrange(..<numberOfCardsInRow)
            guard cards.count == cardsCount - numberOfCardsInRow else {
                fatalError("Incorrect number of cards after game started: \(cards.count)")
            }
        }
    }
    
    mutating func choose(card: Card) {
        let indexOfChosenCard = dealtCards.firstIndex { $0.id == card.id }!
        dealtCards[indexOfChosenCard].isChosen.toggle()
        if let cardsToMatch = cardsThatShouldBeMatched {
            if cardsToMatch.allSetMatched {
                dealtCards.removeAll { matchedCard in
                    cardsToMatch.map { $0.id }.contains(matchedCard.id)
                }
            } else {
                dealtCards.indices.forEach { index in
                    dealtCards[index].isChosen = false
                }
            }
            if dealtCards.count < startingNumberOfDealtCards {
                addCards()
            }
        }
        print("")
    }
    
    mutating func hintSet() {
        outerLoop: for first in 0..<dealtCards.count-2 {
            for second in (first+1)..<dealtCards.count-1 {
                for third in (second+1)..<dealtCards.count {
                    let possibleSet = [dealtCards[first], dealtCards[second], dealtCards[third]]
                    if possibleSet.allSetMatched {
                        possibleSet.map { $0.id }.forEach { id in
                            let id = dealtCards.firstIndex { card in card.id == id }!
                            dealtCards[id].isHinted = true
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

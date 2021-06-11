//
//  SetGameModel.swift
//  Set
//
//  Created by Sergey Panchenko on 08.06.2021.
//

import Foundation

struct SetGame {
    private var cards: [Card] = []
    private(set) var cardsDeck = CardsDeck()
    private let maxCardsCount = 81
    
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
        cardsDeck.cardsInDeck = Array(cards[..<cardsDeck.startingNumberOfCardsInDeck])
        cards.removeSubrange(..<cardsDeck.startingNumberOfCardsInDeck)
        guard cards.count == maxCardsCount - cardsDeck.startingNumberOfCardsInDeck else {
            fatalError("Incorrect number of cards after game started: \(cards.count)")
        }
    }
    
    mutating func addCards() {
        let cardsCount = cards.count
        if cardsDeck.mayAddCards {
            cardsDeck.cardsInDeck = cardsDeck.cardsInDeck + Array(cards[..<cardsDeck.numberOfCardsInRow])
            cards.removeSubrange(..<cardsDeck.numberOfCardsInRow)
            guard cards.count == cardsCount - cardsDeck.numberOfCardsInRow else {
                fatalError("Incorrect number of cards after game started: \(cards.count)")
            }
        }
    }
    
    mutating func choose(card: Card) {
        cardsDeck.choose(card: card)
        if let cardsToMatch = cardsDeck.cardsThatShouldBeMatched {
            if cardsToMatch.allSetMatched {
                cardsDeck.removeFromDeck(cards: cardsToMatch)
            } else {
                cardsDeck.unchooseAll()
            }
            if cardsDeck.tooFewCards {
                addCards()
            }
        }
    }
}

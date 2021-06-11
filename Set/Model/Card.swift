//
//  Card.swift
//  Set
//
//  Created by Sergey Panchenko on 08.06.2021.
//

import Foundation

struct Card: Identifiable {
    var id = UUID()
    var color: CardColor
    var symbol: CardSymbol
    var symbolsFilling: CardSymbolFilling
    var symbolsCount: SymbolsCount
    var isChosen = false
    
    enum CardColor: CaseIterable {
        case red, green, blue
    }
    
    enum CardSymbol: CaseIterable {
        case diamond, squiggle, oval
    }
    
    enum CardSymbolFilling: CaseIterable {
        case filled, stripped, empty
    }
    
    enum SymbolsCount: Int, CaseIterable {
        case one = 1, two, three
    }
}

extension Card: Matchable {
    typealias MatchResult = CardsMatchResult
    
    func isMatched(with other: Card) -> CardsMatchResult {
        CardsMatchResult(
            colorMatched: self.color == other.color,
            symbolMatched: self.symbol == other.symbol,
            symbolFillingMatched: self.symbolsFilling == other.symbolsFilling,
            symbolsCountMatched: self.symbolsCount == other.symbolsCount
        )
    }
    
    struct CardsMatchResult {
        var colorMatched: Bool
        var symbolMatched: Bool
        var symbolFillingMatched: Bool
        var symbolsCountMatched: Bool
    }
}

protocol Matchable {
    associatedtype MatchResult
    
    func isMatched(with other: Self) -> MatchResult
}

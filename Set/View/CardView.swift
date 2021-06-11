//
//  CardView.swift
//  Set
//
//  Created by Sergey Panchenko on 07.06.2021.
//

import SwiftUI

struct CardView: View {
    var card: Card
    var onTap: (Card) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ForEach(0..<card.symbolsCount.rawValue, id: \.self) { _ in
                    symbol
                        .frame(maxHeight: CardDrawing.cardSymbolHeight(cardHeight: geometry.size.height))
                        .padding(.horizontal)
                }
                Spacer()
            }
        }
        .foregroundColor(self.color)
        .background(Color.white)
        .cornerRadius(CardDrawing.cardCornerRadius)
        .overlay(CardDrawing.cardOverlay(isChosen: card.isChosen, isHinted: card.isHinted))
        .onTapGesture { onTap(card) }
    }
    
    struct CardDrawing {
        static let cardCornerRadius: CGFloat = 10
        static let cardBorderWidth: CGFloat = 5
        static let cardSymbolHeightScaleFactor: CGFloat = 0.65
        static let cardMaxSymbolsCount = CGFloat(Card.SymbolsCount.three.rawValue)
        
        static func cardOverlay(isChosen: Bool, isHinted: Bool) -> some View {
            let shouldBeStroked = isChosen || isHinted
            let color: Color = isChosen ? .orange : .green
            return shouldBeStroked ?
                RoundedRectangle(cornerRadius: cardCornerRadius)
                .stroke(color, lineWidth: cardBorderWidth) :
                nil
        }
        
        static func cardSymbolHeight(cardHeight: CGFloat) -> CGFloat {
            cardHeight / cardMaxSymbolsCount * cardSymbolHeightScaleFactor
        }
        
    }
}

extension CardView {
    private var color: Color {
        switch card.color {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        }
    }
    
    @ViewBuilder
    private var symbol: some View {
        switch card.symbol {
        case .diamond:
            fillSymbol(for: Diamond())
        case .squiggle:
            fillSymbol(for: Squiggle())
        case .oval:
            fillSymbol(for: Capsule())
        }
    }
    
    @ViewBuilder
    private func fillSymbol<S>(for symbol: S) -> some View where S: Shape {
        switch card.symbolsFilling {
        case .empty:
            symbol.blur()
        case .filled:
            symbol.fillAndBorder()
        case .stripped:
            symbol.stripe()
        }
                    
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(color: .green, symbol: .squiggle, symbolsFilling: .stripped, symbolsCount: .three)
        return CardView(card: card) { _ in }
    }
}

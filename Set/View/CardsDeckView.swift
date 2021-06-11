//
//  CardsDesk.swift
//  Set
//
//  Created by Sergey Panchenko on 10.06.2021.
//

import SwiftUI

struct CardsDeckView: View {
    var cards: [Card]
    var columnsCount: Int
    var onCardTap: (Card) -> Void
    private var rowsCount: Int {
        cards.count / columnsCount
    }
    
    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(columns: GridColumns(size: geometry.size)) {
                ForEach(cards) { card in
                    CardView(card: card, onTap: onCardTap) 
                        .aspectRatio(1, contentMode: .fit)
                }
            }
        }
    }
    
    private func GridColumns(size: CGSize) -> [GridItem] {
        let sizeForCards = sizeThatFits(width: size.width, height: size.height)
        return Array<GridItem>(
            repeating: .init(.flexible(minimum: sizeForCards, maximum: sizeForCards)),
            count: columnsCount
        )
    }
    
    private func sizeThatFits(width: CGFloat, height: CGFloat) -> CGFloat {
        return 0.9 * min(width / CGFloat(columnsCount), height / CGFloat(rowsCount))
    }
}

struct CardsDesk_Previews: PreviewProvider {
    static var previews: some View {
        let cards = Array(repeating: Card(color: .blue, symbol: .diamond, symbolsFilling: .filled, symbolsCount: .two), count: 12)
        return CardsDeckView(cards: cards, columnsCount: 3) { _ in }
            .background(Color.purple.ignoresSafeArea())
    }
}

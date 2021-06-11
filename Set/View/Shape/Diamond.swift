//
//  Diamond.swift
//  Set
//
//  Created by Sergey Panchenko on 07.06.2021.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let topPoint = CGPoint(x: rect.midX, y: rect.minY)
        let bottomPoint = CGPoint(x: rect.midX, y: rect.maxY)
        let rightPoint = CGPoint(x: rect.maxX, y: rect.midY)
        let leftPoint = CGPoint(x: rect.minX, y: rect.midY)
        
        var path = Path()
        path.addLines([topPoint, rightPoint, bottomPoint, leftPoint, topPoint])
        return path
    }
}

struct Diamond_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Diamond().stroke(lineWidth: 5)
            Diamond().fill()
            Diamond().stripe()
        }.padding()
    }
}


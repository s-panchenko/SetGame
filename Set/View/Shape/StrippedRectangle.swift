//
//  StrippedRectangle.swift
//  Set
//
//  Created by Sergey Panchenko on 07.06.2021.
//

import SwiftUI

struct StripedRectangle: Shape {
    var spacing: CGFloat = 10.0
    
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.minY)
        
        var path = Path()
        path.move(to: start)
        while path.currentPoint!.x < rect.maxX {
            path.addLine(to: CGPoint(x: path.currentPoint!.x, y: rect.maxY))
            path.move(to: CGPoint(x: path.currentPoint!.x + spacing, y: rect.minY))
        }
        return path
    }
}

struct StripedRect_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            Diamond().stripe()
            Diamond().stroke(lineWidth: 2)
        }.padding()
    }
}

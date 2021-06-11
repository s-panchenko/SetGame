//
//  Squiggle.swift
//  Set
//
//  Created by Sergey Panchenko on 07.06.2021.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        let sqdx = rect.width * 0.1
        let sqdy = rect.height * 0.2

        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addCurve(
            to: CGPoint(
                x: rect.minX + rect.width * 1/2,
                y: rect.minY + rect.height / 8
            ),
            control1: CGPoint(
                x: rect.minX,
                y: rect.minY
            ),
            control2: CGPoint(
                x: rect.minX + rect.width * 1/2 - sqdx,
                y: rect.minY + rect.height / 8 - sqdy
            )
        )
        path.addCurve(
            to: CGPoint(
                x: rect.minX + rect.width * 4/5,
                y: rect.minY + rect.height / 8
            ),
            control1: CGPoint(
                x: rect.minX + rect.width * 1/2 + sqdx,
                y: rect.minY + rect.height / 8 + sqdy
            ),
            control2: CGPoint(
                x: rect.minX + rect.width * 4/5 - sqdx,
                y: rect.minY + rect.height / 8 + sqdy
            )
        )
        path.addCurve(
            to: CGPoint(
                x: rect.minX + rect.width,
                y: rect.minY + rect.height / 2
            ),
            control1: CGPoint(
                x: rect.minX + rect.width * 4/5 + sqdx,
                y: rect.minY + rect.height / 8 - sqdy
            ),
            control2: CGPoint(
                x: rect.minX + rect.width,
                y: rect.minY
            )
        )
        
        var lower = path
        lower = lower.applying(CGAffineTransform.identity.rotated(by: CGFloat.pi))
        lower = lower.applying(CGAffineTransform.identity
                    .translatedBy(x: rect.size.width, y: rect.size.height))
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addPath(lower)
        
        return path
    }
}

struct Squiggle_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Squiggle().blur(5)
            Squiggle().fillAndBorder(5)
            Squiggle().stripe(5)
        }.padding()
    }
}

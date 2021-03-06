//
//  Shape+Extensions.swift
//  Set
//
//  Created by Sergey Panchenko on 07.06.2021.
//

import SwiftUI

extension Shape {
    
    func stripe(_ lineWidth: CGFloat = 2) -> some View {
        ZStack {
            StripedRectangle().stroke().clipShape(self)
            self.stroke(lineWidth: lineWidth)
        }
    }
    
    func blur(_ lineWidth: CGFloat = 2) -> some View {
        ZStack {
            self.fill().opacity(0.05)
            self.stroke(lineWidth: lineWidth)
        }
    }
    
    func fillAndBorder(_ lineWidth: CGFloat = 2) -> some View {
        ZStack {
            self.fill()
            self.stroke(lineWidth: lineWidth)
        }
    }
}

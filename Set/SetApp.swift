//
//  SetApp.swift
//  Set
//
//  Created by Sergey Panchenko on 07.06.2021.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: SetGameViewModel())
        }
    }
}

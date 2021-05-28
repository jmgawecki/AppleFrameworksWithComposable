//
//  CAAppApp.swift
//  CAApp
//
//  Created by Jakub Gawecki on 20/05/2021.
//

import SwiftUI
import ComposableArchitecture

@main
struct CAAppApp: App {
    var body: some Scene {
        WindowGroup {
         MainView(store:
                        Store(
                           initialState: AppState(
                              frameworks: MockData.frameworks,
                              selectedFramework: nil),
                           reducer: appReducer,
                           environment: AppEnvironment(uuid: UUID.init)
                        )
         )
        }
    }
}

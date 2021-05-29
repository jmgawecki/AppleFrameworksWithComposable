//
//  App.swift
//  CAApp
//
//  Created by Jakub Gawecki on 28/05/2021.
//

import Foundation
import ComposableArchitecture

// MARK: - App Structure

struct AppState: Equatable {
   var frameworks: [Framework] = MockData.frameworks
   var selectedFramework: Framework?
}

enum AppAction: Equatable {
   case framework(index: Int, frameworkAction: FrameworkAction)
   case frameworkDetailView(FrameworkAction)
   case frameworkSheetWentDown
}

struct AppEnvironment {
   var uuid: () -> UUID
}


let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
   frameworkReducer.forEach(
      state:            \AppState.frameworks,
      action:           /AppAction.framework(index:frameworkAction:),
      environment:      { _ in FrameworkEnvironment() }
   ),
   
   Reducer { state, action, environment in
      switch action {
      
      // MARK: - Framework Actions
      case .framework(index: let index, frameworkAction: FrameworkAction.didTapFramework):
         state.selectedFramework = state.frameworks[index]
         return .none
      
         
      case .framework(index: let index, frameworkAction: let frameworkAction):
         return .none
         
      // MARK: - FrameworkDetailView Actions
      case .frameworkDetailView(.didGoSafari):
         state.selectedFramework?.isShowingSafari = true
         return .none
         
      case .frameworkDetailView(.didCloseSafari):
         state.selectedFramework?.isShowingSafari = false
         return .none
         
      case .frameworkDetailView(.didCloseFramework):
//         state.selectedFramework = nil
         return Effect(value: .frameworkSheetWentDown)
         
      case .frameworkDetailView:
         return .none
         
      case .frameworkSheetWentDown:
         state.selectedFramework = nil
         return .none
      }
   }
)
.debug()

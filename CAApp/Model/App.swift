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
   case selectedFramework(Framework?)
   case dismissFrameworkDetailView
   case frameworkDetailView(FrameworkAction)
}

struct AppEnvironment { }


let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
   frameworkReducer.forEach(
      state:            \AppState.frameworks,
      action:           /AppAction.framework(index:frameworkAction:),
      environment:      { _ in FrameworkEnvironment() }
   ),
   
   Reducer { state, action, environment in
      switch action {
      case .framework(index: let index, frameworkAction: FrameworkAction.didTapFramework):
         state.selectedFramework = state.frameworks[index]
         return .none
         
      case .framework(index: let index, frameworkAction: let frameworkAction):
         return .none
         
      case .selectedFramework(let framework):
         state.selectedFramework = framework
         return .none
         
      case .dismissFrameworkDetailView:
         state.selectedFramework = nil
         return .none
         
      case .frameworkDetailView(.didGoSafari):
         /// This action will happen instead of the FrameworkAction
         state.selectedFramework?.isShowingSafari.toggle()
         return .none
         
      case .frameworkDetailView:
         return .none
      }
   }
)
.debug()

//
//  Framework.swift
//  CAApp
//
//  Created by Jakub Gawecki on 28/05/2021.
//

import Foundation
import ComposableArchitecture

// MARK: - Framework Structure

struct Framework: Identifiable, Equatable {
   let id               = UUID()
   var isShowingSafari  = false
   let name:            String
   let imageName:       String
   let urlString:       String
   let description:     String
}


enum FrameworkAction {
   case didTapFramework
   case didCloseFramework
   case didGoSafari
   case didCloseSafari
}


struct FrameworkEnvironment {}


let frameworkReducer = Reducer<Framework, FrameworkAction, FrameworkEnvironment> { framework, action, environment in
   switch action {
   case .didTapFramework:
      return .none
   case .didCloseFramework:
      return .none
   case .didGoSafari:
      /// This action will never happen!!! Action will be passed to AppAction of FrameworkDetailView
      framework.isShowingSafari.toggle()
      print("didGoSafari")
      return .none
   case .didCloseSafari:
      framework.isShowingSafari.toggle()
      print("didCloseSafari")
      return .none
   }
}

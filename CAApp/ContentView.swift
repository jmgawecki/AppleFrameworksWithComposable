//
//  ContentView.swift
//  CAApp
//
//  Created by Jakub Gawecki on 20/05/2021.
//

import SwiftUI
import ComposableArchitecture

// MARK: - App Structure

struct AppState: Equatable {
   var frameworks: [Framework] = MockData.frameworks
   var selectedFramework: Framework?
}

enum AppAction: Equatable {
   case framework(index: Int, frameworkAction: FrameworkAction)
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
      }
   }
)
.debug()




// MARK: - Framework Structure

struct Framework: Identifiable, Equatable {
   let id            = UUID()
   var isSelected    = false
   let name:         String
   let imageName:    String
   let urlString:    String
   let description:  String
}


enum FrameworkAction {
   case didTapFramework
   case didCloseFramework
   case didGoSafari
}


struct FrameworkEnvironment {}


let frameworkReducer = Reducer<Framework, FrameworkAction, FrameworkEnvironment> { framework, action, environment in
   switch action {
   case .didTapFramework:
      framework.isSelected.toggle()
      return .none
   case .didCloseFramework:
      framework.isSelected.toggle()
      return .none
   case .didGoSafari:
      print("didSafari")
      return .none
   }
}


// MARK: - View



struct ContentView: View {
   let store: Store<AppState, AppAction>
   let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
   var body: some View {
      WithViewStore(self.store) { viewStore in
         ScrollView {
            HStack {
               LazyVGrid(columns: columns, content: {
                  ForEachStore(
                     self.store.scope(
                        state: \.frameworks,
                        action: AppAction.framework(index:frameworkAction:)
                     ),
                     content: SmallView.init(store:)
                  )
               })
            }
         }
         
//         .sheet(item: viewStore., content: <#T##(Identifiable) -> View#>)
      }
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(store: Store(
                    initialState:   AppState(
                     frameworks: MockData.frameworks,
                     selectedFramework: nil),
                    reducer:        appReducer,
                    environment:    AppEnvironment()))
    }
}


struct SmallView: View {
   let store: Store<Framework, FrameworkAction>
   var body: some View {
      ZStack {
         WithViewStore(self.store) { framework in
            VStack {
                Image(framework.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                
                Text(framework.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .scaledToFit()              /// Will shrink if neeeded
                    .minimumScaleFactor(0.6)    /// But only down to 60%
            }
            .padding()
         }
      }
   }
}

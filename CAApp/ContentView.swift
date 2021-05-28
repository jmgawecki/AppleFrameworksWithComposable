//
//  ContentView.swift
//  CAApp
//
//  Created by Jakub Gawecki on 20/05/2021.
//

import SwiftUI
import ComposableArchitecture









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
            .sheet(
               item: viewStore.binding(
                  get: \.selectedFramework,
                  send: .dismissFrameworkDetailView
               )) { _ in 
               IfLetStore(
                  self.store.scope(
                     state: \.selectedFramework,
                     action: AppAction.frameworkDetailView
                  ),
                  then: FrameworkDetailView.init(store:)
               )
            }
         }
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
            .onTapGesture {
               framework.send(.didTapFramework)
            }
         }
      }
   }
}

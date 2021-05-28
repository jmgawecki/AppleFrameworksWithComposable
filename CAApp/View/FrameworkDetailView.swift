//
//  FrameworkDetailView.swift
//  CAApp
//
//  Created by Jakub Gawecki on 20/05/2021.
//

import SwiftUI
import ComposableArchitecture

struct FrameworkDetailView: View {
//    @Binding var isShowingDetailView: Bool
//    @State private var isShowingSafariView = false
   let store: Store<Framework, FrameworkAction>
    
    
   var body: some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            HStack {
               Spacer()
               CrossButton()
            }
            .padding(.trailing)
            Spacer()
            FrameworkTitleView(framework: viewStore.state)
            Description(framework: viewStore.state)
            Spacer()
            
            LearnMoreButtonView(store: store)
//            LearnMoreButtonView(
//               isShowingSafariView: viewStore.binding(
//                  get: \.isShowingSafari,
//                  send: FrameworkAction.didGoSafari)
//            )
         }
         .fullScreenCover(isPresented: viewStore.binding(
            get: \.isShowingSafari,
            send: FrameworkAction.didCloseSafari)
         ) {
            SafariView(url: URL(string: viewStore.urlString) ?? URL(string: "www.apple.co.uk")!)
         }
//                 .fullScreenCover(isPresented: view, content: {
//                     SafariView(url: URL(string: viewStore.urlString) ?? URL(string: "www.apple.co.uk")!)
//                 })
      }
   }
}

struct FrameworkElementView_Previews: PreviewProvider {
   static var previews: some View {
      FrameworkDetailView(
         store: Store<Framework, FrameworkAction>(
            initialState: MockData.sampleFramework,
            reducer: frameworkReducer,
            environment: FrameworkEnvironment()
         ))
         .preferredColorScheme(.dark)
   }
}

//MARK:- Views

struct CrossButton: View {
//    @Binding var isShowingDetailView: Bool
    var body: some View {
        Button {
//            isShowingDetailView = false
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(Color(.label))
                .imageScale(.large)
                .frame(width: 44, height: 44, alignment: .center)
        }
    }
}

struct Description: View {
    let framework: Framework
    
    var body: some View {
        Text(framework.description)
            .font(.body)
            .padding()
    }
}

struct LearnMoreButtonView: View {
   let store: Store<Framework, FrameworkAction>
   
    var body: some View {
      WithViewStore(self.store) { viewStore in
         Button {
            viewStore.send(.didGoSafari)
           } label: {
               Text("Learn More")
                   .font           (.title2)
                   .fontWeight     (.semibold)
                   .frame          (width: 280, height: 50, alignment: .center)
                   .background     (Color.red)
                   .foregroundColor(.white)
                   .cornerRadius   (10)
                   
        }
      }
    }
}



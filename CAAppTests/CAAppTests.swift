//
//  CAAppTests.swift
//  CAAppTests
//
//  Created by Jakub Gawecki on 20/05/2021.
//

import XCTest
@testable import CAApp
import ComposableArchitecture

class CAAppTests: XCTestCase {

   func testSelectingFramework() {
      // Arrange
      let store = TestStore(
         initialState: AppState(
            frameworks: [
               Framework(
                  id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!,
                  isShowingSafari: false,
                  name: "test",
                  imageName: "test",
                  urlString: "test",
                  description: "test")
            ],
            selectedFramework: nil),
         reducer: appReducer,
         environment: AppEnvironment(uuid: { UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")! }))
      
      // Act and Assert
      store.assert(
         .send(.framework(index: 0, frameworkAction: .didTapFramework)) {
            $0.selectedFramework = Framework(
               id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!,
               isShowingSafari: false,
               name: "test",
               imageName: "test",
               urlString: "test",
               description: "test")
         }
      )
   }
   
   
   func testDeselectingFramework() {
      // Arrange
      let store = TestStore(
         initialState: AppState(
            frameworks: [
               Framework(
                  id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!,
                  isShowingSafari: false,
                  name: "test",
                  imageName: "test",
                  urlString: "test",
                  description: "test")
            ],
            selectedFramework:
               Framework(
                  id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!,
                  isShowingSafari: false,
                  name: "test",
                  imageName: "test",
                  urlString: "test",
                  description: "test")
         ),
         reducer: appReducer,
         environment: AppEnvironment(uuid: { UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")! }))
      
      // Act and Assert
      store.assert(
         .send(.framework(index: 0, frameworkAction: .didCloseFramework)) {
            $0.selectedFramework = nil
         }
      )
   }
   
   func testDidTapSafariButton() {
      // Arrange
      let store = TestStore(
         initialState: AppState(
            frameworks: [
               Framework(
                  id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!,
                  isShowingSafari: false,
                  name: "test",
                  imageName: "test",
                  urlString: "test",
                  description: "test")
            ],
            selectedFramework: Framework(
               id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!,
               isShowingSafari: false,
               name: "test",
               imageName: "test",
               urlString: "test",
               description: "test")),
         reducer: appReducer,
         environment: AppEnvironment(uuid: { UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")! }))
      
      // Act and Assert
      store.assert(
         .send(.frameworkDetailView(.didGoSafari)) {
            $0.selectedFramework = Framework(
               id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!,
               isShowingSafari: true,
               name: "test",
               imageName: "test",
               urlString: "test",
               description: "test")
         }
      )
   }
   
   func testDidCloseSafari() {
      // Arrange
      let store = TestStore(
         initialState: AppState(
            frameworks: [
               Framework(
                  id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!,
                  isShowingSafari: false,
                  name: "test",
                  imageName: "test",
                  urlString: "test",
                  description: "test")
            ],
            selectedFramework: Framework(
               id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!,
               isShowingSafari: true,
               name: "test",
               imageName: "test",
               urlString: "test",
               description: "test")),
         reducer: appReducer,
         environment: AppEnvironment(uuid: { UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")! }))
      
      // Act and Assert
      store.assert(
         .send(.frameworkDetailView(.didCloseSafari)) {
            $0.selectedFramework = Framework(
               id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")!,
               isShowingSafari: false,
               name: "test",
               imageName: "test",
               urlString: "test",
               description: "test")
         }
      )
   }
}

//
//  FrameworkTitleView.swift
//  CAApp
//
//  Created by Jakub Gawecki on 20/05/2021.
//

import SwiftUI

struct FrameworkTitleView: View {
    var framework: Framework
    
    var body: some View {
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

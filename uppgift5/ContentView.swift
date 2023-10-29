//
//  ContentView.swift
//  uppgift5
//
//  Created by Jakob Lindell on 2023-10-29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            ImageView(imageInfo: ImageInfo(image: "zebra299", info: "Click image"))
            
            ImageView(imageInfo: ImageInfo(image: "lion299", info: "Click image"))
            
        }
        .padding()
    }
}

struct ImageInfo {
    let image: String
    var info: String
}

#Preview {
    ContentView()
}

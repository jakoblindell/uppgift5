//
//  ImageView.swift
//  uppgift5
//
//  Created by Jakob Lindell on 2023-10-29.
//


import SwiftUI

struct ImageView: View {
    
    @State var imageInfo: ImageInfo
    
    let imageClassificationModel = ImageClassificationModel()
    
    var body: some View {
        Button(action: {
            imageInfo.info = imageClassificationModel.classify(choosenImage: imageInfo.image).target
        }) {
            VStack {
                Image(imageInfo.image).resizable().frame(width: 150.0, height: 150.0)
                    .cornerRadius(20.0)
                    
                Text(imageInfo.info)
                    .font(.title2)
                    .foregroundColor(.yellow)
            }
        }
    }
}

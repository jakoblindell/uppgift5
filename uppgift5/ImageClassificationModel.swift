//
//  ImageClassificationModel.swift
//  uppgift5
//
//  Created by Jakob Lindell on 2023-10-29.
//

import Vision
import Foundation
import UIKit

class ImageClassificationModel {
    
    func classify(choosenImage: String) -> AnimalClassifierOutput {
        
        let defaultConfig = MLModelConfiguration()
        let imageClassifierWrapper = try? AnimalClassifier.init(configuration: defaultConfig)
        
        guard let imageClassifier = imageClassifierWrapper else {
            fatalError("Could not create imageClassifier")
        }
        
        guard let image = UIImage(named: choosenImage) else {
            fatalError("Could not find image")
        }
        
        guard let imageBuffer = buffer(from: image) else {
            fatalError("Could not get imageBuffer")
        }
        
        
        let output = try! imageClassifier.prediction(image: imageBuffer)
        
        return output
    }
    
    private func buffer(from image: UIImage) -> CVPixelBuffer? {
          let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
          var pixelBuffer : CVPixelBuffer?
          let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
          guard (status == kCVReturnSuccess) else {
            return nil
          }

          CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
          let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

          let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
          let context = CGContext(
            data: pixelData,
            width: Int(image.size.width),
            height: Int(image.size.height),
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!),
            space: rgbColorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
          )

          context?.translateBy(x: 0, y: image.size.height)
          context?.scaleBy(x: 1.0, y: -1.0)

          UIGraphicsPushContext(context!)
          image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
          UIGraphicsPopContext()
          CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

          return pixelBuffer
        }
}

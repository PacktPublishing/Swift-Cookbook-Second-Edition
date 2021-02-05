//
//  PhotoResizer.swift
//  PhotobookCreator
//
//  Created by Keith Moon on 05/05/2017.
//  Copyright © 2017 Keith Moon. All rights reserved.
//

import UIKit
import CoreImage

class PhotoResizer {
    
    let context = CIContext(options: [CIContextOption.useSoftwareRenderer: false])
    
    func smallestCommonSize(for photos: [UIImage]) -> CGSize {
        
        var smallestRect: CGRect? = nil
        
        photos.forEach { photo in
            
            let photoRect = CGRect(origin: .zero, size: photo.size)
            
            if let rect = smallestRect {
                smallestRect = rect.intersection(photoRect)
            } else {
                smallestRect = photoRect
            }
        }
        return smallestRect?.size ?? .zero
    }
    
    func scaleWithAspectFill(_ photos: [UIImage], to size: CGSize) -> [UIImage] {
        
        let scaledImages: [UIImage] = photos.compactMap { photo in
            
            guard let cgImage = photo.cgImage else { return nil }
            
            // Calculate scale needed to fit the size dimension
            let heightScale = size.height / photo.size.height
            let weightScale = size.width / photo.size.width
            let heightScaleDifference = abs(1 - heightScale)
            let weightScaleDifference = abs(1 - weightScale)
            
            let closestScale = heightScaleDifference < weightScaleDifference ? heightScale: weightScale
            let image = CIImage(cgImage: cgImage)
            
            let filter = CIFilter(name: "CILanczosScaleTransform")!
            filter.setValue(image, forKey: "inputImage")
            filter.setValue(closestScale, forKey: "inputScale")
            filter.setValue(1.0, forKey: "inputAspectRatio")
            
            guard let outputImage = filter.value(forKey: "outputImage") as? CIImage else { return nil }
            guard let scaledCGImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
            
            let scaledUIImage = UIImage(cgImage: scaledCGImage)
            return scaledUIImage
        }
        
        return scaledImages
    }
    
    func centerCrop(_ photos: [UIImage], to size: CGSize) -> [UIImage] {
        
        let croppedImages: [UIImage] = photos.compactMap { photo in
            
            guard let cgImage = photo.cgImage else { return nil }
            
            // Calculate center crop rect
            let x = (photo.size.width - size.width) / 2
            let y = (photo.size.height - size.height) / 2
            let croppingRect = CGRect(x: x, y: y, width: size.width, height: size.height)
            
            let croppedImage = CIImage(cgImage: cgImage).cropped(to: croppingRect)
            
            guard let scaledCGImage = context.createCGImage(croppedImage, from: croppedImage.extent) else { return nil }
            let scaledUIImage = UIImage(cgImage: scaledCGImage)
            return scaledUIImage
        }
        return croppedImages
    }
}

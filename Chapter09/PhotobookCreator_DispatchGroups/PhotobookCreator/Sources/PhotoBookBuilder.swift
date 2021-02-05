//
//  PhotoBookBuilder.swift
//  PhotobookCreator
//
//  Created by Keith Moon on 04/05/2017.
//  Copyright © 2017 Keith Moon. All rights reserved.
//

import Foundation
import UIKit

class PhotoBookBuilder {

    var outputFolderPath: String
    
    init(outputFolderPath: String) {
        self.outputFolderPath = outputFolderPath
    }
    
    convenience init() {
        let outputFolderPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        self.init(outputFolderPath: outputFolderPath)
    }
    
    func buildPhotobook(with photos: [UIImage]) -> URL {
        
        let outputFilename = UUID().uuidString
        let outputPath = outputFolderPath.appending("/\(outputFilename).pdf")
        
        // Start PDF Context
        UIGraphicsBeginPDFContextToFile(outputPath, .zero, nil)
        
        photos.forEach { image in
            
            let pageFrame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            
            UIGraphicsBeginPDFPageWithInfo(pageFrame, nil)
            
            // Draw image on page
            image.draw(in: pageFrame)
        }
        
        // Finish context
        UIGraphicsEndPDFContext()
        
        return URL(fileURLWithPath: outputPath)
    }
}

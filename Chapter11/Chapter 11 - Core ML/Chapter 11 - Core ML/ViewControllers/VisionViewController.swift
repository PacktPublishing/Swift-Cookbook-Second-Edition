//
//  VisionViewController.swift
//  Chapter 11 - Core ML
//
//  Created by Chris Barker on 16/01/2021.
//

import UIKit
import Vision
import AVFoundation

class VisionViewController: ViewController {
    
    private var detectionlayer: CALayer!
    private var requests = [VNRequest]()
    
    func startVision(){
        
        guard let localModel = Bundle.main.url(forResource: "YOLOv3", withExtension: "mlmodelc") else {
            return
        }
        
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: localModel))
            let objectRecognition = VNCoreMLRequest(model: visionModel, completionHandler: { (request, error) in
                
                DispatchQueue.main.async(execute: {
                    if let results = request.results {
                        self.visionResults(results)
                    }
                })
                
            })
            self.requests = [objectRecognition]
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
        
    override func setupCaptureSession() {
        
        super.setupCaptureSession()
        
        setupDetectionLayer()
        updateDetectionLayerGeometry()
        
        startVision()
        
    }
    
    func visionResults(_ results: [Any]) {
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        
        detectionlayer?.sublayers = nil
        
        for observation in results where observation is VNRecognizedObjectObservation {
            
            guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                continue
            }
            
            let labelObservation = objectObservation.labels.first
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox,
                                                            Int(bufferSize.width),
                                                            Int(bufferSize.height))
            
            let shapeLayer = createRoundedRectLayer(with: objectBounds)
            let textLayer = createTextSubLayer(with: objectBounds,
                                                       identifier: labelObservation?.identifier ?? "",
                                                       confidence: labelObservation?.confidence ?? 0.0)
            shapeLayer.addSublayer(textLayer)
            detectionlayer.addSublayer(shapeLayer)
            
        }
        
        updateDetectionLayerGeometry()
        CATransaction.commit()
        
    }
    
    
    func setupDetectionLayer() {
        detectionlayer = CALayer()
        detectionlayer.name = "detection.overlay"
        detectionlayer.bounds = CGRect(x: 0.0,
                                         y: 0.0,
                                         width: bufferSize.width,
                                         height: bufferSize.height)
        detectionlayer.position = CGPoint(x: rootLayer.bounds.midX, y: rootLayer.bounds.midY)
        rootLayer.addSublayer(detectionlayer)
    }
    
    func updateDetectionLayerGeometry() {
        
        let bounds = rootLayer.bounds
        var scale: CGFloat
        
        let xScale: CGFloat = bounds.size.width / bufferSize.height
        let yScale: CGFloat = bounds.size.height / bufferSize.width
        
        scale = fmax(xScale, yScale)
        if scale.isInfinite {
            scale = 1.0
        }
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        detectionlayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: scale, y: -scale))
        detectionlayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        
        CATransaction.commit()
        
    }
    
    func createTextSubLayer(with bounds: CGRect, identifier: String, confidence: VNConfidence) -> CATextLayer {
        
        let textLayer = CATextLayer()
        textLayer.name = "Detected Object Label"
        
        let formattedString = NSMutableAttributedString(string: String(format: "\(identifier)\nConfidence:  %.2f", confidence))
        let largeFont = UIFont.labelFontSize
        
        formattedString.addAttributes([NSAttributedString.Key.font: largeFont], range: NSRange(location: 0, length: identifier.count))
        
        textLayer.string = formattedString
        textLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.height - 10, height: bounds.size.width - 10)
        textLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        textLayer.shadowOpacity = 0.7
        textLayer.shadowOffset = CGSize(width: 2, height: 2)
        textLayer.foregroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.0, 0.0, 0.0, 1.0])
        textLayer.contentsScale = 2.0
        
        textLayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: 1.0, y: -1.0))
        
        return textLayer
    }
    
    func createRoundedRectLayer(with bounds: CGRect) -> CALayer {
        
        let shapeLayer = CALayer()
        
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        shapeLayer.name = "Detected Object"
        shapeLayer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 0.2, 0.4])
        shapeLayer.cornerRadius = 7
        
        return shapeLayer
        
    }
    
    // Override from our ViewController Delegate
    override func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let exifOrientation = ImageHelper.exifOrientationFromDeviceOrientation()
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }

}

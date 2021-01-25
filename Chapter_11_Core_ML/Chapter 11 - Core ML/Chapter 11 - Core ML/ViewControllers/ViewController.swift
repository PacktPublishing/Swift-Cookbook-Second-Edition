//
//  ViewController.swift
//  Chapter 11 - Core ML
//
//  Created by Chris Barker on 10/01/2021.
//

import UIKit
import Vision
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    private var previewLayer: AVCaptureVideoPreviewLayer! = nil
    var captureSession = AVCaptureSession()
    
    var bufferSize: CGSize = .zero
    var rootLayer: CALayer! = nil
    
    var model: Resnet50!
    
    // Video Output
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let videoDataOutputQueue = DispatchQueue(label: "video.data.output.queue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = Resnet50()
        setupCaptureSession()
    }

    @IBAction func onSelectPhoto(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        
        present(picker, animated: true)
        
    }
    
    @IBAction func onInputTypeSelected(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            captureSession.stopRunning()
        case 1:
            //performSegue(withIdentifier: "livePreviewSegue", sender: nil)
            startLivePreview()
        default:
            print("Default case")
        }
        
    }
    
    func setupCaptureSession() {
        
        var deviceInput: AVCaptureDeviceInput!
        
        guard let videoDevice =
                AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                 mediaType: .video,
                                                 position: .back).devices.first else {
            return
        }
        
        do {
            deviceInput = try AVCaptureDeviceInput(device: videoDevice)
        } catch {
            print(error.localizedDescription)
            return
        }

        captureSession.beginConfiguration()
        captureSession.sessionPreset = .medium
        
        guard captureSession.canAddInput(deviceInput) else {
            captureSession.commitConfiguration()
            return
        }
        captureSession.addInput(deviceInput)
        
        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            captureSession.commitConfiguration()
            return
        }
        
        do {
            try  videoDevice.lockForConfiguration()
            let dimensions = CMVideoFormatDescriptionGetDimensions((videoDevice.activeFormat.formatDescription))
            bufferSize.width = CGFloat(dimensions.width)
            bufferSize.height = CGFloat(dimensions.height)
            videoDevice.unlockForConfiguration()
        } catch {
            print(error)
        }
        
        captureSession.commitConfiguration()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        rootLayer = imageView.layer
        previewLayer.frame = rootLayer.bounds
        rootLayer.addSublayer(previewLayer)
        
    }
        
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput, didDrop didDropSampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    }
        
    func startLivePreview() {
        captureSession.startRunning()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        let (newImage, pixelBuffer) = ImageHelper.processImageData(capturedImage: image)
        
        imageView.image = newImage
        
        var imagePredictionText = "no idea... lol"
        
        guard let prediction = try? model.prediction(image: pixelBuffer!) else {
            labelView.text = imagePredictionText
            dismiss(animated: true, completion: nil)
            return
        }
        
        imagePredictionText = prediction.classLabel
        
        labelView.text = "I think this is a \(imagePredictionText)"
        
        dismiss(animated: true, completion: nil)
    }
    
}

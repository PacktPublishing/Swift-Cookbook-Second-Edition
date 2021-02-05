//
//  PhotoCollectionViewController.swift.swift
//  PhotobookCreator
//
//  Created by Keith Moon on 5/4/17.
//  Copyright © 2017 Keith Moon. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation
import Photos
import Dispatch

class PhotoCollectionViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var activityIndicator = UIActivityIndicatorView(style: .gray)
    
    var photos = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveSamplePhotos()
        setupBarButtonItems()
    }
    
    // MARK: - Generate Photo Book
    
    @IBAction func generateButtonPressed(sender: UIBarButtonItem) {
        
        activityIndicator.startAnimating()
        
        generatePhotoBook(with: photos) { [activityIndicator] photobookURL in
            
            activityIndicator.stopAnimating()
            
            let previewController = UIDocumentInteractionController(url: photobookURL)
            previewController.delegate = self
            previewController.presentPreview(animated: true)
        }
    }
    
    let processingQueue = DispatchQueue(label: "Photo processing queue")
    
    func generatePhotoBook(with photos: [UIImage], completion: @escaping (URL) -> Void) {
        
        processingQueue.async {
            
            let resizer = PhotoResizer()
            let builder = PhotoBookBuilder()
            
            // Get smallest common size 
            let size = resizer.smallestCommonSize(for: photos)
            
            // Scale down (can take a while)
            var photosForBook = resizer.scaleWithAspectFill(photos, to: size)
            // Crop (can take a while)
            photosForBook = resizer.centerCrop(photosForBook, to: size)
            // Generate PDF (can take a while)
            let photobookURL = builder.buildPhotobook(with: photosForBook)
            
            DispatchQueue.main.async {
                completion(photobookURL)
            }
        }
    }
    
    // MARK: - Setup
    
    func setupBarButtonItems() {
        
        // Setup Activity Indicator
        activityIndicator.hidesWhenStopped = true
        let barButtonItem = UIBarButtonItem(customView: activityIndicator)
        
        // Setup Edit Button
        let editButon = editButtonItem
        editButon.target = self
        editButon.action = #selector(editPhotos(sender:))
        
        navigationItem.rightBarButtonItems = [editButon, barButtonItem]
    }
    
    func retrieveSamplePhotos() {
        
        let fileManager = FileManager.default
        let bundle = Bundle.main
        
        guard let samplePhotosFolderPath = bundle.resourcePath?.appending("/SamplePhotos/") else { return }
        guard let photoPaths = try? fileManager.contentsOfDirectory(atPath: samplePhotosFolderPath) else { return }
        
        photos = photoPaths.compactMap { UIImage(contentsOfFile: samplePhotosFolderPath.appending($0)) }
    }
    
    // MARK: - Add Photo
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        showPhotoSourceSelector()
    }
    
    func showPhotoSourceSelector() {
        
        let actionSheet = UIAlertController(title: "Add photo", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let camera = UIAlertAction(title: "Camera", style: .default) { [weak self] action in
                self?.checkAndShowCamera()
            }
            actionSheet.addAction(camera)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let photoAlbum = UIAlertAction(title: "Photo Album", style: .default) { [weak self] action in
                self?.checkAndShowPhotoLibraryPicker()
            }
            actionSheet.addAction(photoAlbum)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func checkAndShowPhotoLibraryPicker() {
        handle(PHPhotoLibrary.authorizationStatus())
    }
    
    func handle(_ status: PHAuthorizationStatus) {
        
        switch status {
            
        case .authorized:
            showPhotoLibraryPicker()
            
        case .denied, .restricted:
            showPermissionDeniedAlert()
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] newStatus in
                self?.handle(newStatus)
            }
        case .limited:
            print("Limited")
            
        @unknown default:
            print("Unknown")
        }
    }
    
    func checkAndShowCamera() {
        
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
            
        case .authorized:
            showCamera()
            
        case .denied, .restricted:
            showPermissionDeniedAlert()
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { [weak self] granted in
                granted ? self?.showCamera() : self?.showPermissionDeniedAlert()
            }
        @unknown default:
            print("Unknown")
        }
    }
    
    func showPhotoLibraryPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary;
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func showCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera;
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func showPermissionDeniedAlert() {
        let alert = UIAlertController(title: "Permission Denied", message: "Please check your settings", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Edit Photo
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        tableView.setEditing(editing, animated: animated)
        super.setEditing(editing, animated: animated)
    }
    
    @objc func editPhotos(sender: UIBarButtonItem) {
        setEditing(!tableView.isEditing, animated: true)
    }
}

extension PhotoCollectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let photo = photos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)
        cell.imageView?.image = photo
        cell.textLabel?.text = "\(Int(photo.size.width)) x \(Int(photo.size.height))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            photos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let photoToMove = photos[sourceIndexPath.row]
        photos.remove(at: sourceIndexPath.row)
        photos.insert(photoToMove, at: destinationIndexPath.row)
        
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
}

extension PhotoCollectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
}

extension PhotoCollectionViewController: UIDocumentInteractionControllerDelegate {
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return navigationController!
    }
}

extension PhotoCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        defer {
            dismiss(animated: true, completion: nil)
        }
        
        guard let chosenPhoto: UIImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage else { return }
        
        photos.append(chosenPhoto)
        tableView.reloadData()
    }
}

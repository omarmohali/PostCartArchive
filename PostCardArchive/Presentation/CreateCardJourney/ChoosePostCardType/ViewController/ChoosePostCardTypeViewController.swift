//
//  ChoosePostCardTypeViewController.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import UIKit

class ChoosePostCardTypeViewController: ViewController<ChoosePostCardTypeViewModel> {

    private lazy var imagePickerController: UIImagePickerController = {
        let pickerController = UIImagePickerController()
        pickerController.mediaTypes = ["public.image"]
        pickerController.delegate = self
        return pickerController
    }()
    
    @IBOutlet private var regularCardButton: UIButton! {
        didSet {
            regularCardButton.setTitle("Regular Card", for: .normal)
        }
    }
    
    @IBOutlet private var foldableCardButton: UIButton! {
        didSet {
            foldableCardButton.setTitle("Foldable Card", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func actionOfRegularCardButton() {
        viewModel.didClickOnRegularCard()
        presentImageOptions()
    }
    
    @IBAction private func actionOfFoldableCardButton() {
        viewModel.didClickOnFoldableCard()
        presentImageOptions()
    }
    
    private func presentImageOptions() {
        let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            [weak self] _ in
            self?.presentCamera()
        })
        
        let photosAction = UIAlertAction(title: "Photos", style: .default, handler: {
            [weak self] _ in
            self?.presentPhotos()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func presentCamera() {
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func presentPhotos() {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

}

extension ChoosePostCardTypeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage, let imageData = image.jpegData(compressionQuality: 1) else {
            return
        }
 
        picker.dismiss(animated: true, completion: {
            [weak self] in
            self?.viewModel.didChooseImage(imageData)
        })
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

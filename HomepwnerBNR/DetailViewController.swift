//
//  DetailViewController.swift
//  HomepwnerBNR
//
//  Created by Anatoliy Chernyuk on 1/5/18.
//  Copyright © 2018 Anatoliy Chernyuk. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    var imageStore: ImageStore!
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - View Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        let imageToDisplay = imageStore.image(forKey: item.itemKey)
        imageView.image = imageToDisplay
        
        if imageToDisplay != nil {
            trashButton.isEnabled = true
        } else {
            trashButton.isEnabled = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image: UIImage
        if info[UIImagePickerControllerEditedImage] == nil {
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        } else {
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }
        imageStore.setImage(image, forKey: item.itemKey)
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = true
            //Solution to the Golden Challenge of the Chaper 15
            let image = UIImage(named: "crosshair")
            let iView = UIImageView(frame: CGRect(x: imagePickerController.cameraOverlayView!.bounds.midX - 40, y: imagePickerController.cameraOverlayView!.bounds.midY - 70, width: 80, height: 80))
            iView.image = image
            imagePickerController.cameraOverlayView = iView
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func deletePicture(_ sender: UIBarButtonItem) {
        if imageView.image != nil {
            let controller = UIAlertController(title: "Delete Photo", message: "Are you sure to delete permanently the item's photo?", preferredStyle: .actionSheet)
            let oKAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
                self.imageView.image = nil
                self.imageStore.deleteImage(forKey: self.item.itemKey)
                self.trashButton.isEnabled = false
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            controller.addAction(oKAction)
            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeDate" {
            let datePickerController = segue.destination as! DatePickerController
            datePickerController.item = item
        }
    }
}














































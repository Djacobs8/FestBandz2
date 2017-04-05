//
//  BandViewController.swift
//  FestBandz2
//
//  Created by Derek Jacobs on 2017-04-04.
//  Copyright © 2017 Derek Jacobs. All rights reserved.
//

import UIKit

class BandViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var bandImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    var band : Band? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        // if nil it is not an existing wrist band, if not nil, it exists in the core data
        if band != nil {
            bandImageView.image = UIImage(data: band!.image as! Data)
            titleTextField.text = band!.title
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true  // hides the delete button
            print("We have no band")
        }
    }

    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary // existing photos
        
        present(imagePicker, animated: true, completion: nil) // give user something to pick from
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        bandImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera // use the cam!
        
        present(imagePicker, animated: true, completion: nil) // give user something to pick from
        
    }

    @IBAction func addTapped(_ sender: Any) {
        if band != nil{
            band!.title = titleTextField.text
            band!.image = UIImagePNGRepresentation(bandImageView.image!) as! NSData
        } else {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let band = Band(context: context)
        band.title = titleTextField.text
        band.image = UIImagePNGRepresentation(bandImageView.image!) as! NSData // forced to downcast to NSData atm
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext() // saves to core data hopefully
        
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(band!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext() // saves to core data hopefully
        
        navigationController!.popViewController(animated: true)
        
    }
    
}

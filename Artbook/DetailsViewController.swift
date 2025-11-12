//
//  DetailsViewController.swift
//  Artbook
//
//  Created by Zeynep Betül Kaya on 11.11.2025.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldArtist: UITextField!
    @IBOutlet weak var textFieldYear: UITextField!
    
    var chosenPainting = ""
    var chosenPaintingId: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if chosenPainting != "" {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = chosenPaintingId?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            textFieldName.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String {
                            textFieldArtist.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int {
                            textFieldYear.text = String(year)
                        }
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }
            } catch {
                print("error")
            }
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(recognizer)
        
        let recognizerPicker = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(recognizerPicker)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        newPainting.setValue(textFieldName.text!, forKey: "name")
        newPainting.setValue(textFieldArtist.text!, forKey: "artist")
        if let year = Int(textFieldYear.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("saved")
        } catch {
            print("error")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }

}

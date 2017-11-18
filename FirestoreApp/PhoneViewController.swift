//
//  PhoneViewController.swift
//  FirestoreApp
//
//  Created by Rodrigo Cocate on 17/11/17.
//  Copyright © 2017 FIAP. All rights reserved.
//

import UIKit
import Firebase

class PhoneViewController: UIViewController {

    @IBOutlet weak var tfModel: UITextField!
    @IBOutlet weak var tfManufacturer: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfYear: UITextField!
    
    lazy var firestore: Firestore = {
        let store = Firestore.firestore()
        return store
    }()
    
    var phone: Phone!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if phone != nil {
            tfModel.text = phone.model
            tfYear.text = "\(phone.year)"
            tfPrice.text = "\(phone.price)"
            tfManufacturer.text = phone.manufacturer
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btSave(_ sender: UIButton) {
        var phoneDict: [String: Any] = [:]
        phoneDict["model"] = tfModel.text!
        phoneDict["manufacturer"] = tfManufacturer.text!
        phoneDict["price"] = Double(tfPrice.text!)! //NumberFormatter
        phoneDict["year"] = Int(tfYear.text!)!
        
        if phone == nil {
            firestore.collection("phones").addDocument(data: phoneDict) {
                (error: Error?) in
                self.navigationController!.popViewController(animated: true)
            }
        } else {
            firestore.collection("phones").document(phone.id).setData(phoneDict, completion: {
                (error: Error?) in
                self.navigationController!.popViewController(animated: true)
            })
        }
    }
}

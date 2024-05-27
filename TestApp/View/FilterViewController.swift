//
//  FilterViewController.swift
//  TestApp
//
//  Created by Prasad Lokhande on 23/05/24.
//

import UIKit

class FilterViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var txtMaxSalary: UITextField!
    @IBOutlet weak var txtMinSalary: UITextField!
    @IBOutlet weak var txtNameSalary: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtNameSalary.delegate = self
//        txtNameSalary.addTarget(self, action: #selector(textFieldDidChange), for:.editingChanged)
        txtNameSalary.addTarget(self, action: #selector(FilterViewController.textFieldDidChange(_:)), for: .editingChanged)
        txtMaxSalary.addTarget(self, action: #selector(FilterViewController.textFieldDidChange(_:)), for: .editingChanged)
        txtMinSalary.addTarget(self, action: #selector(FilterViewController.textFieldDidChange(_:)), for: .editingChanged)


    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField == txtNameSalary) {
            print("Edited \(String(describing: txtNameSalary.text))")
            
        }
        if (textField == txtMaxSalary) {
            print("Edited Max \(String(describing: txtMaxSalary.text))")
            
        }
        if (textField == txtMinSalary) {
            print("Edited Min \(String(describing: txtMinSalary.text))")
            
        }
//        print("Edited \(String(describing: txtNameSalary.text))")

    }
    
//    @objc func textFieldDidChange() {
//        
//        print("Edited \(String(describing: txtNameSalary.text))")
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onOKButtonPressed(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
    
}

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
    
    @IBOutlet weak var btnNoFilter: UIButton!
    @IBOutlet weak var btnSalaryMin: UIButton!
    @IBOutlet weak var btnSalaryMax: UIButton!
    @IBOutlet weak var btnNameEquals: UIButton!
    @IBOutlet weak var btnNameContains: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtNameSalary.delegate = self
//        txtNameSalary.addTarget(self, action: #selector(textFieldDidChange), for:.editingChanged)
        txtNameSalary.addTarget(self, action: #selector(FilterViewController.textFieldDidChange(_:)), for: .editingChanged)
        txtMaxSalary.addTarget(self, action: #selector(FilterViewController.textFieldDidChange(_:)), for: .editingChanged)
        txtMinSalary.addTarget(self, action: #selector(FilterViewController.textFieldDidChange(_:)), for: .editingChanged)


    }
    @IBAction func btnNoFilterTapped(_ sender: Any) {

    }
    @IBAction func btnSalaryMinTapped(_ sender: Any) {
    }
    @IBAction func btnSalaryMaxTapped(_ sender: Any) {
    }
    @IBAction func btnNameEqualsTapped(_ sender: Any) {
    }
    @IBAction func btnNameContainsTapped(_ sender: Any) {
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

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    @IBAction func onOKButtonPressed(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
    @IBAction func didTapButton(_ sender: UIButton) {
        for button in self.view.subviews as [UIView] {
            if button is UIButton {
                 // Do whatever you want
                button.backgroundColor = UIColor.blue
                 button.layer.borderColor = button.tag == sender.tag ? UIColor.blue.cgColor : UIColor.lightGray.cgColor
            }
        }
    }
    
}

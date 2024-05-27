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
    
    @IBOutlet weak var lblNameEqualTo: UILabel!
    @IBOutlet weak var lblNameContains: UILabel!
    @IBOutlet weak var lblSalaryLessThan: UILabel!
    @IBOutlet weak var lblSalaryMoreThan: UILabel!
    
    
    
    var buttons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        buttons = [btnSalaryMin, btnSalaryMax, btnNameEquals, btnNameContains, btnNoFilter]
                setupButtons()
        // Do any additional setup after loading the view.
        txtNameSalary.delegate = self
//        txtNameSalary.addTarget(self, action: #selector(textFieldDidChange), for:.editingChanged)
        txtNameSalary.addTarget(self, action: #selector(FilterViewController.textFieldDidChange(_:)), for: .editingChanged)
        txtMaxSalary.addTarget(self, action: #selector(FilterViewController.textFieldDidChange(_:)), for: .editingChanged)
        txtMinSalary.addTarget(self, action: #selector(FilterViewController.textFieldDidChange(_:)), for: .editingChanged)


    }
    private func setupButtons() {
            for button in buttons {
                button.setImage(UIImage(systemName: "circle"), for: .normal)
                button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
                button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            }
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
            lblNameEqualTo.text = "Name Equals to - \(txtNameSalary.text ?? "-")"
            lblNameContains.text = "Name Contains to - \(txtNameSalary.text ?? "-")"
            
        }
        if (textField == txtMaxSalary) {
            print("Edited Max \(String(describing: txtMaxSalary.text))")
            lblSalaryMoreThan.text = "Salary is More than - \(txtMaxSalary.text ?? "-")"
        }
        if (textField == txtMinSalary) {
            print("Edited Min \(String(describing: txtMinSalary.text))")
            lblSalaryMoreThan.text = "Salary is less than - \(txtMinSalary.text ?? "-")"

            
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    @IBAction func onOKButtonPressed(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
    @IBAction func didTapButton(_ sender: UIButton) {
        
        for button in buttons {
                    button.isSelected = false
                }
                sender.isSelected = true
            }
    
}

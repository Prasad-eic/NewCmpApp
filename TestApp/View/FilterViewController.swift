//
//  FilterViewController.swift
//  TestApp
//
//  Created by Prasad Lokhande on 23/05/24.
//

import UIKit
protocol sendFilterDataDelegate: AnyObject {
    func sentFilterData(Val:Int , SalaryORName:String)
}
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
    
    weak var delegate: sendFilterDataDelegate? = nil

    
    var buttons: [UIButton] = []
    var selectedFilterVal:Int? = 100

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
        selectedFilterVal = 0
    }
    @IBAction func btnSalaryMinTapped(_ sender: Any) {
//        if txtMaxSalary.text!.isEmpty {
//            
//            showAlertView(msgString: "Please add Salary")
//            return
//        }
        selectedFilterVal = 2

    }
    @IBAction func btnSalaryMaxTapped(_ sender: Any) {
        selectedFilterVal = 1

    }
    @IBAction func btnNameEqualsTapped(_ sender: Any) {
        selectedFilterVal = 3

    }
    @IBAction func btnNameContainsTapped(_ sender: Any) {
        selectedFilterVal = 4

    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField == txtNameSalary) {
            print("Edited \(String(describing: txtNameSalary.text))")
            lblNameEqualTo.text = "\(Constants.nameEqualsTo) \(txtNameSalary.text ?? "-")"
            lblNameContains.text = "\(Constants.nameContains)\(txtNameSalary.text ?? "-")"
            
        }
        if (textField == txtMaxSalary) {
            print("Edited Max \(String(describing: txtMaxSalary.text))")
            lblSalaryMoreThan.text = "\(Constants.salaryIsMore) \(txtMaxSalary.text ?? "-")"
        }
        if (textField == txtMinSalary) {
            print("Edited Min \(String(describing: txtMinSalary.text))")
            lblSalaryLessThan.text = "\(Constants.salaryIsLess) \(txtMinSalary.text ?? "-")"

            
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    @IBAction func onOKButtonPressed(_ sender: UIButton) {
            
        print(selectedFilterVal ?? 000)
        
        if (selectedFilterVal == 100) || (txtMaxSalary.text!.isEmpty && txtMinSalary.text!.isEmpty && txtNameSalary.text!.isEmpty) {
            
            showAlertView(msgString: Constants.salary_Name_Req)
        }
        else{
            self.dismiss(animated: true, completion: nil)

            if selectedFilterVal == 1 {

                delegate?.sentFilterData(Val: selectedFilterVal ?? 00, SalaryORName: txtMaxSalary.text ?? ""); return }
            
            if selectedFilterVal == 2 {
                delegate?.sentFilterData(Val: selectedFilterVal ?? 00, SalaryORName: txtMinSalary.text ?? ""); return}
            
            if (selectedFilterVal == 3) || (selectedFilterVal == 4) {
                delegate?.sentFilterData(Val: selectedFilterVal ?? 00, SalaryORName: txtNameSalary.text ?? ""); return  }
            else{
                self.dismiss(animated: true, completion: nil)
                delegate?.sentFilterData(Val: selectedFilterVal ?? 00, SalaryORName: txtNameSalary.text ?? "")}
            
            

        }
       }
    @IBAction func didTapButton(_ sender: UIButton) {
        
        for button in buttons {
                    button.isSelected = false
                }
                sender.isSelected = true
            }
    
    func showAlertView(msgString:String) {
        let alert = UIAlertController(title: Constants.alert, message: msgString, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
    }
    
}


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
    @IBOutlet weak var lblNofilter: UILabel!
    @IBOutlet weak var lblMinSalary: UILabel!
    @IBOutlet weak var lblMaxSalary: UILabel!
    @IBOutlet weak var lblNamePart_of_Name: UILabel!

    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var viewForSalaryMax: UIView!
    @IBOutlet weak var viewForSalaryMin: UIView!
    @IBOutlet weak var viewForNameContains: UIView!
    @IBOutlet weak var viewForNameEqualTo: UIView!
    @IBOutlet weak var viewForNoFilter: UIView!


    
    
    weak var delegate: sendFilterDataDelegate? = nil
    var language = Constants.getlan ?? "--"
    
    var buttons: [UIButton] = []
    var selectedFilterVal:Int? = 100
    var passedFilterVal:Int?
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
        print(Constants.getlan ?? "")

        language = (UserDefaults.standard.object(forKey: "AppLanguage") as? String ?? "QQQQ")
        print("----\(language)")
        lblNameContains.text = "Name Contains".localizeString(string:language )
        lblNameEqualTo.text = "Name Equals to".localizeString(string: language)
        lblSalaryLessThan.text = "Salary is less than".localizeString(string: language)
        lblSalaryMoreThan.text = "Salary is more than".localizeString(string: language)
        
        lblNofilter.text = "No Filter".localizeString(string: language)
        lblMinSalary.text = "Salary is less than".localizeString(string: language)
        lblMaxSalary.text = "Salary is more than".localizeString(string: language)
        lblNamePart_of_Name.text = "Name or Part of Name".localizeString(string: language)
        btnOK.titleLabel?.text = "OK".localizeString(string: language)
        
        self.setupLabelTap(viewforTap: viewForSalaryMax, tagVal: 1)
        self.setupLabelTap(viewforTap: viewForSalaryMin, tagVal: 2)
        self.setupLabelTap(viewforTap: viewForNameContains, tagVal: 3)

        txtMaxSalary.delegate = self
        txtMinSalary.delegate = self


    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    override func viewWillAppear(_ animated: Bool) {
           print("view will appear")
        print(passedFilterVal ?? 123)
        btnSalaryMin.sendActions(for: .touchUpInside)
        
        if passedFilterVal == 1 {
            
            btnSalaryMax.sendActions(for: .touchUpInside)
        }
        if passedFilterVal == 2 {
            
            btnSalaryMin.sendActions(for: .touchUpInside)
        }
        if passedFilterVal == 3 {
            
            btnNameEquals.sendActions(for: .touchUpInside)
        }
        if passedFilterVal == 4 {
            
            btnNameContains.sendActions(for: .touchUpInside)
        }

       }

       override func viewDidAppear(_ animated: Bool) {
           print("view did appear")
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
    @IBAction func onCancelButtonPressed(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
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
                print(txtMinSalary.text ?? "000")
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
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        print(sender.view?.tag ?? 000 )
        selectedFilterVal = sender.view?.tag
        
    }
        
    func setupLabelTap(viewforTap: UIView , tagVal:Int) {
            
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_: )))
            viewforTap.isUserInteractionEnabled = true
            viewforTap.addGestureRecognizer(labelTap)
        viewforTap.tag = tagVal

            
        }
    
}


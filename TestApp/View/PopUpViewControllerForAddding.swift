//
//  PopUpViewControllerForAddding.swift
//  TestApp
//
//  Created by Prasad Lokhande on 22/05/24.
//

import UIKit

protocol DataEnteredDelegate: AnyObject {
    func userDidEnterInformation(info: String)
    func sentEmpData(Name:String , Salary:String)
}

class PopUpViewControllerForAddding: UIViewController {
    weak var delegate: DataEnteredDelegate? = nil

    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtEmpName: UITextField!
    @IBOutlet weak var txtEmpSalary: UITextField!
    var IntvalForShowView = ""
    var language = Constants.getlan ?? "--"
    @IBOutlet weak var viewForEmployee: UIView!
    @IBOutlet weak var viewForCompany: UIView!
    
    @IBOutlet weak var addBtnEmp: UIButton!
    @IBOutlet weak var cancelBtnEmp: UIButton!
    @IBOutlet weak var addBtnCmp: UIButton!
    @IBOutlet weak var cancelBtnCmp: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ViewVal - \(IntvalForShowView)")
        if ((IntvalForShowView == "0")) {
            
            viewForEmployee.isHidden = true
            viewForCompany.isHidden = false
        }
        else
        { viewForCompany.isHidden = true
            viewForEmployee.isHidden = false
        }
        
        language = (UserDefaults.standard.object(forKey: "AppLanguage") as? String ?? "QQQQ")
        addBtnEmp.setTitle("ADD".localizeString(string: language), for: .normal)
        cancelBtnEmp.setTitle("CANCEL".localizeString(string: language), for: .normal)
        addBtnCmp.setTitle("ADD".localizeString(string: language), for: .normal)
        cancelBtnCmp.setTitle("CANCEL".localizeString(string: language), for: .normal)
        
        txtCompanyName.placeholder = "Company Name - ".localizeString(string: language)
        txtEmpName.placeholder = "Name".localizeString(string: language)
        txtEmpSalary.placeholder = "Salary".localizeString(string: language)

    }
    
    @IBAction func btnAddTapped(_ sender: Any) {
        if (txtCompanyName.text!.isEmpty) {
            
            let alert = UIAlertController(title: Constants.alert, message: Constants.companyNameCompulsory, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
        
        }else
        {
            
            delegate?.userDidEnterInformation(info: txtCompanyName.text!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func onCloseButtonPressed(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
    
    @IBAction func btnAddEmpTapped(_ sender: Any) {
        
        
        delegate?.sentEmpData(Name: txtEmpName.text ?? "NA", Salary: txtEmpSalary.text ?? "NAA")
       self.dismiss(animated: true, completion: nil)


    }
    @IBAction func onCloseEmpButtonPressed(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
}

extension DataEnteredDelegate {
    func userDidEnterInformation(info: String)
    {}
    func sentEmpData(Name:String , Salary:String)
    {}
}

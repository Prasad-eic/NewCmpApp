//
//  EmployeeViewController.swift
//  TestApp
//
//  Created by Prasad Lokhande on 23/05/24.
//

import UIKit

class EmployeeViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,DataEnteredDelegate, sendFilterDataDelegate ,UITextFieldDelegate{
   
    
   
    private var viewModel = EmployeeViewModel()
    private var NewviewModel = CompanyViewModel1()
    var language = Constants.getlan ?? "--"

    var company: Company?
    @IBOutlet weak var txtEmpName: UITextField!
    @IBOutlet weak var txtEmpSalary: UITextField!
    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCLearData: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    var filterVal:Int?


    
    func sentEmpData(Name: String, Salary: String) {
        print("Name - \(Name) Sal - \(Salary)")
    }
    func sentFilterData(Val: Int, SalaryORName: String) {
        print("Val - \(Val) Name - \(SalaryORName)")
        filterVal = Val
//        var salary = Int(SalaryORName)
//        viewModel.fetchAllEmployees(filterVal: Val, filterValMin: salary ?? 0, filterValMax: 0, filterValForName: "")
        viewModel.fetchAllEmployees(filterVal: Val, filterValForSort: SalaryORName)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        txtEmpSalary.delegate = self
        employeeTableView.sectionHeaderHeight = UITableView.automaticDimension
        employeeTableView.estimatedSectionHeaderHeight = 80
        navigationController?.navigationBar.backgroundColor = .green
        
        viewModel.didUpdateData = { [weak self] in
            self?.employeeTableView.reloadData()
        }
                
        language = (UserDefaults.standard.object(forKey: "AppLanguage") as? String ?? "QQQQ")
        lblTitle.text = "Find All Employees".localizeString(string:language )
        btnAdd.titleLabel?.text = "ADD".localizeString(string:language )
        btnCLearData.titleLabel?.text = "CLEAR DATA".localizeString(string:language )
        btnFilter.titleLabel?.text = "FILTERS".localizeString(string:language )
        txtEmpName.placeholder = "Name".localizeString(string: language)
        txtEmpSalary.placeholder = "Salary".localizeString(string: language)

        viewModel.fetchAllEmployees(filterVal: 0, filterValForSort: "")
//        textField(txtEmpSalary, shouldChangeCharactersIn: <#T##NSRange#>, replacementString: <#T##String#>)
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    @objc func addButtonTapped() {
        print("Tapped1")
        if let customPopup = storyboard?.instantiateViewController(withIdentifier: Constants.companyCell) as? PopUpViewControllerForAddding {
                   customPopup.modalPresentationStyle = .overCurrentContext
                   customPopup.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                   navigationController?.present(customPopup, animated: true)
            customPopup.delegate = self
               }
    }
    @IBAction func btnClearDataTapped(_ sender: Any) {
        viewModel.fetchAllEmployees(filterVal: 0, filterValForSort: "")
    }

    @IBAction func btnShowFilterTapped(_ sender: Any) {
            
        if let filterPopup = storyboard?.instantiateViewController(withIdentifier: Constants.filterPopUp) as? FilterViewController {
           filterPopup.modalPresentationStyle = .overCurrentContext
           filterPopup.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                       navigationController?.present(filterPopup, animated: true)
            filterPopup.passedFilterVal = filterVal
           filterPopup.delegate = self
                   }
        
    }
    @IBAction func btnAddEmpTapped(_ sender: Any) {
        
        if ((txtEmpName.text!.isEmpty) || (txtEmpSalary.text!.isEmpty)) {
            
            let alert = UIAlertController(title: Constants.alert, message: Constants.nameANDSalaryCompulsory, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
        
        }
        else{
            let salVal = Double(txtEmpSalary.text ?? "11" )!
            self.viewModel.addEmployee(name: txtEmpName.text ?? "11", salary:salVal, cmpName: "PSL Corp", Id: 111)
//            self.NewviewModel.addEmployee(to: company? ?? "NA", name: txtEmpName.text ?? "11", Salary: txtEmpSalary.text ?? "10")
            txtEmpName.text = ""
            txtEmpSalary.text = ""

        }
            
    }
}


extension EmployeeViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEmployees()
//        return 0;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          // Do here
        let cmp = viewModel.Employee(at: indexPath.row)
        print("Selected - \(String(describing: cmp.empName))")
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.employeeCell, for: indexPath) as! EmployeeTableViewCell
        let cmp = viewModel.Employee(at: indexPath.row)
        cell.titleLabel.text = cmp.empName
        let salary = String(cmp.empSalary)
        print(cmp.empCompanyName!)
        cell.salaryLabel.text = salary
        
        cell.lblNameText.text = "Name :-".localizeString(string:language )
        cell.lblSalaryText.text = "Salary :-".localizeString(string:language )
        cell.btnDelete.titleLabel?.text = "DELETE".localizeString(string: language)


        cell.btnDelete.addTarget(self, action: #selector(deleteEmployee(sender:)), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row

        return cell
    }
    @objc func deleteEmployee(sender: UIButton){
        let buttonTag = sender.tag
        print(buttonTag)
        let cmpToDelete = viewModel.Employee(at: sender.tag)
        viewModel.deleteEmployee(cmp: cmpToDelete)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cmpToDelete = viewModel.Employee(at: indexPath.row)
            viewModel.deleteEmployee(cmp: cmpToDelete)
        }
    }
}

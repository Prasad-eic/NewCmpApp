//
//  EmployeeViewController.swift
//  TestApp
//
//  Created by Prasad Lokhande on 23/05/24.
//

import UIKit

class EmployeeViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,DataEnteredDelegate {
   
    private var viewModel = EmployeeViewModel()

    
//    func userDidEnterInformation(info: String) {
//        print("Entred String - \(info)")
//        self.viewModel.addEmployee(name: info, salary: 1212, cmpName: "123", Id: 122)
//
//    }
    @IBOutlet weak var txtEmpName: UITextField!
    @IBOutlet weak var txtEmpSalary: UITextField!
    @IBOutlet weak var employeeTableView: UITableView!
    
    func sentEmpData(Name: String, Salary: String) {
        print("Name - \(Name) Sal - \(Salary)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
        employeeTableView.sectionHeaderHeight = UITableView.automaticDimension
        employeeTableView.estimatedSectionHeaderHeight = 80


        navigationController?.navigationBar.backgroundColor = .green
        
        viewModel.didUpdateData = { [weak self] in
            self?.employeeTableView.reloadData()
        }
        
        viewModel.fetchAllEmployees()
        
    }
    
    @objc func addButtonTapped() {
        print("Tapped1")
        if let customPopup = storyboard?.instantiateViewController(withIdentifier: "CustomPopupViewController") as? PopUpViewControllerForAddding {
                   customPopup.modalPresentationStyle = .overCurrentContext
                   customPopup.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                   navigationController?.present(customPopup, animated: true)
            customPopup.delegate = self
               }
    }
    @IBAction func btnAddEmpTapped(_ sender: Any) {
        
        if ((txtEmpName.text?.isEmpty) != nil) || ((txtEmpSalary.text?.isEmpty) != nil) {
            
            let alert = UIAlertController(title: "Alert", message: "Name & Salary is Compulsory", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
        
        }
        else{
            let salVal = Double(txtEmpSalary.text ?? "11" )!
            self.viewModel.addEmployee(name: txtEmpName.text ?? "11", salary:salVal, cmpName: "PSL Corp", Id: 111)
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
//    func numberOfSections(in tableView: UITableView) -> Int {
////        return arraySection.count
//    return viewModel.numberOfEmployees()
//
//    }
//     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let view = UIView(frame: CGRect(x:0, y:0, width:150, height:18))
//        let label = UILabel(frame: CGRect(x:10, y:5, width:tableView.frame.size.width-200, height:18))
//         let button = UIButton (frame: CGRect(x: tableView.frame.width-150, y: 5, width: 50, height: 20))
//         button.setTitle(" ADD ", for: .normal)
//         button.setTitleColor(.blue, for: .normal)
//         button.backgroundColor = UIColor.gray
//         button.layer.cornerRadius = 5
////         button.frame = CGRect(x: 15, y: -50, width: 300, height: 500)
//         button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//         button.tag = section
//         
//         button.backgroundColor = UIColor.green
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.text = "This is a test";
//        view.addSubview(label);
//        view.addSubview(button)
//        view.backgroundColor = UIColor.gray;
//        return view
//
//    }
//    @objc private func addButtonTapped(sender:UIButton) {
//        print("Section - \(sender.tag)")
//       }
//
//     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40.0
//    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        let cmp = viewModel.company(at: section)
////        print("Section Val - \(String(describing: cmp.companyName))")
//        return "Section \(cmp.companyName ?? "NA")"
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          // Do here
        let cmp = viewModel.Employee(at: indexPath.row)
        print("Selected - \(String(describing: cmp.empName))")
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeeTableViewCell
        let cmp = viewModel.Employee(at: indexPath.row)
        cell.titleLabel.text = cmp.empName
        let salary = String(cmp.empSalary)
        print(cmp.empCompanyName!)
        cell.salaryLabel.text = salary
        
//        let val = viewModel.GetMaxValuesEmployee(at: indexPath.row)
//        print("Name - \(String(describing: val.empName)) Salary \(val.empSalary)")
        return cell
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

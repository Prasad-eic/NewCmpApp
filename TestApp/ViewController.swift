//
//  ViewController.swift
//  TestApp
//
//  Created by Prasad Lokhande on 10/07/23.
//

import UIKit
import CoreData

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,DataEnteredDelegate {

    @IBOutlet weak var btnAddEmployee: UIButton!
    @IBOutlet weak var companyTableView: UITableView!
    var companyValuesArray = [String]()
    private var viewModel = CompanyViewModel()
    var company: CompanyEntity?
    var selectedCompanyName:String = ""
    var language = Constants.getlan ?? "--"

    @IBOutlet weak var lblTitle: UILabel!
    
    func userDidEnterInformation(info: String) {
        print("Entred String - \(info)")
        self.viewModel.addCompany(name: info, Id: 12)

    }
    func sentEmpData(Name: String, Salary: String) {
        print("Name - \(Name) & Salary - \(Salary)")
        let salVal = Double(Salary) ?? 0.0
        self.viewModel.addEmployee(name: Name, salary:salVal, cmpName: selectedCompanyName, Id: 111)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        companyTableView.dataSource = self
        companyTableView.delegate = self
        
        companyTableView.sectionHeaderHeight = UITableView.automaticDimension
        companyTableView.estimatedSectionHeaderHeight = 80

        let leftNaviButton = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(BtnMoreTapped))
           self.navigationItem.leftBarButtonItem = leftNaviButton
        
        let rightNaviButton = UIBarButtonItem(image: UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(BtnPlusTapped))
        self.navigationItem.rightBarButtonItem = rightNaviButton
        
        navigationController?.navigationBar.backgroundColor = .green
        
        viewModel.didUpdateData = { [weak self] in
            self?.companyTableView.reloadData()
        }
        
        viewModel.fetchCompany()
        print("Init Lang - \(language)")

        lblTitle.text = "Find All Companies".localizeString(string:language )
        btnAddEmployee.setTitle("Add_Employee".localizeString(string: language), for: .normal)

    }
    @objc func BtnMoreTapped() {
        
        let alert = UIAlertController(title: "", message: "Change Language To", preferredStyle: .actionSheet)
        
        let userDefaults =  UserDefaults.standard
            
            alert.addAction(UIAlertAction(title: "English", style: .default , handler:{ (UIAlertAction)in
                print("User click English")
                userDefaults.set("en", forKey: "AppLanguage")
                userDefaults.synchronize()

                self.changeLanguage()
            }))
            
            alert.addAction(UIAlertAction(title: "Spanish", style: .default , handler:{ (UIAlertAction)in
                print("User click Spanish")
                userDefaults.set("es", forKey: "AppLanguage")
                userDefaults.synchronize()
                self.changeLanguage()
            }))
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    }
    @objc func BtnPlusTapped() {
        print("Tapped1")
      showPopUpforAdd(val: 0)
    }
    
    func showPopUpforAdd(val: Int)
    {
         let customPopup = storyboard?.instantiateViewController(withIdentifier: "CustomPopupViewController") as? PopUpViewControllerForAddding
        customPopup?.IntvalForShowView = "\(val)"

        customPopup?.modalPresentationStyle = .overCurrentContext
        customPopup?.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)

        navigationController?.present(customPopup!, animated: true,completion: nil)
        customPopup?.delegate = self
               
    }
    @IBAction func btnAddCompanyTapped(_ sender: Any) {
            
    }
    func changeLanguage() {
        language = (UserDefaults.standard.object(forKey: "AppLanguage") as? String ?? "QQQQ")
        print("New Lang - \(Constants.getlan ?? "NNNN")")
        print("changeLanguage - \(language)")
        lblTitle.text = "Find All Companies".localizeString(string:language )
        btnAddEmployee.setTitle("Add_Employee".localizeString(string: language), for: .normal)
        companyTableView.reloadData()

    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfComapnies()
        return 0;
    }
    func numberOfSections(in tableView: UITableView) -> Int {
//        return arraySection.count
    return viewModel.numberOfComapnies()

    }
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView(frame: CGRect(x:0, y:0, width:150, height:18))
        let label = UILabel(frame: CGRect(x:10, y:5, width:tableView.frame.size.width-150, height:18))
         let button = UIButton (frame: CGRect(x: tableView.frame.width-150, y: 5, width: 120, height: 20))
         button.setTitle("ADD".localizeString(string:language ), for: .normal)
         button.setTitleColor(.blue, for: .normal)
         button.backgroundColor = UIColor.gray
         button.layer.cornerRadius = 5
         button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
         button.tag = section
         
         button.backgroundColor = UIColor.green
        label.font = UIFont.systemFont(ofSize: 14)
         let cmp = viewModel.company(at: section)
         print("Lang - \(language)")
         let cmpName = "Company Name -".localizeString(string: language)
         label.text = "\(cmpName)\(cmp.companyName ?? "")";
        view.addSubview(label);
        view.addSubview(button)
        view.backgroundColor = UIColor.gray;
         
        return view

    }
    @objc private func addButtonTapped(sender:UIButton) {
        company = viewModel.company(at: sender.tag)
        print("Section Val - \(company?.companyName ?? "--")")
        selectedCompanyName = company?.companyName ?? "--"
        showPopUpforAdd(val: 1)
       }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          // Do here
        let cmp = viewModel.company(at: indexPath.row)
        print("Selected - \(String(describing: cmp.companyName))")
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath)
        let cmp = viewModel.company(at: indexPath.row)
        cell.textLabel?.text = cmp.companyName
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cmpToDelete = viewModel.company(at: indexPath.row)
            viewModel.deleteCompany(cmp: cmpToDelete)
        }
    }
}



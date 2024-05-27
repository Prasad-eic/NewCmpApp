//
//  ViewController.swift
//  TestApp
//
//  Created by Prasad Lokhande on 10/07/23.
//

import UIKit
import CoreData

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,DataEnteredDelegate {

    func userDidEnterInformation(info: String) {
        print("Entred String - \(info)")
        self.viewModel.addCompany(name: info, Id: 12)

    }
    
    @IBOutlet weak var companyTableView: UITableView!
    
    
    private var viewModel = CompanyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        companyTableView.dataSource = self
        companyTableView.delegate = self
        
        companyTableView.sectionHeaderHeight = UITableView.automaticDimension
        companyTableView.estimatedSectionHeaderHeight = 80


//        let leftNaviButton = UIBarButtonItem(title: "Button", style: UIBarButtonItem.Style.plain, target: self, action: #selector(Tapped1))
        let leftNaviButton = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(BtnMoreTapped))
           self.navigationItem.leftBarButtonItem = leftNaviButton
        
        let rightNaviButton = UIBarButtonItem(image: UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(BtnPlusTapped1))
        self.navigationItem.rightBarButtonItem = rightNaviButton
        
        
        
        
        navigationController?.navigationBar.backgroundColor = .green
        
        viewModel.didUpdateData = { [weak self] in
            self?.companyTableView.reloadData()
        }
        
        viewModel.fetchCompany()
        
    }
    @objc func BtnMoreTapped() {
        
        let alert = UIAlertController(title: "", message: "Change Language To", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "English", style: .default , handler:{ (UIAlertAction)in
                print("User click English")
            }))
            
            alert.addAction(UIAlertAction(title: "Spanish", style: .default , handler:{ (UIAlertAction)in
                print("User click Spanish")
            }))

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    }
    @objc func BtnPlusTapped1() {
        print("Tapped1")
        if let customPopup = storyboard?.instantiateViewController(withIdentifier: "CustomPopupViewController") as? PopUpViewControllerForAddding {
                   customPopup.modalPresentationStyle = .overCurrentContext
                   customPopup.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                   navigationController?.present(customPopup, animated: true)
            customPopup.delegate = self
               }
    }
    @IBAction func btnAddCompanyTapped(_ sender: Any) {
        
//                let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
//        
//                alert.addTextField { (textField) in
//                    textField.text = "Some default text"
//                }
//        
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//                    let textField = alert?.textFields![0]
//                    print("Text field: \(String(describing: textField!.text))")
//                    var nameVal  = textField?.text
//                    self.viewModel.addCompany(name: nameVal ?? "NA", Id: 1)
//        
//                }))
//                self.present(alert, animated: true, completion: nil)
            
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfComapnies()
//        return 0;
    }
    func numberOfSections(in tableView: UITableView) -> Int {
//        return arraySection.count
    return viewModel.numberOfComapnies()

    }
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView(frame: CGRect(x:0, y:0, width:150, height:18))
        let label = UILabel(frame: CGRect(x:10, y:5, width:tableView.frame.size.width-200, height:18))
         let button = UIButton (frame: CGRect(x: tableView.frame.width-150, y: 5, width: 50, height: 20))
         button.setTitle(" ADD ", for: .normal)
         button.setTitleColor(.blue, for: .normal)
         button.backgroundColor = UIColor.gray
         button.layer.cornerRadius = 5
         button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
         button.tag = section
         
         button.backgroundColor = UIColor.green
        label.font = UIFont.systemFont(ofSize: 14)
         let cmp = viewModel.company(at: section)
         label.text = "Company Name - \(cmp.companyName ?? "")";
        view.addSubview(label);
        view.addSubview(button)
        view.backgroundColor = UIColor.gray;
         
        return view

    }
    @objc private func addButtonTapped(sender:UIButton) {
        print("Section - \(sender.tag)")
       }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        let cmp = viewModel.company(at: section)
////        print("Section Val - \(String(describing: cmp.companyName))")
//        return "Section \(cmp.companyName ?? "NA")"
//    }
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


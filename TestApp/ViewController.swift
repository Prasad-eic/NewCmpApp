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
        self.viewModel.addCompany(name: info, Id: 2)

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
        let leftNaviButton = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(Tapped1))

           self.navigationItem.leftBarButtonItem = leftNaviButton
        
        navigationController?.navigationBar.backgroundColor = .green
        
        viewModel.didUpdateData = { [weak self] in
            self?.companyTableView.reloadData()
        }
        
        viewModel.fetchCompany()
        
        var val = viewModel.favDataNos()
        print(val)
        
        for i in 0...val{
            let cmp = viewModel.company(at: i)
            print("Val - \(cmp.companyName ?? "")")

        }
    }
    
    @objc func Tapped1() {
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


class CustomSectionHeaderView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfComapnies()
//        return 0;
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
////        return arraySection.count
//    return viewModel.numberOfComapnies()
//
//    }

//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let headerView = CustomSectionHeaderView()
//                headerView.titleLabel.text = "Section \(section)"
//                headerView.button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//                return headerView
//    }
    @objc private func addButtonTapped() {
           printContent("Section Btn Tapped")
       }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
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


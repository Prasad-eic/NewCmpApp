//
//  CompanyViewController.swift
//  TestApp
//
//  Created by Prasad Lokhande on 29/05/24.
//

import UIKit

class CompanyViewController: UIViewController {
    
    
    

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = CompanyViewModel1()
    private var companies: [Company] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

//        bindViewModel()
        viewModel.fetchCompanies()
        let leftNaviButton = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(BtnMoreTapped))
           self.navigationItem.leftBarButtonItem = leftNaviButton
    }

//    private func bindViewModel() {
//        viewModel.companiesChanged = { [weak self] companies in
//            self?.companies = companies
//            self?.tableView.reloadData()
//        }
//    }
   
    @IBAction func BtnMoreTapped() {
        let alert = UIAlertController(title: "Add Company", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Company Name" }

        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let name = alert.textFields?[0].text, !name.isEmpty else { return }
            self?.viewModel.addCompany(name: name)
        }
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }
}

extension CompanyViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath)
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.companyName
        if let employees = company.employees.allObjects as? [Employee] {
            cell.detailTextLabel?.text = "Employees: \(employees.count)"
        } else {
            cell.detailTextLabel?.text = "Employees: 0"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let companyToDelete = companies[indexPath.row]
            viewModel.deleteCompany(company: companyToDelete)
        }
    }
}


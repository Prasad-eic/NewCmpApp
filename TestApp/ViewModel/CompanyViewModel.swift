//
//  companyViewModel.swift
//  TestApp
//
//  Created by Prasad Lokhande on 29/05/24.
//

import Foundation
import CoreData
import UIKit

class CompanyViewModel1 {
    private var companies: [CompanyEntity] = [] {
        didSet {
//            companiesChanged?(companies)
        }
    }
    
    var companiesChanged: (([Company]) -> Void)?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchCompanies() {
        let request: NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()
        do {
            companies = try context.fetch(request)
        } catch {
            print("Failed to fetch companies: \(error)")
        }
    }

    func addCompany(name: String) {
        let newCompany = CompanyEntity(context: context)
        newCompany.companyName = name
        saveContext()
        fetchCompanies()
    }

    func addEmployee(to company: Company, name: String, Salary: String) {
        let newEmployee = Employee(context: context)
        newEmployee.empName = name
        newEmployee.empSalary = Salary
        newEmployee.company = company
        saveContext()
        fetchCompanies()
    }
    
    func deleteCompany(company: Company) {
        context.delete(company)
        saveContext()
        fetchCompanies()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

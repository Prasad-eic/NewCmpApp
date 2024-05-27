//
//  companyVM.swift
//  TestApp
//
//  Created by Prasad Lokhande on 22/05/24.
//

import Foundation
import CoreData
import UIKit

class CompanyViewModel {

    private var company: [CompanyEntity] = []
    private var fav: [CompanyEntity] = []

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var didUpdateData: (() -> Void)?

    func fetchCompany() {
        
        let query:NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()
               let key = "2"

               let predicate = NSPredicate(format: "companyName contains[c] %@", key)
               query.predicate = predicate

               do{
                   fav = try context.fetch(query)
                   print(fav.count)

               }catch{
                   print("error")
               }
        
        
        let request: NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()
        do {
            company = try context.fetch(request)
            didUpdateData?()
        } catch {
            print("Failed to fetch company: \(error)")
        }
    }
    
    
    func addCompany(name: String, Id: Int16) {
        let newPerson = CompanyEntity(context: context)
        newPerson.companyName = name
        newPerson.id = Id
        saveContext()
        fetchCompany()
    }

    func deleteCompany(cmp: CompanyEntity) {
        context.delete(cmp)
        saveContext()
        fetchCompany()
    }

    func numberOfComapnies() -> Int {
        return company.count
    }
    func favData(at index: Int) -> CompanyEntity {
        return fav[index]
    }
    func favDataNos() -> Int {
        return fav.count
    }
    func company(at index: Int) -> CompanyEntity {
        return company[index]
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

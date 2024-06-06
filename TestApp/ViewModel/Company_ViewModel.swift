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
    private var employee: [EmpEntity] = []
    private var maxPrdicate: [EmpEntity] = []
    private var getEmpByName: [EmpEntity] = []

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
    
    func employees(cmp: Company) -> [EmpEntity] {
        let request: NSFetchRequest<EmpEntity> = Employee.fetchRequest()
        request.predicate = NSPredicate(format: "company = %@", cmp)
//        request.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        var fetchedSongs: [EmpEntity] = []
        
        do {
            fetchedSongs = try context.fetch(request)
        } catch let error {
            print("Error fetching songs \(error)")
        }
        return fetchedSongs
    }
    
    func addEmp(name: String, salary: String, cmp: Company) -> Employee {
        let emp = Employee(context: context)
//        song.title = title
//        song.releaseDate = releaseDate
//        singer.addToSongs(song)
        emp.empName = name
        emp.empSalary = salary
        cmp.addValuesToEmployee(emp)
        return emp
    }
    
    func addEmployee(name: String,salary: Double,cmpName: String, Id: Int16) {
    let newEmpployee = EmpEntity(context: context)
    newEmpployee.empName = name
    newEmpployee.empSalary = salary
    newEmpployee.empCompanyName = cmpName
    newEmpployee.id = Id
    saveContext()
    fetchAllEmployees()
}
    func fetchAllEmployees() {
        let request: NSFetchRequest<EmpEntity> = EmpEntity.fetchRequest()
        do {
            employee = try context.fetch(request)
            didUpdateData?()
        } catch {
            print("Failed to fetch emp: \(error)")
        }
        
        let query:NSFetchRequest<EmpEntity> = EmpEntity.fetchRequest()
               let key = "12000"

               let predicate = NSPredicate(format: "empSalary > %@", key)
               query.predicate = predicate

               do{
                   maxPrdicate = try context.fetch(query)
                   print("Max Count - \(maxPrdicate.count)")

               }catch{
                   print("error")
               }
        getValueByName()
    }
    
    func getValueByName()
    {
        let query:NSFetchRequest<EmpEntity> = EmpEntity.fetchRequest()
               let key = "PSL Corp"

               let predicate = NSPredicate(format: "empCompanyName = '%@'", key)
               query.predicate = predicate

               do{
                   getEmpByName = try context.fetch(query)
                   print("Comp - \(getEmpByName.count)")

               }catch{
                   print("error")
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

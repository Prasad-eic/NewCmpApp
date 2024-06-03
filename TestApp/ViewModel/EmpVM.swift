//
//  EmpVM.swift
//  TestApp
//
//  Created by Prasad Lokhande on 22/05/24.
//

import Foundation
import CoreData
import UIKit

class EmployeeViewModel {

    private var employee: [EmpEntity] = []
    private var maxPrdicate: [EmpEntity] = []
    private var getEmpByName: [EmpEntity] = []


    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var didUpdateData: (() -> Void)?
    
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
//    func song(title: String, releaseDate: String, singer: Company) -> Employee {
//        let song = Song(context: persistentContainer.viewContext)
//        song.title = title
//        song.releaseDate = releaseDate
//        singer.addToSongs(song)
//        return song
//    }
//    func fetchAllEmployees(filterVal:Int,filterValMin:Int,filterValMax:Int , filterValForName:String) {
    func fetchAllEmployees(filterVal:Int,filterValForSort:String) {

        let request: NSFetchRequest<EmpEntity> = EmpEntity.fetchRequest()
        
        if filterVal == 0 {
            do {
                employee = try context.fetch(request)
                didUpdateData?()
            } catch {
                print("Failed to fetch emp: \(error)")
            }
        }
        if filterVal == 1 {
            let key = filterValForSort
            let predicate = NSPredicate(format: "empSalary > %@", key)
            request.predicate = predicate
            do {
                employee = try context.fetch(request)
                didUpdateData?()
            } catch {
                print("Failed to fetch emp: \(error)")
            }
        }
        if filterVal == 2 {
            let key = filterValForSort
            let predicate = NSPredicate(format: "empSalary < %@", key)
            request.predicate = predicate
            do {
                employee = try context.fetch(request)
                didUpdateData?()
            } catch {
                print("Failed to fetch emp: \(error)")
            }
        }
        if filterVal == 3 {
            let key = filterValForSort
            let predicate = NSPredicate(format: "empName = %@", key)
            request.predicate = predicate
            do {
                employee = try context.fetch(request)
                didUpdateData?()
            } catch {
                print("Failed to fetch emp: \(error)")
            }
        }
        if filterVal == 4 {

            let key = filterValForSort
            let predicate = NSPredicate(format: "empName CONTAINS %@", key)
            request.predicate = predicate
            do {
                employee = try context.fetch(request)
                didUpdateData?()
            } catch {
                print("Failed to fetch emp: \(error)")
            }
        }
        getValueByName()
//        fetchValueGroupBy()
    }
    func fetchValueGroupBy()
    {
        
    }
        func addEmployee(name: String,salary: Double,cmpName: String, Id: Int16) {
        let newEmpployee = EmpEntity(context: context)
        newEmpployee.empName = name
        newEmpployee.empSalary = salary
        newEmpployee.empCompanyName = cmpName
        newEmpployee.id = Id
        saveContext()
            fetchAllEmployees(filterVal: 0, filterValForSort: "")
    }

    func deleteEmployee(cmp: EmpEntity) {
        context.delete(cmp)
        saveContext()
        fetchAllEmployees(filterVal: 0, filterValForSort: "")
    }

    func numberOfEmployees() -> Int {
        return employee.count
    }

    func Employee(at index: Int) -> EmpEntity {
        return employee[index]
    }
    
    
    func GetMaxValuesEmployee(at index: Int) -> EmpEntity {
        return maxPrdicate[index]
    }
    func MaxPredicatenumberOfEmployees() -> Int {
        return maxPrdicate.count
    }
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

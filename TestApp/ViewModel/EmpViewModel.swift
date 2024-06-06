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
    func fetchValueGroupBy() -> NSMutableArray
    {
        
        let fetchRequest11 = NSFetchRequest<NSFetchRequestResult>(entityName: "EmpEntity")
        
        let empArray: NSMutableArray = []
        let dictionary: NSMutableDictionary = [:]
        var fetchedDataArray: [Dictionary<String, String>] = []

        do {
             let results   = try context.fetch(fetchRequest11)
             let locations = results as! [EmpEntity]
                
             for location in locations {
//                 print(location.empCompanyName ?? "__")
//                 print(location.empName ?? "__")

//                 emptyArray.append(["trackMake":location.empName])
//                 dictionary["COmpanyName"]?.append(location.empCompanyName ?? "")
//                 dictionary["Name"]?.append(location.empName ?? "")
                 let strSalary = String(location.empSalary)

                 dictionary["CompanyName"] = String(location.empCompanyName ?? "")
                 dictionary["Name"] = location.empName
                 dictionary["Salary"] = strSalary
//                 print("Dict Val - \(dictionary)")
//                 emptyArray.add(dictionary)
//                 emptyArray.append
//                 print("ArrayInLoop - \(emptyArray)")
//                 myArray.append(["COmpanyName":location.empCompanyName ?? "-","Name":location.empName ?? "-","Salary":location.empSalary])
                 fetchedDataArray.append(dictionary as! Dictionary<String, String>)
//                 print("ArrayInLoop - \(fetchedDataArray)")

//                 emptyArray.add("This String")

             }
            let groupedByCountryName = Dictionary(grouping: fetchedDataArray) { $0["CompanyName"] }
//            print(groupedByCountryName.count)
            
            for itm in 0...groupedByCountryName.count-1 {
                print("grpuped - \(Array(groupedByCountryName)[itm].value[0])")
            }
            
//           print("First Value - \(Array(groupedByCountryName)[0].value)")
            empArray.add(groupedByCountryName)
//            print("Array Value - \(empArray[0])")

            

//            print("All Dict - \(dictionary)")
//            print("Array - \(myArray[2])")
        } catch let error as NSError {
          print("Could not fetch \(error)")
        }
        
        
        let fetchRequest = NSFetchRequest<EmpEntity>(entityName: "EmpEntity")
           do {
               let result = try context.fetch(fetchRequest)
               let nameArray = result.map{$0.empCompanyName}
               print(nameArray)
           } catch {
              print("Could not fetch \(error) ")
           }
        return empArray
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

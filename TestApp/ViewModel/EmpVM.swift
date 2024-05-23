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
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var didUpdateData: (() -> Void)?

    func fetchAllEmployees() {
        let request: NSFetchRequest<EmpEntity> = EmpEntity.fetchRequest()
        do {
            employee = try context.fetch(request)
            didUpdateData?()
        } catch {
            print("Failed to fetch emp: \(error)")
        }
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

    func deleteEmployee(cmp: EmpEntity) {
        context.delete(cmp)
        saveContext()
        fetchAllEmployees()
    }

    func numberOfEmployees() -> Int {
        return employee.count
    }

    func Employee(at index: Int) -> EmpEntity {
        return employee[index]
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

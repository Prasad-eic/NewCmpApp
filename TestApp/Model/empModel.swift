//
//  empModel.swift
//  TestApp
//
//  Created by Prasad Lokhande on 22/05/24.
//

import Foundation
import CoreData

//@objc(Employee)
public class Employee: NSManagedObject {

}

extension Employee {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmpEntity> {
        return NSFetchRequest<EmpEntity>(entityName: "EmpEntity")
    }

    @NSManaged public var empName: String?
    @NSManaged public var id: Int16
    @NSManaged public var empSalary: String?
    @NSManaged public var empCompanyName: String?
    @NSManaged public var company: Company?
}

extension Employee : Identifiable {

}

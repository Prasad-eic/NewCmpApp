//
//  companyModel.swift
//  TestApp
//
//  Created by Prasad Lokhande on 22/05/24.
//

import Foundation
import CoreData

//@objc(Company)
public class Company: NSManagedObject {

}

extension Company {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompanyEntity> {
        return NSFetchRequest<CompanyEntity>(entityName: "CompanyEntity")
    }

    @NSManaged public var companyName: String?
    @NSManaged public var id: Int16
    @NSManaged public var employees:NSSet
}
// MARK: Generated accessors for employees
//extension CompanyEntity {
//
//    @objc(addEmployeesObject:)
//    @NSManaged public func addToEmployees(_ value: EmpEntity)
//
//    @objc(removeEmployeesObject:)
//    @NSManaged public func removeFromEmployees(_ value: EmpEntity)
//
//    @objc(addEmployees:)
//    @NSManaged public func addToEmployees(_ values: NSSet)
//
//    @objc(removeEmployees:)
//    @NSManaged public func removeFromEmployees(_ values: NSSet)
//
//}
extension Company : Identifiable {

}

//
//  Constant.swift
//  TestApp
//
//  Created by Prasad Lokhande on 30/05/24.
//

import Foundation
import UIKit
struct Constants{
    
    static let employeeCell = "employeeCell"
    static let companyCell = "CustomPopupViewController"
    static let filterPopUp = "FilterPopupViewController"
    static let companyNameCompulsory = "Company Name is Compulsory"
    static let alert = "Alert"
    static let ok = "OK"
    static let nameANDSalaryCompulsory = "Name & Salary is Compulsory"
    
    static let nameEqualsTo = "Name Equals to -"
    static let nameContains = "Name Contains to -"
    static let salaryIsMore =  "Salary is More than -"
    static let salaryIsLess = "Salary is less than -"
    static let salary_Name_Req = "Max Salary Or Min Salary Or Name Required"
    
    static var getlan = UserDefaults.standard.object(forKey: "AppLanguage") as? String
    
   
    
}
extension String {
    func localizeString(string: String)-> String {
        guard let path = Bundle.main.path(forResource: string, ofType: "lproj") else { return "" }
        let bundle = Bundle(path: path)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

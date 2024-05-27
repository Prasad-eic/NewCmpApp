//
//  PopUpViewControllerForAddding.swift
//  TestApp
//
//  Created by Prasad Lokhande on 22/05/24.
//

import UIKit

protocol DataEnteredDelegate: AnyObject {
    func userDidEnterInformation(info: String)
    func sentEmpData(Name:String , Salary:String)
}
class PopUpViewControllerForAddding: UIViewController {
    weak var delegate: DataEnteredDelegate? = nil

    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtEmpName: UITextField!
    @IBOutlet weak var txtEmpSalary: UITextField!

    @IBOutlet weak var viewForEmployee: UIView!
    @IBOutlet weak var viewForCompany: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAddTapped(_ sender: Any) {
        
        // call this method on whichever class implements our delegate protocol
        delegate?.userDidEnterInformation(info: txtCompanyName.text!)
       self.dismiss(animated: true, completion: nil)

//        print("Tapped - \(txtCompanyName.text!)")

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onCloseButtonPressed(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
    
    @IBAction func btnAddEmpTapped(_ sender: Any) {
//                delegate?.userDidEnterInformation(info: txtCompanyName.text!)
        delegate?.sentEmpData(Name: txtEmpName.text ?? "NA", Salary: txtEmpSalary.text ?? "NAA")
       self.dismiss(animated: true, completion: nil)


    }
    @IBAction func onCloseEmpButtonPressed(_ sender: UIButton) {
           self.dismiss(animated: true, completion: nil)
       }
}

extension DataEnteredDelegate {
    func userDidEnterInformation(info: String)
    {}
    func sentEmpData(Name:String , Salary:String)
    {}
}

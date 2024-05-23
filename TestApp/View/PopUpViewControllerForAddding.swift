//
//  PopUpViewControllerForAddding.swift
//  TestApp
//
//  Created by Prasad Lokhande on 22/05/24.
//

import UIKit

protocol DataEnteredDelegate: AnyObject {
    func userDidEnterInformation(info: String)
}
class PopUpViewControllerForAddding: UIViewController {
    weak var delegate: DataEnteredDelegate? = nil

    @IBOutlet weak var txtCompanyName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAddTapped(_ sender: Any) {
        
        // call this method on whichever class implements our delegate protocol
        delegate?.userDidEnterInformation(info: txtCompanyName.text!)
               
               // go back to the previous view controller
        //         self.navigationController?.popViewController(animated: true)
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
}

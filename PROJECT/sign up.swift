//
//  sign up.swift
//  PROJECT
//
//  Created by MacBook on 11/07/24.
//

import UIKit
import CoreData
class sign_up: UIViewController
{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var characterCount: Int = 0
    
    @IBOutlet weak var eye: UIButton!
    @IBAction func eybtn(_ sender: Any)
    {
        self.password.isSecureTextEntry = !self.password.isSecureTextEntry
        if password.isSecureTextEntry {
                 eye.setImage(UIImage(named: "eyepass") , for: .normal)
            
        }
        else
        {
                eye.setImage(UIImage(named: "eye-password-see-view") , for: .normal)
             }
    }
    
    
    @IBAction func lgn(_ sender: Any)
    {
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")as! login
        self.navigationController?.pushViewController(next, animated: true)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let AttributedString = NSMutableAttributedString(string: "User Name",attributes: [.foregroundColor: UIColor.darkGray])
                                                                 
  let asterisk = NSAttributedString(string: " *", attributes: [.foregroundColor: UIColor.red])
        AttributedString.append(asterisk)
                self.username.attributedPlaceholder = AttributedString
         let AttributedString2 = NSMutableAttributedString(string: "Password",attributes: [.foregroundColor: UIColor.darkGray])
                                                                         
          let asterisk2 = NSAttributedString(string: " *", attributes: [.foregroundColor: UIColor.red])
                AttributedString2.append(asterisk2)
                        self.password.attributedPlaceholder = AttributedString2
    }
    func counting()
        {
               characterCount = password.text?.count ?? 0
        }

    

    @IBAction func btn(_ sender: Any)
     {
        counting()
        if username.text == "" || password.text == ""
        {
            alertbox(message:
                "FILL ALL FIELDS")
            
        }
        if isValidPassword(password.text!) {
                
            if isValidCredentials(username: username.text!, password: password.text!) {
                      
                
                let user = NSEntityDescription.insertNewObject(forEntityName:"Userdetails", into: context)
                       user.setValue(self.username.text, forKey: "username")
                       user.setValue(self.password.text, forKey: "password")
                       do
                       {
                           try context.save()
                         
                           let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")as! login
                           self.navigationController?.pushViewController(next, animated: true)
               print("qqqqq")
                       }
                       catch
                       {
                           print("error")
                       }
                alertbox(message: "Sign In successful!")
                
                    }
            else
            {
                        alertbox(message: "username minimum 3 character")
                    }
                }
        else
        {
                    alertbox(message: "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.")
                }
            }
            
            func isValidCredentials(username: String, password: String) -> Bool {
            
                return username.count > 2 && password.count > 3
            }
            
            func isValidPassword(_ password: String) -> Bool {
                let minLength = 8
                let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{\(minLength),}$"
                
                let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
                return passwordPredicate.evaluate(with: password)
            }

    func alertbox(message:String)
    {
        let alertactn = UIAlertController(title: "ALERT", message: message, preferredStyle: .alert)
        alertactn.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        self.present(alertactn,animated: true,completion: nil)
    }
}

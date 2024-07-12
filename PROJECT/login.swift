
import UIKit
import CoreData
class login: UIViewController
{

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var uname: UITextField!
    @IBOutlet weak var upass: UITextField!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var eyes: UIButton!
    
    
    @IBAction func register(_ sender: Any)
    {
        let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sign")as! sign_up
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func eyebtn(_ sender: Any) {
        self.upass.isSecureTextEntry = !self.upass.isSecureTextEntry
        if upass.isSecureTextEntry {
                 eyes.setImage(UIImage(named: "eyepass") , for: .normal)
             } else {
                eyes.setImage(UIImage(named: "eye-password-see-view") , for: .normal)
             }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uname.text = UserDefaults.standard.string(forKey: "uname")
        
        let AttributedString = NSMutableAttributedString(string: "User Name",attributes: [.foregroundColor: UIColor.darkGray])
                                                                 
  let asterisk = NSAttributedString(string: " *", attributes: [.foregroundColor: UIColor.red])
        AttributedString.append(asterisk)
                self.uname.attributedPlaceholder = AttributedString
         let AttributedString2 = NSMutableAttributedString(string: "Password",attributes: [.foregroundColor: UIColor.darkGray])
                                                                         
          let asterisk2 = NSAttributedString(string: " *", attributes: [.foregroundColor: UIColor.red])
                AttributedString2.append(asterisk2)
                        self.upass.attributedPlaceholder = AttributedString2
    }
    
    @IBAction func btn1(_ sender: Any) {
        
        if uname.text == "" || upass.text == ""
        {
            alertbox(message:
                "FILL ALL THE FIELDS")
            
        }
        if isValidPassword(upass.text!)
        {
            
            if isValidCredentials(username: uname.text!, password: upass.text!)
            {
                                        
        let fetchreq = NSFetchRequest <NSFetchRequestResult>(entityName: "Userdetails")
        let fword = self.uname.text
        fetchreq.predicate=NSPredicate(format: "username == %@", fword!)
        do
        {
            let result = try context.fetch(fetchreq)
           // print("wrongggggg")

            if( result.count > 0)
            {
               for i in result
               {
                let keyname = (i as AnyObject).value(forKey: "username")as! String
                let keypwd = (i as AnyObject).value(forKey: "password")as! String
                
                if keyname == self.uname.text && keypwd == self.upass.text
                {
                    UserDefaults.standard.setValue(self.uname.text, forKey: "uname")
                   

                    let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "home")
                    self.navigationController?.pushViewController(next, animated: true)
                 //   alertbox(message: "Login successful!")
                }
               }
            }else{
                print("kkkk")
            }
            
        }
        catch
        {
            print("error")
        }
    }
    else
    {
        alertbox(message: "invalid login")
    }
        }
        else
        {
            alertbox(message: "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character..")
        }
    }

    func isValidPassword(_ password: String) -> Bool
    {
        let minLength = 8
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{\(minLength),}$"
        
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func isValidCredentials(username: String, password: String) -> Bool
    {
        return username.count > 2 && password.count > 3
    }
    func alertbox(message:String)
    {
        let alertactn = UIAlertController(title: "ALERT", message: message, preferredStyle: .alert)
        alertactn.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        self.present(alertactn,animated: true,completion: nil)
    }
}


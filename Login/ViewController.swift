//
//  ViewController.swift
//  IOSOMS
//
//  Created by Yugesh Marahatta on 19/08/2022.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate, UITextFieldDelegate  {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinbtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var rememberme: UIButton!
    
    var iconClick = false
    let imageicon = UIImageView()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            //hides the spinner when stopped
            spinner.hidesWhenStopped = true
            super.viewDidLoad()
            //design
            signinbtn.layer.cornerRadius = 25
          // textfield desugn
            emailField.layer.cornerRadius = 10
            emailField.layer.borderWidth = 1
            emailField.layer.borderColor = UIColor.black.cgColor
            
          
            //passwordfield
            passwordField.layer.cornerRadius = 10
            passwordField.layer.borderWidth = 1
            passwordField.layer.borderColor = UIColor.black.cgColor
            

            emailField.delegate = self
            passwordField.delegate = self
            // Do any additional setup after loading the view.
            let emailImage = UIImage(named: "email")
            addEmailLeftImageTo(txtField: emailField, andImage: emailImage!)

            let passwordImage = UIImage(named: "password")
            addPasswordLeftImageTo(txtField: passwordField, andImage: passwordImage!)

            
    }
    //images to email and pp
    func addEmailLeftImageTo(txtField: UITextField, andImage img : UIImage ){
        let leftImageView = UIImageView(frame: CGRect(x: 20, y: 0.0, width: 50, height: 50))
        leftImageView.image = img
        emailField.leftView = leftImageView
        emailField.leftViewMode = .always
    }
    func addPasswordLeftImageTo(txtField: UITextField, andImage img : UIImage ){
        let leftImageView = UIImageView(frame: CGRect(x: 20, y: 0.0, width: 50, height: 50))
        leftImageView.image = img
        passwordField.leftView = leftImageView
        passwordField.leftViewMode = .always
    }
    //remember me button
    @IBAction func rememberMee(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        }
        else {
            sender.isSelected = true
        }
    }
//end of remember me
    //signin button
    @IBAction func signinBtn(_ sender: Any) {
     
            
        print("\(String(describing: emailField.text)) and \(String(describing: passwordField.text))")
        if emailField.text == "" {
            self.showToast(message: "Email can't be null", font: .systemFont(ofSize: 15.0))
            invalidCreditionals(message:"Please Enter Email")
            
        }
        else if(passwordField.text == "") {
            self.showToast(message: "Password can't be null", font: .systemFont(ofSize: 15.0))
            invalidCreditionals(message:"Please Enter Password")
        } else{
        apiCall()
        
        }
        
    }
    //touch outside
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
        return true
    }
    //invalid creditionals function
    func invalidCreditionals(message : String){
           let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: {
               return
           })
       }
    
    //toast function
    func showToast(message : String, font: UIFont) {

            let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.font = font
            toastLabel.textAlignment = .center;
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                 toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    
    //login funciton with its structure
    //api post
    func apiCall(){
        spinner.startAnimating()
        guard let url = URL(string: "http://localhost:8000/api/login")
        else {
                return
            }
    var request = URLRequest(url: url)
        //method,body,headers
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String: AnyHashable] = [
//            "username": emailField.text!,
//            "password": passwordField.text!
            
            //for test
            
            "username": "test@wolfmatrix.com",
            "password": "Wolfmatrix@123"
            
//            "username": "nirajan.panthee@wolfmatrix.com",
//            "password": "Wolfmatrix@123"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        //make a request
        let task = URLSession.shared.dataTask(with: request) { []data, response, error in
           
            guard let data = data, error == nil
            
            else{
                return
        }
 
   
            if let httpResponse = response as? HTTPURLResponse {
                let Code = (httpResponse.statusCode)
                print("Code is \(Code)")
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                }
                
            }
                if let httpResponse = response as? HTTPURLResponse{
                    let sCode = (httpResponse.statusCode)
                    print("Code is \(sCode)")
                                        if sCode == 200 {
                                            
                                            // do such task
                                            do {
                                                let responsee = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                                let status = try JSONDecoder().decode(Response.self, from:data)
                                                let tokenVal = status.token
                                                GlobalVariable.tokenValue = tokenVal
                                                print(status)
                                                print(responsee)
                                                //saving token to keychain if remember
                                                if self.rememberme.isSelected{
                                                    print("Remembered Enab;ed")
//                                                    let saveToken: Bool = KeychainWrapper.standard.set(tokenVal, forKey: "tokenVal")
//                                                    print("Key chain stored value :\(saveToken)")
                                                }
                                                else {
                                                    print("No remembered")
                                                }
                                                
                                                
                                                //end of saving on keychain
                                                //go to dashboard
                                                DispatchQueue.main.asyncAfter(deadline: .now()){
                                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                    let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                                                    mainVC.modalPresentationStyle = .fullScreen
                                                    self.present(mainVC, animated: false)
                                                   

                                                }
                                       }
                                        
                                        catch {
                                            print(error)
                                        }
                                        }
                                       else if sCode == 401 {
                                           //self.spinner.stopAnimating()
                                           print("Invalid Creditionals")
                                           DispatchQueue.main.async {
                                           self.invalidCreditionals(message:"Invalid Creditonals")
                                           }
                                           //self.invalidMessage.isHidden = false
                                           //self.showToast(message: "Your Toast Message", font: .systemFont(ofSize: 12.0))

                                       }
                                       else {
                                           print("Connection error")
                                           DispatchQueue.main.async {
                                           self.invalidCreditionals(message:"Please check your Internet Connection")
                                           }                                       }
                    
                                   }

        }
        task.resume()

        
}
    struct Response : Codable {
        let token : String
    }
    
    struct GlobalVariable {
        static var tokenValue = String()
    }
    

}


//
//  SigninViewController.swift
//  InstaSample
//
//  Created by 加藤拓洋 on 2020/05/24.
//  Copyright © 2020 TakumiKato. All rights reserved.
//

import UIKit
import NCMB

class SigninViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet var  userIDTextField: UITextField!
    @IBOutlet var  passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        userIDTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signIn(){
        
        if (userIDTextField.text?.count)! > 0 && (passwordTextField.text?.count)! > 0{
        NCMBUser.logInWithUsername(inBackground: userIDTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil{
                print(error)
            }else{
                //ログイン成功
                let storyboaed = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootViewController = storyboaed.instantiateViewController(withIdentifier: "RootTabBarController")
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
                
                //ログイン状態の保持
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isLogin")
                ud.synchronize()
                }
            }
        }
    }

}

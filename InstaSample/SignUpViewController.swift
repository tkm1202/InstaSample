//
//  SignUpViewController.swift
//  InstaSample
//
//  Created by 加藤拓洋 on 2020/05/24.
//  Copyright © 2020 TakumiKato. All rights reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet var userIDTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userIDTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signup(){
        let user = NCMBUser()
        
        if (userIDTextField.text?.count)! < 4{
            print("文字数が足りません")
            return
        }

        user.userName = userIDTextField.text!
        user.mailAddress = emailTextField.text!
        user.password = passwordTextField.text!
        if passwordTextField.text == confirmTextField.text{
            user.password = passwordTextField.text!
        }else{
            print("パスワードの不一致")
        }
        user.signUpInBackground { (error) in
            if error != nil{
                print("error")
            }else{
                //登録成功
                print("登録成功")
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

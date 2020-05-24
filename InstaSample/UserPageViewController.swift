//
//  UserPageViewController.swift
//  InstaSample
//
//  Created by 加藤拓洋 on 2020/05/24.
//  Copyright © 2020 TakumiKato. All rights reserved.
//

import UIKit
import NCMB

class UserPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMenu(){
        let alertController = UIAlertController(title: "メニュー", message: "メニューを選択してください", preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "ログアウト", style: .default) { (action) in
            NCMBUser.logOutInBackground { (error) in
                if error != nil{
                    print(error)
                }else{
                    //ログアウト成功
                    let storyboaed = UIStoryboard(name: "Signin", bundle: Bundle.main)
                    let rootViewController = storyboaed.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //ログアウト状態の保持
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                }
            }
        }
        
        let deleteAction = UIAlertAction(title: "退会", style: .default) { (action) in
            let user = NCMBUser.current()
            user?.deleteInBackground({ (error) in
                if error != nil{
                    print("error")
                }else{
                    //ログアウト成功
                    let storyboaed = UIStoryboard(name: "Signin", bundle: Bundle.main)
                    let rootViewController = storyboaed.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //ログアウト状態の保持
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(signOutAction)
        self.present(alertController,animated: true,completion: nil)
    }
    
}

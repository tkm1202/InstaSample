//
//  EditUserinfoViewController.swift
//  InstaSample
//
//  Created by 加藤拓洋 on 2020/05/24.
//  Copyright © 2020 TakumiKato. All rights reserved.
//

import UIKit
import NCMB
import NYXImagesKit

class EditUserinfoViewController: UIViewController ,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet var userImageView : UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userIDTextField: UITextField!
    @IBOutlet var introductionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        userIDTextField.delegate = self
        introductionTextView.delegate = self
        // Do any additional setup after loading the view.
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.layer.masksToBounds = true
        
        
     //   let userID = NCMBUser.current()?.userName
       // userIDTextField.text = userID
        
        
        if let user = NCMBUser.current(){
            userNameTextField.text = user.object(forKey: "displayName") as? String
            userIDTextField.text = user.userName
            introductionTextView.text = user.object(forKey: "introduction") as? String
            
            
            
            let file = NCMBFile.file(withName: user.objectId, data: nil) as! NCMBFile
                   
                   file.getDataInBackground { (data, error) in
                       if error != nil{
                           print(error)
                       }else{
                           if data != nil{
                               let image = UIImage(data: data!)
                               self.userImageView.image = image
                           }
                       }
                   }
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
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let resizedImage = selectedImage.scale(byFactor: 0.4)
        userImageView.image = resizedImage
        
        picker.dismiss(animated: true, completion: nil)
        
        let file = NCMBFile.file(withName: NCMBUser.current()?.objectId, data: resizedImage!.pngData()) as! NCMBFile
        file.saveInBackground({ (error) in
            if error != nil{
                print(error)
            }else{
                self.userImageView.image = selectedImage
            }
        }) { (progress) in
            print(progress)
        }
            
    }
    
    
    @IBAction func selectImage(){
        let actionContoller = UIAlertController(title: "画像の選択", message: "選択してください", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            //カメラ起動
            if UIImagePickerController.isSourceTypeAvailable(.camera){
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker,animated: true,completion: nil)
            }else{
                print("この機種ではカメラが使えません")
            }
        }
        
        let albumAction = UIAlertAction(title: "フォトライブラリ", style: .default) { (action) in
            //アルバム起動
             if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker,animated: true,completion: nil)
            }else{
                print("この機種ではフォトライブラリが使えません")
            }
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            actionContoller.dismiss(animated: true, completion: nil)
        }
        
        actionContoller.addAction(cameraAction)
        actionContoller.addAction(albumAction)
        actionContoller.addAction(cancelAction)
        self.present(actionContoller,animated: true,completion: nil)
    }
    
    @IBAction func closeEditViewController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveUserInfo(){
        let user = NCMBUser.current()
        user?.setObject(userNameTextField.text, forKey: "displayName")
        user?.setObject(userIDTextField.text, forKey: "userName")
        user?.setObject(introductionTextView.text, forKey: "introduction")
        user?.saveInBackground({ (error) in
            if error != nil{
                print(error)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}

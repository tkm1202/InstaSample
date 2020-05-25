//
//  EditUserinfoViewController.swift
//  InstaSample
//
//  Created by 加藤拓洋 on 2020/05/24.
//  Copyright © 2020 TakumiKato. All rights reserved.
//

import UIKit
import NCMB

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
        
        let userID = NCMBUser.current()?.userName
        userIDTextField.text = userID
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
        userImageView.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
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
}

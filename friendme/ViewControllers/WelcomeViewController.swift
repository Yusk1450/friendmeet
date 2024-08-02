//
//  WelcomeViewController.swift
//  friendme
//
//  Created by ichinose-PC on 2024/07/22.
//

import Foundation
import SwiftUI
class WelcomeViewController:UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad()
	{
        super.viewDidLoad()
        
        userNameTextField.textColor = UIColor.csblack
        userNameTextField.font = UIFont(name: "Kosugi-Regular", size: 14)

		// キーボード表示
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShowNotification),name: UIResponder.keyboardWillShowNotification,object: nil)

        // キーボード非表示
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHideNotification),name: UIResponder.keyboardWillHideNotification,object: nil)
    }
    
    @objc func keyboardWillShowNotification(notification:NSNotification)
	{
		guard let userInfo = notification.userInfo else { return }
		guard let isLocalUserInfoKey = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber else { return }

		if (!isLocalUserInfoKey.boolValue) { return }

		let transform = CGAffineTransform(translationX: 0, y: -200)
		self.view.transform = transform
	}

    @objc func keyboardWillHideNotification(notification:NSNotification)
	{
		guard let userInfo = notification.userInfo else { return }
		guard let isLocalUserInfoKey = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber else { return }

		if (!isLocalUserInfoKey.boolValue) { return }

		self.view.transform = CGAffineTransform.identity
	}
	
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
        textField.resignFirstResponder()
        return true
    }
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
	{
		if let text = self.userNameTextField.text
		{
			if (text.trimmingCharacters(in: .whitespaces) == "")
			{
				AlertUtil.shared.showAlert(title: "ERROR",
										   message: "あなたの名前を入力してください",
										   viewController: self)
				
				return false
			}
			
			// ユーザ名を保存する
			ShareData.shared.userName = text
		}
		return true
	}
}

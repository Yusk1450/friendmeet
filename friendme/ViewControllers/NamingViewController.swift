//
//  PetsFinishViewController.swift
//  friendme
//
//  Created by ichinose-PC on 2024/07/23.
//

import Foundation
import UIKit

class NamingViewController: UIViewController, UITextFieldDelegate
{
	var charaType: CharaType?
	var friendName: String?
	@IBOutlet weak var circleView: CircleView!
	@IBOutlet weak var petsNameTextField: UITextField!
	@IBOutlet weak var charaImgView: UIImageView!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		self.circleView.isSelected = true
        
        petsNameTextField.textColor = UIColor.csblack
        petsNameTextField.font = UIFont(name: "Kosugi-Regular", size: 14)
		
		if let charaType = self.charaType
		{
			self.charaImgView.image = Pet.getCharaImage(charaType: charaType)
		}
		print(self.charaType)
		
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
	
    @IBAction func okBtnAction(_ sender: Any)
	{
		self.performSegue(withIdentifier: "toFinish", sender: self)
    }
    
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
	{
		if let text = self.petsNameTextField.text
		{
			if (text.trimmingCharacters(in: .whitespaces) == "")
			{
				AlertUtil.shared.showAlert(title: "ERROR",
										   message: "ペットの名前を入力してください",
										   viewController: self)
				
				return false
			}
		}
		
		return true
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		let nextViewController = segue.destination as? PetFinishViewController
		nextViewController?.petName = self.petsNameTextField.text
		nextViewController?.charaType = self.charaType
		nextViewController?.friendName = self.friendName
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
		textField.resignFirstResponder()
		return true
	}

}

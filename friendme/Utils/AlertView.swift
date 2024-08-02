//
//  AlertUtil.swift
//  friendme
//
//  Created by ISHIGO Yusuke on 2024/07/24.
//

import UIKit

class AlertUtil: NSObject
{
	static let shared = AlertUtil()
	
	func showAlert(title:String, message:String, viewController:UIViewController)
	{
		let alert = UIAlertController(title: title,
									  message: message,
									  preferredStyle: .alert)
		
		let okAction = UIAlertAction(title: "OK", style: .default)
		alert.addAction(okAction)
		
		viewController.present(alert, animated: true)
	}
	
	func showYesNoAlert(title:String, message:String, viewController:UIViewController, okHandler: @escaping ((UIAlertAction) -> Void), cancelHandler: @escaping ((UIAlertAction) -> Void))
	{
		let alert = UIAlertController(title: title,
									  message: message,
									  preferredStyle: .alert)
		
		let yesAction = UIAlertAction(title: "OK", style: .default, handler: okHandler)
		alert.addAction(yesAction)

		let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: cancelHandler)
		alert.addAction(cancelAction)
		
		viewController.present(alert, animated: true)
	}
}

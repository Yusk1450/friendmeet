//
//  CircleView.swift
//  friendme
//
//  Created by ISHIGO Yusuke on 2024/07/24.
//

import UIKit

class CircleView: UIView
{
	var _isSelected = false
	var isSelected:Bool
	{
		set {
			self.backgroundColor = newValue ? UIColor(hexString: "DB9344", alpha: 1.0) : UIColor(hexString: "E8CCBF", alpha: 1.0)
			_isSelected = newValue
		}
		get {
			return _isSelected
		}
	}
	
	override func awakeFromNib()
	{
		self.isSelected = false
		self.layer.cornerRadius = self.frame.size.width / 2.0
	}
}

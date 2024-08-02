//
//  CustomSegmentedControl.swift
//  friendme
//
//  Created by ISHIGO Yusuke on 2024/07/24.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl
{
	override func awakeFromNib()
	{
		self.backgroundColor = UIColor.white
		self.selectedSegmentTintColor = UIColor(hexString: "93CA76", alpha: 1.0)
		self.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
		self.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
	}

}

//
//  Animator.swift
//  friendme
//
//  Created by ISHIGO Yusuke on 2024/07/24.
//

import UIKit

class Animator: UIImageView
{
	var imageNames = [String]()
	var timer:Timer?
	var counter = 0
	
	func setAnimationImages(imageNames:[String])
	{
		self.imageNames = imageNames
		
		if (self.imageNames.count > 0)
		{
			self.image = UIImage(named: self.imageNames[0])
		}
	}
	
	@objc func animation()
	{
		let imgIdx = self.counter % self.imageNames.count
		self.image = UIImage(named: self.imageNames[imgIdx])
		self.counter += 1
	}
	
	func startAnimation()
	{
		if let timer = self.timer
		{
			if (timer.isValid)
			{
				return
			}
		}
		
		self.timer = Timer.scheduledTimer(timeInterval: 0.7,
										  target: self,
										  selector: #selector(self.animation),
										  userInfo: nil,
										  repeats: true)
	}
	
	func stopAnimation()
	{
		self.timer?.invalidate()
		self.counter = 0
		
		if (self.imageNames.count > 0)
		{
			self.image = UIImage(named: self.imageNames[0])
		}
	}

}

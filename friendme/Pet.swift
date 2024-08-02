//
//  Pet.swift
//  friendme
//
//  Created by ISHIGO Yusuke on 2024/07/24.
//

import UIKit

enum CharaImageType: Int
{
	case Normal
	case Frame
	case Dead
}

class PetView: Animator
{
	var fukidashiImgView:UIImageView?
	
	func showFukidashi(isShown:Bool)
	{
		fukidashiImgView?.removeFromSuperview()
		fukidashiImgView = nil
		
		if (isShown)
		{
			// ふきだし
			let mark = UIImageView(frame: CGRect(x: self.frame.size.width - 40.0,
												 y: -10.0,
												 width: 83.0,
												 height: 83.0))
			mark.image = UIImage(named: "feed")
			self.addSubview(mark)
			
			fukidashiImgView = mark
		}
	}
}

class Pet: NSObject
{
	var charaType:CharaType?
	var name:String?
	var friendName:String?
	var birthDate = Date()
	var lastFeedDate:Date?
	var isDead = false
	var achivements = [Achievement]()
	
	class func getCharaImage(charaType:CharaType, imageType:CharaImageType = .Normal) -> UIImage?
	{
		if (charaType == .Cat)
		{
			if (imageType == .Dead)
			{
				return UIImage(named: "dead_cat")
			}
			else if (imageType == .Frame)
			{
				return UIImage(named: "seal_cat")
			}
			return UIImage(named: "animal_cat")
		}
		else if (charaType == .Mouse)
		{
			if (imageType == .Dead)
			{
				return UIImage(named: "dead_mouse")
			}
			else if (imageType == .Frame)
			{
				return UIImage(named: "seal_mouse")
			}
			return UIImage(named: "animal_mouse")
		}
		else if (charaType == .Penguin)
		{
			if (imageType == .Dead)
			{
				return UIImage(named: "dead_penguin")
			}
			else if (imageType == .Frame)
			{
				return UIImage(named: "seal_penguin")
			}
			return UIImage(named: "animal_penguin")
		}
		else if (charaType == .Rabbit)
		{
			if (imageType == .Dead)
			{
				return UIImage(named: "dead_rabit")
			}
			else if (imageType == .Frame)
			{
				return UIImage(named: "seal_rabit")
			}
			return UIImage(named: "animal_rabit")
		}
		else if (charaType == .Shimaenaga)
		{
			if (imageType == .Dead)
			{
				return UIImage(named: "dead_bird")
			}
			else if (imageType == .Frame)
			{
				return UIImage(named: "seal_bird")
			}
			return UIImage(named: "animal_bird")
		}
		
		return nil
	}
	
	class func getAnimationImageNames(charaType:CharaType) -> [String]
	{
		var imageNames = [String]()
		
		if (charaType == CharaType.Cat)
		{
			imageNames = [
				"animal_cat",
				"animal_cat2",
				"animal_cat",
				"animal_cat3"
			]
		}
		else if (charaType == CharaType.Mouse)
		{
			imageNames = [
				"animal_mouse",
				"animal_mouse2",
				"animal_mouse",
				"animal_mouse3"
			]
		}
		else if (charaType == CharaType.Penguin)
		{
			imageNames = [
				"animal_penguin",
				"animal_penguin2",
				"animal_penguin3"
			]
		}
		else if (charaType == CharaType.Rabbit)
		{
			imageNames = [
				"animal_rabit",
				"animal_rabit2",
				"animal_rabit",
				"animal_rabit3"
			]
		}
		else if (charaType == CharaType.Shimaenaga)
		{
			imageNames = [
				"animal_bird",
				"animal_bird2",
				"animal_bird",
				"animal_bird3"
			]
		}
		
		return imageNames
	}
	
}

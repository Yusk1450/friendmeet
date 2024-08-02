//
//  ShareData.swift
//  friendme
//
//  Created by ichinose-PC on 2024/07/23.
//

import Foundation
import UIKit

enum Achievement: Int
{
	case Meeting
	case Dead
	case OneMonth
	case ThreeMonth
	case SixMonth
	case OneYear
	case Feed1
	case Feed2
	case Feed3
	case Feed4
	case Feed5
}

enum CharaType: Int
{
	case Penguin
	case Shimaenaga
	case Rabbit
	case Cat
	case Mouse
}

enum UserDefaultKey: String
{
	case isFirst
	case userName
	case pets
}

class ShareData: NSObject
{
    static let shared = ShareData()
	var pets = [Pet]()

	override init()
	{
		super.init()
		
		let ud = UserDefaults.standard
		ud.register(defaults: [UserDefaultKey.isFirst.rawValue: true, UserDefaultKey.pets.rawValue: [Pet]()])
	}
	
	var isFirst: Bool {
		set {
			let ud = UserDefaults.standard
			ud.setValue(newValue, forKey: UserDefaultKey.isFirst.rawValue)
		}
		get {
			let ud = UserDefaults.standard
			return ud.bool(forKey: UserDefaultKey.isFirst.rawValue)
		}
	}
	
	var userName: String {
		set {
			let ud = UserDefaults.standard
			ud.setValue(newValue, forKey: UserDefaultKey.userName.rawValue)
		}
		get {
			let ud = UserDefaults.standard
			return ud.string(forKey: UserDefaultKey.userName.rawValue) ?? ""
		}
	}
	
	func loadPets()
	{
		var pets = [Pet]()
		
//		for i in 0..<5
//		{
//			let pet = Pet()
//			pet.charaType = CharaType(rawValue: i)
//			
//			pets.append(pet)
//		}
		
		let ud = UserDefaults.standard
		guard let petData = ud.array(forKey: UserDefaultKey.pets.rawValue) as? [[String:Any]] else
		{
			return
		}
		
		for data in petData
		{
			let pet = Pet()
			// 名前
			pet.name = data["name"] as? String
			// キャラの種類
			if let charaTypeRawValue = data["charaType"] as? Int
			{
				pet.charaType = CharaType(rawValue: charaTypeRawValue)
			}
			// 友達の名前
			pet.friendName = data["friendName"] as? String
			// 最後にエサをあげた日
			if let lastFeedDateStr = data["lastFeedDate"] as? String
			{
				let df = DateFormatter()
				df.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
				pet.lastFeedDate = df.date(from: lastFeedDateStr)
			}
			// 生きているか？
			if let isDead = data["isDead"] as? Bool
			{
				pet.isDead = isDead
			}
			// シール
			if let achivementRawValues = data["achivements"] as? [Int]
			{
				for achivementRawValue in achivementRawValues
				{
					pet.achivements.append(Achievement(rawValue: achivementRawValue)!)
				}
			}
			
			
			pets.append(pet)
		}
		
		self.pets = pets
	}
	
	func savePets()
	{
		let ud = UserDefaults.standard
				
		var data = [[String:Any]]()
		for pet in self.pets
		{
			var petData = [String:Any]()
			petData["name"] = pet.name
			petData["charaType"] = pet.charaType?.rawValue
			petData["friendName"] = pet.friendName
			petData["lastFeedDate"] = pet.lastFeedDate?.description
			petData["isDead"] = pet.isDead
			
			var achivementRawValue = [Int]()
			for achivement in pet.achivements
			{
				achivementRawValue.append(achivement.rawValue)
			}
			petData["achivements"] = achivementRawValue
			
			data.append(petData)
		}

		ud.set(data, forKey: UserDefaultKey.pets.rawValue)
	}
	
	
	
}

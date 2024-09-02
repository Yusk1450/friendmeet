//
//  ShareData.swift
//  friendme
//
//  Created by ichinose-PC on 2024/07/23.
//

import Foundation
import UIKit
import CoreLocation

class AchievementData: NSObject, NSCoding
{
	let achievement:Achievement
	let location: CLLocationCoordinate2D
	
	init(achievement: Achievement, location: CLLocationCoordinate2D)
	{
		self.achievement = achievement
		self.location = location
	}
	
	func encode(with coder: NSCoder)
	{
		coder.encode(self.achievement.rawValue, forKey: "achievement")
		coder.encode(self.location.latitude, forKey: "latitude")
		coder.encode(self.location.longitude, forKey: "longitude")
	}
	
	required init?(coder: NSCoder)
	{
		self.achievement = Achievement(rawValue: coder.decodeInteger(forKey: "achievement"))!
		let latitude = coder.decodeDouble(forKey: "latitude")
		let longitude = coder.decodeDouble(forKey: "longitude")
		self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
}

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

class ShareData: NSObject, CLLocationManagerDelegate
{
	let locationManager = CLLocationManager()
	var location:CLLocation?
	
    static let shared = ShareData()
	var pets = [Pet]()

	override init()
	{
		super.init()
		
		let ud = UserDefaults.standard
		ud.register(defaults: [UserDefaultKey.isFirst.rawValue: true, UserDefaultKey.pets.rawValue: [Pet]()])
		
		// 位置情報サービスが使えるかどうか
		if (CLLocationManager.locationServicesEnabled())
		{
			self.locationManager.delegate = self
			self.locationManager.distanceFilter = kCLDistanceFilterNone
			self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
	{
		switch (status)
		{
			case .notDetermined:
				self.locationManager.requestWhenInUseAuthorization()
				
			case .authorizedWhenInUse:
				self.locationManager.startUpdatingLocation()
				
			default:
				break
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
	{
		if let location = locations.last
		{
			self.location = location
		}
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
			if let achivementData = data["achivements"] as? Data,
			   let achivements = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(achivementData) as? [AchievementData]
			{
				pet.achivements = achivements
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

			if let achivementArchive = try? NSKeyedArchiver.archivedData(withRootObject: pet.achivements, requiringSecureCoding: false)
			{
				petData["achivements"] = achivementArchive
			}
			
			data.append(petData)
		}

		ud.set(data, forKey: UserDefaultKey.pets.rawValue)
	}
	
	
	
}

//
//  FInishViewController.swift
//  friendme
//
//  Created by ISHIGO Yusuke on 2024/07/24.
//

import UIKit

class PetFinishViewController: UIViewController
{
	var charaType: CharaType?
	var petName:String?
	var friendName: String?
	
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var destLbl: UITextView!
	@IBOutlet weak var charaImgView: UIImageView!
	
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

		if let charaType = self.charaType
		{
			self.charaImgView.image = Pet.getCharaImage(charaType: charaType)
		}
		print(self.charaType)
		
		if let petName = self.petName
		{
			self.titleLbl.text = "\(petName)が誕生しました"
			self.destLbl.text = "\(petName)を大事にしてね！"
		}
		
		let shared = ShareData.shared
		
		let pet = Pet()
		pet.name = self.petName
		pet.charaType = self.charaType
		pet.friendName = self.friendName
		pet.lastFeedDate = Date()
		
		if let location = shared.location
		{
			pet.achivements.append(AchievementData(achievement: .Meeting, location: location.coordinate))
			pet.achivements.append(AchievementData(achievement: .OneMonth, location: location.coordinate))
			pet.achivements.append(AchievementData(achievement: .ThreeMonth, location: location.coordinate))
			pet.achivements.append(AchievementData(achievement: .SixMonth, location: location.coordinate))
			pet.achivements.append(AchievementData(achievement: .OneYear, location: location.coordinate))
			pet.achivements.append(AchievementData(achievement: .Feed1, location: location.coordinate))
			pet.achivements.append(AchievementData(achievement: .Feed2, location: location.coordinate))
			pet.achivements.append(AchievementData(achievement: .Feed3, location: location.coordinate))
			pet.achivements.append(AchievementData(achievement: .Feed4, location: location.coordinate))
			pet.achivements.append(AchievementData(achievement: .Feed5, location: location.coordinate))
		}
		
		ShareData.shared.pets.append(pet)
		ShareData.shared.savePets()
    }

	@IBAction func backBtnAction(_ sender: Any)
	{
		ShareData.shared.isFirst = false
		self.view.window?.rootViewController?.dismiss(animated: true)
	}
	
}

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
		
		let pet = Pet()
		pet.name = self.petName
		pet.charaType = self.charaType
		pet.friendName = self.friendName
		pet.lastFeedDate = Date()
		pet.achivements.append(.Meeting)
		pet.achivements.append(.OneMonth)
		pet.achivements.append(.ThreeMonth)
		pet.achivements.append(.SixMonth)
		pet.achivements.append(.OneYear)
		pet.achivements.append(.Feed1)
		pet.achivements.append(.Feed2)
		pet.achivements.append(.Feed3)
		pet.achivements.append(.Feed4)
		pet.achivements.append(.Feed5)
		ShareData.shared.pets.append(pet)
		ShareData.shared.savePets()
    }

	@IBAction func backBtnAction(_ sender: Any)
	{
		ShareData.shared.isFirst = false
		self.view.window?.rootViewController?.dismiss(animated: true)
	}
	
}

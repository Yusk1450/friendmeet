//
//  AchievementViewController.swift
//  friendme
//
//  Created by ISHIGO Yusuke on 2024/07/29.
//

import UIKit

class AchievementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	var pet:Pet?
	var items = [Achievement]()
	
	@IBOutlet weak var titleLbl: UILabel!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

		if let achivements = self.pet?.achivements,
		   let petName = self.pet?.name
		{
			self.items = achivements
			self.titleLbl.text = "「\(petName)」との思い出"
		}
    }
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return 162.0
	}
	
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let identifier = "Basic-Cell"
		var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
		
		if (cell == nil)
		{
			cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
		}
		
		guard let bgImgView = cell?.viewWithTag(100) as? UIImageView,
			  let textImgView = cell?.viewWithTag(150) as? UIImageView,
			  let petImgView = cell?.viewWithTag(180) as? UIImageView,
			  let textLbl = cell?.viewWithTag(300) as? UILabel,
			  let friendName = self.pet?.friendName,
			  let petType = self.pet?.charaType else
		{
			return cell!
		}
		
		textImgView.frame.origin.x = 32.0
		textImgView.frame.origin.y = 12.0
		bgImgView.image = nil
		
		if (self.items[indexPath.row] == .Meeting)
		{
			bgImgView.image = UIImage(named: "seal_backstar")
			textImgView.image = UIImage(named: "seal_meet")
			petImgView.image = Pet.getCharaImage(charaType: petType, imageType: .Frame)
			textLbl.text = "「\(friendName)」との出会い"
		}
		else if (self.items[indexPath.row] == .OneMonth)
		{
			bgImgView.image = UIImage(named: "seal_backcircle")
			textImgView.image = UIImage(named: "seal_1month")
			petImgView.image = Pet.getCharaImage(charaType: petType, imageType: .Frame)
			textLbl.text = "出会って、1ヶ月"
		}
		else if (self.items[indexPath.row] == .ThreeMonth)
		{
			bgImgView.image = UIImage(named: "seal_backcircle")
			textImgView.image = UIImage(named: "seal_3month")
			petImgView.image = Pet.getCharaImage(charaType: petType, imageType: .Frame)
			textLbl.text = "出会って、3ヶ月"
		}
		else if (self.items[indexPath.row] == .SixMonth)
		{
			bgImgView.image = UIImage(named: "seal_backcircle")
			textImgView.image = UIImage(named: "seal_6month")
			petImgView.image = Pet.getCharaImage(charaType: petType, imageType: .Frame)
			textLbl.text = "出会って、6ヶ月"
		}
		else if (self.items[indexPath.row] == .OneYear)
		{
			bgImgView.image = UIImage(named: "seal_backstar")
			textImgView.image = UIImage(named: "seal_1year")
			petImgView.image = Pet.getCharaImage(charaType: petType, imageType: .Frame)
			textLbl.text = "出会って、1年"
		}
		else if (self.items[indexPath.row] == .Dead)
		{
			bgImgView.image = UIImage(named: "seal_backdead")
			textImgView.image = UIImage(named: "seal_dead")
			petImgView.image = Pet.getCharaImage(charaType: petType, imageType: .Dead)
			textLbl.text = "「\(friendName)」との別れ"
		}
		else if (self.items[indexPath.row] == .Feed1)
		{
			bgImgView.image = UIImage(named: "seal_backesa")
			textImgView.image = UIImage(named: "feed1")
			petImgView.image = Pet.getCharaImage(charaType: petType, imageType: .Frame)
			textLbl.text = "餌をあげた"
			textImgView.frame.origin.x -= 10.0
			textImgView.frame.origin.y -= 1.0
		}
		else if (self.items[indexPath.row] == .Feed2)
		{
			bgImgView.image = UIImage(named: "seal_backesa")
			textImgView.image = UIImage(named: "feed2")
			petImgView.image = Pet.getCharaImage(charaType: petType, imageType: .Frame)
			textLbl.text = "2日連続で餌をあげた"
			textImgView.frame.origin.x -= 10.0
			textImgView.frame.origin.y -= 1.0
		}
		else if (self.items[indexPath.row] == .Feed3)
		{
			bgImgView.image = UIImage(named: "seal_backesa")
			textImgView.image = UIImage(named: "feed3")
			petImgView.image = Pet.getCharaImage(charaType: petType, imageType: .Frame)
			textLbl.text = "5日連続で餌をあげた"
			textImgView.frame.origin.x -= 10.0
			textImgView.frame.origin.y -= 1.0
		}
		else if (self.items[indexPath.row] == .Feed4)
		{
			bgImgView.image = UIImage(named: "seal_backesa")
			textImgView.image = UIImage(named: "feed4")
			petImgView.image = Pet.getCharaImage(charaType: petType, imageType: .Frame)
			textLbl.text = "25日連続で餌をあげた"
			textImgView.frame.origin.x -= 10.0
			textImgView.frame.origin.y -= 1.0
		}
		else if (self.items[indexPath.row] == .Feed5)
		{
			bgImgView.image = UIImage(named: "seal_backesa")
			textImgView.image = UIImage(named: "feed5")
			petImgView.image = Pet.getCharaImage(charaType: petType, imageType: .Frame)
			textLbl.text = "「\(friendName)」と永遠の友達"
			textImgView.frame.origin.x -= 10.0
			textImgView.frame.origin.y -= 1.0
		}
		
		return cell!
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	@IBAction func backBtnAction(_ sender: Any)
	{
		if let presentingVC = self.presentingViewController?.presentingViewController
		{
			presentingVC.dismiss(animated: true, completion: nil)
		}
	}
	
	@IBAction func createPetBtnAction(_ sender: Any)
	{
		self.performSegue(withIdentifier: "toCreate", sender: self)
	}
}

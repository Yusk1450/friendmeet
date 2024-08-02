//
//  MemoryViewController.swift
//  friendme
//
//  Created by ISHIGO Yusuke on 2024/07/24.
//

import UIKit

class MemoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	var pets = [Pet]()
	var selectedPet:Pet?
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		ShareData.shared.loadPets()
		self.pets = ShareData.shared.pets
	}
	
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.pets.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return 168.0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let identifier = "Basic-Cell"
		
		var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
		
		if (cell == nil)
		{
			cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
		}
		
		if let imgView = cell?.viewWithTag(100) as? UIImageView,
		   let charaType = self.pets[indexPath.row].charaType
		{
			imgView.image = Pet.getCharaImage(charaType: charaType, imageType: .Frame)
		}
		if let petNameLbl = cell?.viewWithTag(200) as? UILabel
		{
			petNameLbl.text = self.pets[indexPath.row].name
		}
		if let friendNameLbl = cell?.viewWithTag(300) as? UILabel
		{
			friendNameLbl.text = self.pets[indexPath.row].friendName
		}
		
		return cell!
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		self.selectedPet = self.pets[indexPath.row]
		self.performSegue(withIdentifier: "toAchievement", sender: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if let nextViewController = segue.destination as? AchievementViewController
		{
			nextViewController.pet = self.selectedPet
		}
	}
	
	@IBAction func backBtnAction(_ sender: Any)
	{
		self.dismiss(animated: true)
	}
	
	@IBAction func createPetBtnAction(_ sender: Any)
	{
		self.performSegue(withIdentifier: "toCreate", sender: self)
	}
}

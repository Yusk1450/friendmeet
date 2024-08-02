//
//  HomeViewController.swift
//  friendme
//
//  Created by ichinose-PC on 2024/07/23.
//

import Foundation
import UIKit

class HomeViewController: UIViewController
{
	let charaBaseSize:CGFloat = 180.0
	
	var pets = [PetView]()
	var timer:Timer?
	var layerTimer:Timer?
	
	var selectedPet:Pet?

	var demoTimer:Timer?
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
    }
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		
		for pet in self.pets
		{
			pet.removeFromSuperview()
		}
		
		ShareData.shared.loadPets()
		self.createPets(pets: ShareData.shared.pets)

		self.demoTimer = Timer.scheduledTimer(timeInterval: 0.5,
											  target: self,
											  selector: #selector(self.demoTimerAction(timer:)),
											  userInfo: nil,
											  repeats: true)
	}
	
	override func viewDidDisappear(_ animated: Bool)
	{
		super.viewDidDisappear(animated)
		
		self.demoTimer?.invalidate()
	}
	
	// --------------------------------------------------------------------
	// デモ用に1秒に1日最後にエサをあげた日を遡らせる
	// --------------------------------------------------------------------
	@objc func demoTimerAction(timer:Timer)
	{
		var counter = 0
		for pet in ShareData.shared.pets
		{
			// 死んだペットは処理しない
			if (pet.isDead)
			{
				continue
			}
			
			let calendar = Calendar.current

			if let lastFeedDate = pet.lastFeedDate
			{
				let yesterday = calendar.date(byAdding: .day, value: -1, to: lastFeedDate)
				pet.lastFeedDate = yesterday
				
				let components = calendar.dateComponents([.day], from: lastFeedDate, to: Date())
				if let dayDiff = components.day
				{
					if (self.updatePetState(petData: pet, petView: self.pets[counter], dayDiff: dayDiff))
					{
						return
					}
					print(dayDiff)
				}
			}
			
			counter += 1
		}
		
//		ShareData.shared.savePets()
	}
	
	func updatePetState(petData:Pet, petView:PetView, dayDiff:Int) -> Bool
	{
		var isDead = false
		
		// 20日以上経つとふきだしを表示する
		petView.showFukidashi(isShown: dayDiff >= 20 ? true : false)
		
		// 49日で死亡する
		if (dayDiff >= 49)
		{
			isDead = true

			if let petIdx = ShareData.shared.pets.firstIndex(of: petData)
			{
				ShareData.shared.pets[petIdx].isDead = true
				ShareData.shared.pets[petIdx].achivements.append(.Dead)
				ShareData.shared.savePets()
			}
			petView.removeFromSuperview()

			self.selectedPet = petData
			self.performSegue(withIdentifier: "toDead", sender: self)
		}
		
		return isDead
	}
	
	@IBAction func createPetBtnAction(_ sender: Any)
	{
		self.performSegue(withIdentifier: "toCreate", sender: self)
	}
	
	@IBAction func memoryBtnAction(_ sender: Any)
	{
		self.performSegue(withIdentifier: "toMemory", sender: self)
	}

	private func createPets(pets:[Pet])
	{
		self.pets.removeAll()
		
		var counter = 0
		for pet in pets
		{
			guard let charaType = pet.charaType else
			{
				continue
			}
			
			// 死んだペットは処理しない
			if (pet.isDead)
			{
				continue
			}
			
			// キャラクターのベースサイズ
			var charaSize = charaBaseSize

			if (charaType == .Mouse)
			{
				charaSize = charaSize * 1.2
			}
			else if (charaType == .Penguin)
			{
				charaSize = charaSize * 1.2
			}
			
			let petImg = PetView(frame: CGRect(
				x: CGFloat.random(in: 0..<self.view.frame.width - charaSize),
				y: CGFloat.random(in: 0..<self.view.frame.height - 200 - charaSize),
				width: charaSize,
				height: charaSize))
			petImg.isUserInteractionEnabled = true

			petImg.setAnimationImages(imageNames: Pet.getAnimationImageNames(charaType: charaType))
			print(charaType)

			// 配列の何番目かを記録しておく
			petImg.tag = counter
			
			let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(sender:)))
			petImg.addGestureRecognizer(gestureRecognizer)

			self.pets.append(petImg)
			self.view.addSubview(petImg)
			
			counter += 1
		}
		
		self.timer?.invalidate()
		self.timer = Timer.scheduledTimer(timeInterval: Double.random(in: 1..<3),
											 target: self,
											 selector: #selector(self.timerAction(timer:)),
											 userInfo: nil,
											 repeats: false)
		
		self.layerTimer?.invalidate()
		self.layerTimer = Timer.scheduledTimer(timeInterval: 0.1,
											   target: self,
											   selector: #selector(self.layerTimerAction(timer:)),
											   userInfo: nil,
											   repeats: true)
	}
	
	@objc func tapAction(sender:UIGestureRecognizer)
	{
		guard let view = sender.view else {
			return
		}
		
		self.selectedPet = ShareData.shared.pets[view.tag]

		self.performSegue(withIdentifier: "toDetail", sender: self)
	}
	
	@objc func timerAction(timer:Timer)
	{
		if (Int.random(in: 0...1) == 0)
		{
			guard let petImg = self.pets.randomElement() else
			{
				return
			}
					
			petImg.startAnimation()
			
			UIView.animate(withDuration: 5.0, delay: 0.0, options: .curveLinear) {
				
				let footerSize:CGFloat = 200.0
				
				petImg.frame.origin.x = CGFloat.random(in: 0..<self.view.frame.width - petImg.frame.size.width)
				petImg.frame.origin.y = CGFloat.random(in: 0..<self.view.frame.height - footerSize - petImg.frame.size.height)
				
			} completion: { isFinished in
				
				if (isFinished)
				{
					petImg.stopAnimation()
				}
				
			}

			

		}
		self.timer = Timer.scheduledTimer(timeInterval: Double.random(in: 1..<3),
											 target: self,
											 selector: #selector(self.timerAction(timer:)),
											 userInfo: nil,
											 repeats: false)
	}
	
	@objc func layerTimerAction(timer:Timer)
	{
		let sortedPetImgViews = self.pets.sorted(by: { $0.frame.origin.y < $1.frame.origin.y })
		
		for v in sortedPetImgViews
		{
			self.view.bringSubviewToFront(v)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if (segue.identifier == "toDetail")
		{
			let nextViewController = segue.destination as? PetDetailViewController
			nextViewController?.pet = self.selectedPet
		}
		else if (segue.identifier == "toDead")
		{
			let nextViewController = segue.destination as? DeadViewController
			nextViewController?.pet = self.selectedPet
		}
	}

}


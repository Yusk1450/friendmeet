//
//  PetDetailViewController.swift
//  friendme
//
//  Created by ISHIGO Yusuke on 2024/07/24.
//

import UIKit
import AVFoundation

class PetDetailViewController: UIViewController, CameraDelegate
{
	var camera:CamCapture?
	
	var pet:Pet?
	@IBOutlet weak var petImgView: UIImageView!
	@IBOutlet weak var qrcodeImgView: UIImageView!

	@IBOutlet weak var petNameLbl: UILabel!
	@IBOutlet weak var friendNameLbl: UILabel!
	@IBOutlet weak var birthdateLbl: UILabel!
	
	@IBOutlet weak var remainDeadDayLbl: UILabel!
	
	var isDetected = false
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
        
        petNameLbl.textColor = UIColor.csblack
        petNameLbl.font = UIFont(name: "Kosugi-Regular", size: 14)
        friendNameLbl.textColor = UIColor.csblack
        friendNameLbl.font = UIFont(name: "Kosugi-Regular", size: 14)
        birthdateLbl.textColor = UIColor.csblack
        birthdateLbl.font = UIFont(name: "Kosugi-Regular", size: 14)
		
		let userName = ShareData.shared.userName
		self.qrcodeImgView.image = self.generateQRCode(from: userName)
		
		if let pet = self.pet
		{
			self.petNameLbl.text = pet.name
			self.friendNameLbl.text = pet.friendName
			
			let df = DateFormatter()
			df.calendar = Calendar(identifier: .gregorian)
			df.dateFormat = "yyyy/MM/dd"
			self.birthdateLbl.text = df.string(from: pet.birthDate)
			
			if let charaType = pet.charaType
			{
				self.petImgView.image = Pet.getCharaImage(charaType: charaType, imageType: .Frame)
			}
			
			if let lastFeedDate = pet.lastFeedDate
			{
				let calendar = Calendar.current
				let components = calendar.dateComponents([.day], from: lastFeedDate, to: Date())
				
				if let dayDiff = components.day
				{
					let remainDay = 49 - dayDiff
					self.remainDeadDayLbl.text = "餓死するまで、あと\(remainDay)日"
				}
			}
			else
			{
				self.remainDeadDayLbl.text = "餓死するまで、あと49日"
			}
		}
		
    }
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		
		self.camera = CamCapture(isFront: true)
		self.camera?.delegate = self
	}
	
	override func viewDidDisappear(_ animated: Bool)
	{
		super.viewDidDisappear(animated)
		
		self.camera?.disposeAVCapture()
	}
    
	func generateQRCode(from string: String) -> UIImage?
	{
		let data = string.data(using: String.Encoding.utf8)

		if let filter = CIFilter(name: "CIQRCodeGenerator")
		{
			filter.setValue(data, forKey: "inputMessage")
			filter.setValue("Q", forKey: "inputCorrectionLevel")

			if let output = filter.outputImage
			{
				let transform = CGAffineTransform(scaleX: 10, y: 10)
				let scaledOutput = output.transformed(by: transform)

				if let cgImage = CIContext().createCGImage(scaledOutput, from: scaledOutput.extent)
				{
					return UIImage(cgImage: cgImage)
				}
			}
		}

		return nil
	}
	
	@IBAction func backBtnAction(_ sender: Any)
	{
		self.dismiss(animated: true)
	}
	
	func cameraDidQRCodeDetect(camera: CamCapture, code: String)
	{
		if (self.isDetected)
		{
			return
		}
		self.isDetected = true
		
		Timer.scheduledTimer(timeInterval: 5.0,
							 target: self,
							 selector: #selector(self.timerAction(sender:)),
							 userInfo: nil,
							 repeats: false)
	}
	
	@objc func timerAction(sender:Timer)
	{
		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
		
		AlertUtil.shared.showYesNoAlert(title: "",
										message: "友達のバーコードを読み込みました\n画面を閉じますか？",
										viewController: self) { [weak self] action in
			guard let wself = self else { return }
			
			wself.pet?.lastFeedDate = Date()
			ShareData.shared.savePets()
			
			wself.isDetected = false
			wself.dismiss(animated: true)

		} cancelHandler: { [weak self] action in
			guard let wself = self else { return }
			wself.isDetected = false
		}
	}
}

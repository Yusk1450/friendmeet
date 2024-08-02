//
//  QRViewController.swift
//  friendme
//
//  Created by ichinose-PC on 2024/07/23.
//

import Foundation
import UIKit
import CoreImage
import AVFoundation

class QRViewController: UIViewController, CameraDelegate
{
	@IBOutlet weak var circleView: CircleView!
	@IBOutlet weak var qrcodeImgView: UIImageView!
	
	var camera:CamCapture?
	var isDetected = false
	
	var friendName = ""
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		self.circleView.isSelected = true
		
		let userName = ShareData.shared.userName
		self.qrcodeImgView.image = self.generateQRCode(from: userName)
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
	
	func cameraDidQRCodeDetect(camera: CamCapture, code: String)
	{
		if (self.isDetected)
		{
			return
		}
		self.isDetected = true
		
		self.friendName = code
		print(code)

		// 相手が読み込むまで少し待つ
		Timer.scheduledTimer(timeInterval: 5.0,
							 target: self,
							 selector: #selector(self.timerAction(timer:)),
							 userInfo: nil,
							 repeats: false)
	}
	
	@objc func timerAction(timer:Timer)
	{
		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
		
		AlertUtil.shared.showYesNoAlert(title: "",
										message: "友達のバーコードを読み込みました\n次のステップに進みますか？",
										viewController: self) { [weak self] action in
			guard let wself = self else { return }
			
			wself.performSegue(withIdentifier: "toDiagnosis", sender: self)
			wself.isDetected = false

		} cancelHandler: { [weak self] action in
			guard let wself = self else { return }
			wself.isDetected = false
		}
	}
    
	@IBAction func backBtnAction(_ sender: Any)
	{
		self.dismiss(animated: true)
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

	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if let nextViewController = segue.destination as? DiagnosisViewController
		{
			nextViewController.friendName = self.friendName
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
	{
		self.friendName = "なかのん"
		self.performSegue(withIdentifier: "toDiagnosis", sender: self)
	}

}



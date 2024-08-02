//
//  CamCapture.swift
//  CameraSample
//
//  Created by Yusk1450 on 2018/01/19.
//  Copyright © 2018年 Yusk. All rights reserved.
//

import UIKit
import AVFoundation
import CoreVideo

protocol CameraDelegate: AnyObject
{
	func cameraDidQRCodeDetect(camera:CamCapture, code:String)
}

class CamCapture: NSObject, AVCaptureMetadataOutputObjectsDelegate
{
	private var captureSession:AVCaptureSession?
	private var isFront = false
	
	weak var delegate:CameraDelegate?
	
	init(isFront:Bool = false)
	{
		super.init()
		
		self.setupAVCapture(isFront: isFront)
	}
	
	deinit
	{
		self.disposeAVCapture()
	}
	
	/* -----------------------------------------------------
	* 初期化処理
	------------------------------------------------------ */
	func setupAVCapture(isFront:Bool)
	{
		self.disposeAVCapture()
		
		self.isFront = isFront
		
		self.captureSession = AVCaptureSession()
		
		if let captureSession = self.captureSession
		{
			captureSession.sessionPreset = AVCaptureSession.Preset.photo
			
			guard let input = self.captureDeviceInput() else
			{
				print("Failed: Get capture device input.")
				return
			}
			
			if (captureSession.canAddInput(input))
			{
				captureSession.addInput(input)
			}
			
			let metadataOutput = AVCaptureMetadataOutput()
			
			if (captureSession.canAddOutput(metadataOutput))
			{
				captureSession.addOutput(metadataOutput)

				metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
				metadataOutput.metadataObjectTypes = [.qr]
			}
					
			captureSession.startRunning()
		}
	}
	
	/* -----------------------------------------------------
	* 終了処理
	------------------------------------------------------ */
	func disposeAVCapture()
	{
		guard let captureSession = self.captureSession else
		{
			return
		}
		
		captureSession.stopRunning()
		
		for output in captureSession.outputs
		{
			captureSession.removeOutput(output)
		}
		
		for input in captureSession.inputs
		{
			captureSession.removeInput(input)
		}
	}
	
	/* -----------------------------------------------------
	* プレビューレイヤーを返す
	------------------------------------------------------ */
	func previewLayerWithFrame(_ frame:CGRect) -> AVCaptureVideoPreviewLayer?
	{
		guard let captureSession = self.captureSession else
		{
			return nil
		}
		
		let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		videoPreviewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
		
		// 指定したframeと実際のカメラ画像のサイズ（captureSession.sessionPresetに指定）を比較して、
		// 差が少ない辺に合わせ、アスペクト比を変更しないで、はみ出した部分は隠す
		videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
		videoPreviewLayer.frame = frame
		
		// フロントカメラの場合は反転する
		if (self.isFront)
		{
			videoPreviewLayer.setAffineTransform(CGAffineTransform(scaleX: -1.0, y: 1.0))
		}
		
		return videoPreviewLayer
	}
	
	func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)
	{
		if let metadataObject = metadataObjects.first
		{
			guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else
			{
				return
			}
			guard let code = readableObject.stringValue else
			{
				return
			}
			
//			print(code)
			self.delegate?.cameraDidQRCodeDetect(camera: self, code: code)
		}
	}
	
	private func captureDeviceInput() -> AVCaptureDeviceInput?
	{
		var position = AVCaptureDevice.Position.back
		if (self.isFront)
		{
			position = AVCaptureDevice.Position.front
		}
		
		guard let captureDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
														  for: AVMediaType.video,
														  position: position) else
		{
			print("ERROR: Missing camera.")
			return nil
		}
		
		let deviceInput = try? AVCaptureDeviceInput(device: captureDevice)
		return deviceInput
	}
	

}


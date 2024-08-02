//
//   DiagnosisViewController.swift
//  friendme
//
//  Created by ichinose-PC on 2024/07/23.
//

import Foundation
import SwiftUI
class DiagnosisViewController: UIViewController
{
	@IBOutlet weak var circleView: CircleView!
	
	@IBOutlet weak var talkingSegmentedControl: UISegmentedControl!
	@IBOutlet weak var romantistSegmentedControl: CustomSegmentedControl!
	@IBOutlet weak var lookafterSegmentedControl: CustomSegmentedControl!
	@IBOutlet weak var seriousSegmentedControl: CustomSegmentedControl!
	@IBOutlet weak var mypaceSegmentedControl: CustomSegmentedControl!
	
	var createdCharaType:CharaType?
	var friendName:String?
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		self.circleView.isSelected = true
    }
	
	@IBAction func nextBtnAction(_ sender: Any)
	{
		var charas = [CharaType]()
		
		if (self.talkingSegmentedControl.selectedSegmentIndex == 0)
		{
			charas.append(.Penguin)
		}
		else
		{
			charas.append(.Shimaenaga)
		}

		if (self.romantistSegmentedControl.selectedSegmentIndex == 0)
		{
			charas.append(.Penguin)
		}
		else
		{
			charas.append(.Rabbit)
		}

		if (self.lookafterSegmentedControl.selectedSegmentIndex == 0)
		{
			charas.append(.Cat)
		}
		else
		{
			charas.append(.Rabbit)
		}

		if (self.seriousSegmentedControl.selectedSegmentIndex == 0)
		{
			charas.append(.Shimaenaga)
		}
		else
		{
			charas.append(.Mouse)
		}

		if (self.mypaceSegmentedControl.selectedSegmentIndex == 0)
		{
			charas.append(.Mouse)
		}
		else
		{
			charas.append(.Cat)
		}
		
		// ランダムに選択する
		self.createdCharaType = charas.randomElement()
		
		self.performSegue(withIdentifier: "toName", sender: self)
	}
	
	@IBAction func backBtnAction(_ sender: Any)
	{
		self.dismiss(animated: true)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		guard let charaType = self.createdCharaType else { return }
		
		let nextViewController = segue.destination as? NamingViewController
		nextViewController?.charaType = charaType
		nextViewController?.friendName = self.friendName
	}
}

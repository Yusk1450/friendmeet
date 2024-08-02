//
//  DeadViewController.swift
//  friendme
//
//  Created by ISHIGO Yusuke on 2024/07/29.
//

import UIKit

class DeadViewController: UIViewController
{
	var pet:Pet?
	
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var charaImg: UIImageView!
	@IBOutlet weak var textView: UITextView!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

		if let petName = self.pet?.name,
		   let charaType = self.pet?.charaType
		{
			self.titleLbl.text = "\(petName)は亡くなりました"
			self.charaImg.image = Pet.getCharaImage(charaType: charaType)
			
			self.textView.text = self.textView.text.replacingOccurrences(of: "ペットの名前", with: petName)
		}
    }
	
	@IBAction func backBtnAction(_ sender: Any)
	{
		self.dismiss(animated: true)
	}
	

}

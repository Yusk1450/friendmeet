//
//  ViewController.swift
//  friendme
//
//  Created by ichinose-PC on 2024/07/20.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
	{
        super.viewDidLoad()
        
    }
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		
		if (!ShareData.shared.isFirst)
		{
			self.performSegue(withIdentifier: "toHome", sender: self)
		}
	}

    @IBAction func StartButton(_ sender: Any)
	{
//		if (ShareData.shared.isFirst)
//		{
//        }
//        else
//		{
//			self.performSegue(withIdentifier: "toHome", sender: self)
//        }
		self.performSegue(withIdentifier: "toFirst", sender: self)
	}
}


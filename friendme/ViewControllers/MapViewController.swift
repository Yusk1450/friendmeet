//
//  MapViewController.swift
//  friendme
//
//  Created by ISHIGO Yusuke on 2024/08/31.
//

import UIKit
import MapKit

class MapViewController: UIViewController
{
	@IBOutlet weak var mapView: MKMapView!
	
	var achievementCoordinate:CLLocationCoordinate2D?

    override func viewDidLoad()
	{
		super.viewDidLoad()
		
		if let achievementCoordinate = self.achievementCoordinate
		{
			self.mapView.setRegion(
				MKCoordinateRegion(center: achievementCoordinate,
								   span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)),
									animated: true)

			let annotation = MKPointAnnotation()
			annotation.coordinate = achievementCoordinate
			self.mapView.addAnnotation(annotation)
		}
		
	}
	
	@IBAction func backBtnAction(_ sender: Any)
	{
		self.dismiss(animated: true)
	}

}

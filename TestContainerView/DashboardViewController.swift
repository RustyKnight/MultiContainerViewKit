//
//  MainViewController.swift
//  TestContainerView
//
//  Created by Shane Whitehead on 28/4/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import UIKit
import PathwayKit

class DashboardViewController: UIViewController, DestinationViewController {
	
	@IBOutlet weak var tabButton: UIButton!

	var hubController: PathwayRouter?
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func navigateToTabView(_ sender: Any) {
		guard let hub = hubController else {
			fatalError("Hub controller is undefined")
		}
		hub.navigate(to: .tabController)
	}
}

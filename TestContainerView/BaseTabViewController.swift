//
//  BaseTabViewController.swift
//  TestContainerView
//
//  Created by Shane Whitehead on 29/4/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import UIKit
import PathwayKit

class BaseTabViewController: UIViewController {
	
	@IBOutlet var homeButton: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		homeButton.title = "Home"
		navigationItem.leftBarButtonItem = homeButton
	}

	func navigateHome() {
		// Navigation controller/TabBar controller
		guard let controller = parent?.parent as? DestinationViewController else {
			return
		}
		print("Go home")
		guard let hub = controller.hubController else {
			fatalError("HubController is unspecified")
		}
		hub.navigate(to: .navigationContoller)
	}
	
	@IBAction func home(_ sender: Any) {
		navigateHome()
	}
	
}

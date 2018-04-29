//
//  BaseTabViewController.swift
//  TestContainerView
//
//  Created by Shane Whitehead on 29/4/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import UIKit

class BaseTabViewController: UIViewController {
	
	@IBOutlet var homeButton: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		homeButton.title = "Home"
		navigationItem.leftBarButtonItem = homeButton
	}

	func navigateHome() {
		// Navigation controller/TabBar controller
		print("parent = \(parent)")
		print("parent.parent = \(parent?.parent)")
		guard let controller = parent?.parent as? EmbeddedViewController else {
			return
		}
		print("Go home")
		controller.embeddedNavigationController.navigate(to: .navigationContoller)
	}
	
	@IBAction func home(_ sender: Any) {
		navigateHome()
	}
	
}

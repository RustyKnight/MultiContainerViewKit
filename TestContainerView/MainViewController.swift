//
//  MainViewController.swift
//  TestContainerView
//
//  Created by Shane Whitehead on 28/4/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, EmbeddedViewController {
	
	@IBOutlet weak var tabButton: UIButton!

	var embeddedNavigationController: EmbeddedNavigationController!
	var viewController: UIViewController {
		return self
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func navigateToTabView(_ sender: Any) {
		embeddedNavigationController.navigate(to: .tabController)
	}
}

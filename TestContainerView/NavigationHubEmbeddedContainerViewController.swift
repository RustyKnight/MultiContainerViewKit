//
//  NavigationHubEmbeddedContainerViewController.swift
//  TestContainerView
//
//  Created by Shane Whitehead on 29/4/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import UIKit

protocol EmbeddedViewController {
	var embeddedNavigationController: EmbeddedNavigationController! { set get }
}

class NavigationHubEmbeddedContainerViewController: EmbeddedContainerViewController {
	override func viewDidLoad() {
//		var defaultController: EmbeddedContainerDestination!
//		var destinations: [EmbeddedContainerDestination] = []
		defaultController = .navigationContoller
		destinations = [.navigationContoller, .tabController];
		super.viewDidLoad()
	}
	
	override func willPresent(_ viewController: UIViewController) {
		
	}
	
	override func didPresent(_ viewController: UIViewController) {
		
	}
	
	override func willUnpresent(_ viewController: UIViewController) {
		
	}
	
	override func didUnpresent(_ viewController: UIViewController) {
	}
}

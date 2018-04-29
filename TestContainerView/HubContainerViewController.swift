//
//  NavigationHubEmbeddedContainerViewController.swift
//  TestContainerView
//
//  Created by Shane Whitehead on 29/4/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import UIKit
import PathwayKit

extension PathwayDestination {
	static let navigationContoller = PathwayDestination(identifier: "ToNavigationView")
	static let tabController = PathwayDestination(identifier: "ToTabView")
}

class HubContainerViewController: PathwayHubViewController {
	override func viewDidLoad() {
		defaultController = .navigationContoller
		destinations = [.navigationContoller, .tabController];
		super.viewDidLoad()
	}
	
	// Oppurtunity to pass information to the controller
	override func willPresent(_ viewController: UIViewController) {
		guard var viewController = viewController as? DestinationViewController else {
			return
		}
		viewController.hubController = self
	}
	
	override func didPresent(_ viewController: UIViewController) {
		
	}
	
	// Oppurtunity to grab information from the controller
	override func willUnpresent(_ viewController: UIViewController) {
		
	}
	
	override func didUnpresent(_ viewController: UIViewController) {
		guard var viewController = viewController as? DestinationViewController else {
			return
		}
		viewController.hubController = nil
	}
}

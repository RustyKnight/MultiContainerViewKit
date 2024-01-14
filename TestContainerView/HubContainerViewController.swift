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

extension PathwayRoute {
	static let navigationContoller = PathwayRoute(identifier: "ToNavigationView")
	static let tabController = PathwayRoute(identifier: "ToTabView")
}

class HubContainerViewController: PathwayHubViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
        defaultRoute = .navigationContoller
        avaliableRoutes = [.navigationContoller, .tabController]
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentInitialPathway()
    }
	
	// Oppurtunity to pass information to the controller
	override func willPresent(_ viewController: UIViewController) {
		guard let viewController = viewController as? DestinationViewController else {
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
		guard let viewController = viewController as? DestinationViewController else {
			return
		}
		viewController.hubController = nil
	}
}

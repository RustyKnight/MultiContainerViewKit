//
//  ContainerViewController.swift
//  TestContainerView
//
//  Created by Shane Whitehead on 28/4/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import UIKit

struct EmbeddedContainerDestination: Hashable {
	let identifier: String
}

protocol EmbeddedNavigationController {
	func navigate(to: EmbeddedContainerDestination)
}

extension EmbeddedContainerDestination {
	static let navigationContoller = EmbeddedContainerDestination(identifier: "ToNavigationView")
	static let tabController = EmbeddedContainerDestination(identifier: "ToTabView")
}

class EmbeddedContainerViewController: UIViewController, EmbeddedNavigationController {
	
	var defaultController: EmbeddedContainerDestination!
	var destinations: [EmbeddedContainerDestination] = []

//	var controllers: [EmbeddedContainerDestination: UIViewController] = [:]
	
	var currentDestination: EmbeddedContainerDestination!
//	var currentViewController: UIViewController!
	var transitionInProgress: Bool = false
	
	var destinationControllers: [EmbeddedContainerDestination: UIViewController] = [:]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		currentDestination = defaultController
		performSegue(withIdentifier: currentDestination.identifier, sender: self)
	}
	
	func destination(for segue: UIStoryboardSegue) -> EmbeddedContainerDestination? {
		for destination in destinations {
			guard destination.identifier == segue.identifier else {
				continue
			}
			return destination
		}
		return nil
	}
	
//	func register(from segue: UIStoryboardSegue) {
//		guard let destination = identifier(for: segue) else {
//			print("Warning: No destination for \(String(describing: segue.identifier))")
//			return
//		}
//		let destinationController = segue.destination
//		var presentingController = destinationController
//		if let controller = destinationController as? UINavigationController {
//			presentingController = controller.viewControllers[0]
//		}
////		guard controllers[destination] == nil else {
////			return
////		}
////		controllers[destination] = controller
////		controller.embeddedNavigationController = self
//	}
	
	func destinationController(_ viewController: UIViewController) -> UIViewController {
		guard let controller = viewController as? UINavigationController else {
			return viewController
		}
		return controller.viewControllers.last!
	}
	
	// This may not be the physical view controller presented, this is because it might
	// be presenting a UINavigationViewController instead, so instead, it will be
	// the first controller presented ... maybe should be the current :/
	// This is where implementations would have the ability to sync data to the
	// presenting controller
	func willPresent(_ viewController: UIViewController) {
	}
	
	func didPresent(_ viewController: UIViewController) {
	}
	
	func willUnpresent(_ viewController: UIViewController) {
	}
	
	func didUnpresent(_ viewController: UIViewController) {
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		guard let destination = destination(for: segue) else {
			fatalError("No destination found for \(String(describing: segue.identifier))")
		}
		if destinationControllers[destination] == nil {
			destinationControllers[destination] = segue.destination
		}

		if segue.identifier == defaultController.identifier && childViewControllers.count == 0 {
			guard let childView = segue.destination.view else {
				return
			}
			willPresent(destinationController(segue.destination))
			addChildViewController(segue.destination)
			childView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			childView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
			view.addSubview(childView)
			didPresent(destinationController(segue.destination))
		} else {
			swap(to: destination)
		}
	}
	
	func navigate(to: EmbeddedContainerDestination) {
		performSegue(withIdentifier: to.identifier, sender: self)
	}
	
	func swap(to: EmbeddedContainerDestination) {
		swap(from: currentDestination, to: to)
	}
	
	func swap(from: EmbeddedContainerDestination, to: EmbeddedContainerDestination) {
		guard from.identifier != to.identifier else {
			return
		}
		guard var currentViewController = destinationControllers[from] else {
			fatalError("Current view controller is undefined")
		}
		guard var destinationViewController = destinationControllers[to] else {
			fatalError("Destination view controller is undefined")
		}
		
		if let parent = currentViewController.parent, parent != self {
			currentViewController = parent
		}
		if let parent = destinationViewController.parent, parent != self {
			destinationViewController = parent
		}
//
//		if isNavigationController[from] ?? false {
//			if let parent = currentViewController.parent {
//				currentViewController = parent
//			} else {
//				fatalError("Attempt to find parent/navigation controller for \(from) failed with nil parent")
//			}
//		}
//		if isNavigationController[to] ?? false {
//			if let parent = destinationViewController.parent {
//				destinationViewController = parent
//			} else {
//				fatalError("Attempt to find parent/navigation controller for \(to) failed with nil parent")
//			}
//		}

		currentDestination = to
		swap(from: currentViewController, to: destinationViewController)
	}
	
	func swap(from fromViewController: UIViewController, to toViewController: UIViewController) {
		guard !transitionInProgress else {
			return
		}
		transitionInProgress = true
		toViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
		willUnpresent(destinationController(toViewController))
		fromViewController.willMove(toParentViewController: nil)
		
		willPresent(destinationController(toViewController))
		addChildViewController(toViewController)
		toViewController.willMove(toParentViewController: self)
		
		transition(from: fromViewController, to: toViewController, duration: 1.0, options: .transitionCrossDissolve, animations: {
			
		}) { (completed) in
			fromViewController.removeFromParentViewController()
			toViewController.didMove(toParentViewController: self)
			self.transitionInProgress = false
			self.didPresent(self.destinationController(fromViewController))
			self.didPresent(self.destinationController(toViewController))
		}
	}

}

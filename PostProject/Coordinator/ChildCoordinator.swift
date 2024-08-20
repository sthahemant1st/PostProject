//
//  ChildCoordinator.swift
//  PostUIKIT
//
//  Created by Hemant Shrestha on 18/08/2024.
//

import UIKit

/// All Child coordinators should conform to this protocol
protocol ChildCoordinator: Coordinator {
    /// Don't forget to make parentCoordinator weak in ChildCoordinator's implementation
    var parentCoordinator: ParentCoordinator? { get set }
    /**
     The body of this function should call `childDidFinish(_ child:)` on the parent coordinator to remove the child from parent's `childCoordinators`.
     */
    func coordinatorDidFinish()
    
    func navigationController(
        _ navigationController: UINavigationController,
        didRemove viewController: UIViewController,
        animated: Bool
    )
}

extension ChildCoordinator {
    func coordinatorDidFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}

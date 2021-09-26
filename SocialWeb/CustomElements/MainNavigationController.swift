//
//  MainNavigationController.swift
//  SocialWeb
//
//  Created by Никитка on 08.08.2021.
//

import UIKit

final class MainNavigationController: UINavigationController {

    let transition = InteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension MainNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return transition.isStarted ? transition : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            if navigationController.viewControllers.first != toVC {
                transition.viewController = toVC
            }
            return PopAnimator()
        case .push:
            transition.viewController = toVC
            return PushAnimator()
        default:
            return nil
        }
    }
}

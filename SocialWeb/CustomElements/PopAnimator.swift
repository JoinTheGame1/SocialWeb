//
//  PopAnimator.swift
//  SocialWeb
//
//  Created by Никитка on 08.08.2021.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceController = transitionContext.viewController(forKey: .from) else { return }
        guard let destinationController = transitionContext.viewController(forKey: .to) else { return }
        
        let containerViewFrame = transitionContext.containerView.frame
        let sourceControllerTargetFrame = CGRect(x: containerViewFrame.width,
                                                 y: 0,
                                                 width: sourceController.view.frame.width,
                                                 height: sourceController.view.frame.height)
        
        destinationController.view.frame = containerViewFrame
        destinationController.view.transform = CGAffineTransform(translationX: -containerViewFrame.width, y: 0)
        sourceController.view.frame = containerViewFrame
        
        transitionContext.containerView.addSubview(destinationController.view)
        transitionContext.containerView.sendSubviewToBack(destinationController.view)
        
        UIView.animate(
            withDuration: self.duration,
            animations: {
                sourceController.view.frame = sourceControllerTargetFrame
                destinationController.view.transform = .identity
            }) { (isComplete)  in
            if isComplete && !transitionContext.transitionWasCancelled {
                sourceController.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destinationController.view.transform = .identity
            }
            
            transitionContext.completeTransition(isComplete && !transitionContext.transitionWasCancelled)
        }
    }
}

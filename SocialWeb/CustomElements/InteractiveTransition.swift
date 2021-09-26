//
//  InteractiveTransition.swift
//  SocialWeb
//
//  Created by Никитка on 08.08.2021.
//

import UIKit

class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(gesture(_:)))
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }
    
    var isStarted: Bool = false
    private var shouldFinish: Bool = false
    
    @objc func gesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.isStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view).x
            let relative = translation / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relative))
            
            self.shouldFinish = progress > 0.4
            update(progress)
        case .ended:
            self.isStarted = false
            self.shouldFinish ? finish() : cancel()
        case .cancelled:
            self.isStarted = false
            cancel()
        @unknown default:
            return
        }
    }
}

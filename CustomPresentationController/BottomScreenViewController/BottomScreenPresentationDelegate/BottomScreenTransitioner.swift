//
//  AAPLOverlayTransitioner.swift
//  LookInside_Swift
//
//  Created by Seyed Samad Gholamzadeh on 7/18/18.
//  Copyright © 2018 Seyed Samad Gholamzadeh. All rights reserved.
//

import UIKit

class BottomScreenTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
	
	var size: CGSize?
	
	var animationController: BottomScreenAnimatedTransitioning {
		let animationController = BottomScreenAnimatedTransitioning()
		return animationController
	}
    	
	func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		let pc = BottomScreenPresentationController(presentedViewController: presented, presenting: presenting)
		pc.size = self.size
		return pc
	}

	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		let animationController = self.animationController
		animationController.isPresentation = true
		return animationController
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		let animationController = self.animationController
		animationController.isPresentation = false
		return animationController
	}
}

class BottomScreenAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
	
	var isPresentation: Bool!

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.5
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		
		let fromVC = transitionContext.viewController(forKey: .from)
		let toVC = transitionContext.viewController(forKey: .to)
		
		let fromView = fromVC?.view
		let toView = toVC?.view
		
		let containerView = transitionContext.containerView
		
		let isPresentation = self.isPresentation!
		
		if isPresentation {
            containerView.addSubview(fromView!)
			containerView.addSubview(toView!)
		}
		
		let animatingVC = isPresentation ? toVC : fromVC
		let animatingView = animatingVC?.view
		
		let appearedFrame = transitionContext.finalFrame(for: animatingVC!)
		var dismissedFrame = appearedFrame
        
		dismissedFrame.origin.y += 3*dismissedFrame.size.height
		
		let initialFrame = isPresentation ? dismissedFrame : appearedFrame;
		let finalFrame = isPresentation ? appearedFrame : dismissedFrame;

		animatingView?.frame = initialFrame
		
		UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 300.0, initialSpringVelocity: 5.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
			animatingView?.frame = finalFrame
		}) { (finished) in
			
			if !self.isPresentation {
				fromView?.removeFromSuperview()
                containerView.superview?.addSubview(toView!)
			}
			
			transitionContext.completeTransition(true)
		}
	}
	
}


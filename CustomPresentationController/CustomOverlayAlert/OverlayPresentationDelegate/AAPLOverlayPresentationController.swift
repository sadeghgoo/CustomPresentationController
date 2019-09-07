//
//  AAPLOverlayPresentationController.swift
//  LookInside_Swift
//
//  Created by Seyed Samad Gholamzadeh on 7/18/18.
//  Copyright © 2018 Seyed Samad Gholamzadeh. All rights reserved.
//

import UIKit

class AAPLOverlayPresentationController: UIPresentationController {
	
	var dismissByTapDimmingView: Bool = true
	
	var dimmingView: UIView!
	var size: CGSize?
	
	var dismissCompletion: (() -> Void)?

	override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
		super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		
	}
	
	override func presentationTransitionWillBegin() {
		let presentedViewController = self.presentedViewController

		
		if presentedViewController.transitionCoordinator != nil {
			presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (context) in
			}, completion: nil)
		}
		else {
		}
	}
	
	override func dismissalTransitionWillBegin() {
		let presentedViewController = self.presentedViewController

		if presentedViewController.transitionCoordinator != nil {
			presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (context) in
			}, completion: nil)
		}
		else {
		}
	}
	
	override var adaptivePresentationStyle: UIModalPresentationStyle {
		return .overFullScreen
	}
	
	override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
		let width = floor(parentSize.width * 0.9)
        let height = CGFloat(84)

		return self.size ?? CGSize(width: width, height: height)
	}
	
	override func containerViewWillLayoutSubviews() {
		self.presentedView?.frame = self.frameOfPresentedViewInContainerView
	}
	
	override var shouldPresentInFullscreen: Bool {
		return true
	}
	
	override var frameOfPresentedViewInContainerView: CGRect {
		var presentedViewFrame = CGRect.zero
		let containerBounds = self.containerView!.bounds
		presentedViewFrame.size = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerBounds.size)
		presentedViewFrame.origin.x = (containerBounds.size.width - presentedViewFrame.size.width)/2
        presentedViewFrame.origin.y =  (containerBounds.size.height - presentedViewFrame.size.height) - 44
       print(containerBounds.size.height)
		return presentedViewFrame
	}
	
	
	
	@objc func dimmingViewTapped(_ gesture: UIGestureRecognizer) {
    
		if gesture.state == .recognized {
			if self.dismissByTapDimmingView {
				self.dismissCompletion?()
				self.presentedViewController.dismiss(animated: true, completion: nil)
			}
		}
	}
}

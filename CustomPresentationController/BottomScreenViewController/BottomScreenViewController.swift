//
//  BottomScreenViewController.swift
//  CustomPresentationController
//
//  Created by sadegh on 9/6/19.
//  Copyright © 2019 sadegh. All rights reserved.
//

import UIKit

class BottomScreenViewController: UIViewController {


    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var viewStatusLabel: UILabel!
    @IBOutlet weak var viewMainLabel: UILabel!
    
    var transitionDelegate: UIViewControllerTransitioningDelegate!


    var originY = CGFloat()

    init(viewTitle:String,viewStatusLabel:String,viewMainLabel:String) {
        
        super.init(nibName: "BottomScreenViewController", bundle: nil)
        self.initialConfig()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.viewMainLabel.text = viewMainLabel
            self.viewStatusLabel.text = viewStatusLabel
            self.viewTitle.text = viewTitle
        }
      
        
    }
    func initialConfig(){
        
        let transitionDelegate = BottomScreenTransitioningDelegate()
        self.transitionDelegate = transitionDelegate
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitionDelegate
        
        (self.presentationController as? BottomScreenPresentationController)?.dismissByTapDimmingView = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.cornerRadius = 16
        self.view.clipsToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        originY = self.view.frame.origin.y

    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func moveDown() {
        UIView.animate(withDuration: 0.3) {
            
            self.view.frame.origin.y = UIScreen.main.bounds.height - self.view.bounds.height - (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0) - 2
    
        }
    }
    
    func moveUp() {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y  = self.originY

        }
    }
}

//
//  BottomScreenViewController.swift
//  CustomPresentationController
//
//  Created by sadegh on 9/6/19.
//  Copyright © 2019 sadegh. All rights reserved.
//

import UIKit

class BottomScreenViewController: UIViewController {


    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var viewStatusLabel: UILabel!
    @IBOutlet weak var viewMainLabel: UILabel!
    
    private var viewMainlabelText:String!
    private var viewStatusLabeltext:String!
    private var viewTitleText:String!


    var transitionDelegate: UIViewControllerTransitioningDelegate!


    var originY = CGFloat()

    init(viewTitle:String,viewStatusLabel:String,viewMainLabel:String) {
        
        super.init(nibName: "BottomScreenViewController", bundle: nil)
        
        self.initialConfig()
        
        self.viewMainlabelText = viewMainLabel
        self.viewTitleText = viewTitle
        self.viewStatusLabeltext = viewStatusLabel

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
        
        
        self.viewMainLabel.text = viewMainlabelText
        self.viewStatusLabel.text = viewStatusLabeltext
        self.viewTitle.text = viewTitleText
       
        self.makeShadowView()
        
        self.view.isUserInteractionEnabled = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        originY = self.view.frame.origin.y
    
    }
  
    func makeShadowView(){
     
        
        self.view.setGradientBackground(colorOne: UIColor(white: 1, alpha: 0), colorTwo:UIColor(white: 1, alpha: 0.5), colorThree:UIColor(white: 1, alpha: 1) )
        
        self.purpleView.layer.shadowColor = UIColor.black.cgColor
        self.purpleView.layer.shadowRadius = 16
        self.purpleView.layer.shadowOffset = CGSize(width: 0, height: 12)
        self.purpleView.layer.shadowOpacity = 0.4
        
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func moveDown() {
        UIView.animate(withDuration: 0.3) {
        
            self.view.frame.origin.y = UIScreen.main.bounds.height + 80
        }
    }
    
    func moveUp() {
        UIView.animate(withDuration: 0.3) {
           
            self.view.frame.origin.y  = self.originY
            

        }
    }
}

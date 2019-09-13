//
//  BottomScreenViewController.swift
//  CustomPresentationController
//
//  Created by sadegh on 9/6/19.
//  Copyright © 2019 sadegh. All rights reserved.
//

import UIKit

protocol ButtonActionDelegate:class{
    
    func buttonTapped()
}

class BottomScreenViewController: UIViewController {

    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var viewStatusLabel: UILabel!
    @IBOutlet weak var viewMainLabel: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    
    private var viewMainlabelText:String!
    private var viewStatusLabeltext:String!
    private var viewTitleText:String!
    
    weak var delegate:ButtonActionDelegate?
    
    private var lastOffset:CGFloat!
    private var currentOffset:CGFloat!
    
    var isViewUp:Bool = true
    
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
        

        if let view = view as? BottomScreenView {
            view.interactingView = purpleView
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        originY = self.view.frame.origin.y
    
    }
    
    
  
    func makeShadowView(){
     
       self.gradientView.setGradientBackground(colorOne: UIColor(white: 1, alpha: 0), colorTwo:UIColor(white: 1, alpha: 0.5), colorThree:UIColor(white: 1, alpha: 1) )
        
        self.purpleView.layer.shadowColor = UIColor.black.cgColor
        self.purpleView.layer.shadowRadius = 16
        self.purpleView.layer.shadowOffset = CGSize(width: 0, height: 12)
        
        self.purpleView.layer.shadowOpacity = 0.4
        
    }
    
    func viewStatus(in scrollView:UIScrollView) {

        self.currentOffset = scrollView.contentOffset.y

        let offsetSubtraction = abs(self.lastOffset - self.currentOffset)

        let isScrollUp = scrollView.contentOffset.y > self.lastOffset

        let isScrollDown  = scrollView.contentOffset.y < self.lastOffset

        if !isViewUp && isScrollDown {

            self.moveUp()
            isViewUp = true
            print("move up was called")
        }

        if offsetSubtraction >= UIScreen.main.bounds.height / 9  {

            if isViewUp && isScrollUp {

                self.moveDown()
                isViewUp = false
                print("move down was called")

            }
        }
    }
    
    func setLastOffset(last Offset:CGFloat){
        
        self.lastOffset = Offset
        
    }
   
    @IBAction func dismissAction(_ sender: UIButton) {
        
       self.delegate?.buttonTapped()
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

class BottomScreenView:UIView{
    weak var interactingView: UIView?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        guard let interactingView = interactingView else {
            return super.hitTest(point, with: event)
        }
        
        if interactingView.point(inside: interactingView.convert(point, from: self), with: event) {
            return super.hitTest(point, with: event)
        }
        
        return nil
    }
}

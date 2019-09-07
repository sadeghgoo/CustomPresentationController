//
//  CustomAlertControllerViewController.swift
//  ESL
//
//  Created by Seyed Samad Gholamzadeh on 8/20/19.
//  Copyright © 2019 Seyed Samad Gholamzadeh. All rights reserved.
//

import UIKit

class CustomOverlayAlertController: UIViewController {
    
    private let buttonsHeight: CGFloat = 32
    private let viewBottomEdgeInset: CGFloat = 32
    private let viewLeadingTrainlingInset: CGFloat = 40
    private let alertTitle: String?
    private let alertMessage: String?
    
    
    var transitionDelegate: UIViewControllerTransitioningDelegate!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    required init(title: String?, message: String?) {
        self.alertTitle = title
        self.alertMessage = message
        
        super.init(nibName: "CustomOverlayAlert", bundle: nil)
        
        self.initialConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialConfig() {
        
        let transitionDelegate = AAPLOverlayTransitioningDelegate()
        self.transitionDelegate = transitionDelegate
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitionDelegate
        
        (self.presentationController as? AAPLOverlayPresentationController)?.dismissByTapDimmingView = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 16
        self.view.clipsToBounds = true
        self.view.backgroundColor = #colorLiteral(red: 0.2577766478, green: 0.3017920852, blue: 0.7646248341, alpha: 1)
        
        self.configTitleLabel()
        self.configMessageLabel()

    }
    
    func configTitleLabel() {
        if self.alertTitle != nil {
            self.labelsStackView.isHidden = false
            self.titleLabel.isHidden = false
            self.titleLabel.text = self.alertTitle
        }
    }
    
    func configMessageLabel() {
        if self.alertMessage != nil {
            self.labelsStackView.isHidden = false
            self.messageLabel.isHidden = false
            self.messageLabel.text = self.alertMessage
        }
    }
    
    
    
    
}


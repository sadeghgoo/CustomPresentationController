//
//  ViewController.swift
//  CustomPresentationController
//
//  Created by sadegh on 9/6/19.
//  Copyright © 2019 sadegh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var presentedVc: BottomScreenViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func presentAction(_ sender: UIButton) {
        //let viewController = BottomScreenViewController()
       //
    }

    @IBAction func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
 
    @IBAction func moveDownAction(_ sender: UIButton) {
        self.presentedVc.moveDown()
    }
    
    @IBAction func moveUpAction(_ sender: UIButton) {

        self.presentedVc.moveUp()
    }

    
}



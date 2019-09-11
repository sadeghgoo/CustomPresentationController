//
//  ContentTablview.swift
//  CustomPresentationControllerFix
//
//  Created by sadegh on 9/7/19.
//  Copyright © 2019 sadegh. All rights reserved.
//

import UIKit

var isActionOpened:Bool = false

class ContentTablview: UITableViewController {
    
    var presentedVc: BottomScreenViewController?
    
    var lastOffset = CGFloat()
    var currentOffset = CGFloat()
    var isViewUp:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 400
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !isActionOpened {
            isActionOpened = true
            self.isViewUp = true
            let viewController = BottomScreenViewController(viewTitle: "Unit Sadegh", viewStatusLabel: "Compeleted", viewMainLabel: "\(indexPath.row)")
            self.presentedVc = viewController
            self.present(viewController, animated: true, completion: nil)
           
        }
        
    }
    
    func viewStatus(scrollView:UIScrollView) {
        

        let offsetSubtraction = abs(self.lastOffset - self.currentOffset)
        
        let isScrollUp = scrollView.contentOffset.y > self.lastOffset
        
        let isScrollDown  = scrollView.contentOffset.y < self.lastOffset
        
        if offsetSubtraction >= UIScreen.main.bounds.height / 6  {
            
            if isViewUp && isScrollUp {
                
                self.presentedVc?.moveDown()
                self.isViewUp = false
                print("move down was called")
                
            }else if !isViewUp && isScrollDown {
                
                self.presentedVc?.moveUp()
                self.isViewUp = true
                print("move up was called")
                
            }
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.lastOffset = scrollView.contentOffset.y
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.currentOffset = scrollView.contentOffset.y
        viewStatus(scrollView: scrollView)
        
    }
    
}


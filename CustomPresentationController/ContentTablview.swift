//
//  ContentTablview.swift
//  CustomPresentationController
//
//  Created by sadegh on 9/7/19.
//  Copyright © 2019 sadegh. All rights reserved.
//

import UIKit

class ContentTablview: UITableViewController {
    
    var presentedVc: BottomScreenViewController!
    
    var isActionmenuOpened:Bool = false
    
    var lastOffset = CGFloat()
    var currentOffset = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = BottomScreenViewController()
        self.presentedVc = viewController
        self.present(viewController, animated: true, completion: nil)
        self.isActionmenuOpened = true
    }
    
    func viewStatus(scrollView:UIScrollView){
        
        
        let isScrollUp = scrollView.contentOffset.y > self.lastOffset
        let isScrollDown  = scrollView.contentOffset.y < self.lastOffset
        
        let offsetSubtraction = abs(lastOffset + currentOffset)
                            
        if offsetSubtraction >= UIScreen.main.bounds.height / 7 {
                  
            if isActionmenuOpened{
                if isScrollUp {
                    self.presentedVc.moveDown()

                }else if isScrollDown{
                    self.presentedVc.moveUp()

                }
            }
        }
    }

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.lastOffset = scrollView.contentOffset.y

        //viewStatus(scrollView: scrollView)

       print("~~ this is last offset scrollViewWillBeginDragging \(self.lastOffset)")
        print(" - -- - - - - - - -- - - - - - -- ")

    }
    override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        self.lastOffset = scrollView.contentOffset.y
        //viewStatus(scrollView: scrollView)
        print("~~ this is last offset scrollViewWillBeginDecelerating \(self.lastOffset)")
        print(" - -- - - - - - - -- - - - - - -- ")


    }
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        self.currentOffset = scrollView.contentOffset.y
        //viewStatus(scrollView: scrollView)
        
        print("~~ this is current offset scrollViewDidEndDragging \(self.currentOffset)")
        print(" - -- - - - - - - -- - - - - - -- ")

    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.currentOffset = scrollView.contentOffset.y
        
        //viewStatus(scrollView: scrollView)
        print("~~ this is current offset end Decelerating  \(self.currentOffset)")
        print(" - -- - - - - - - -- - - - - - -- ")

    }
    
    
    
    
}

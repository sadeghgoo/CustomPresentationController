//
//  ContentTablview.swift
//  CustomPresentationControllerFix
//
//  Created by sadegh on 9/7/19.
//  Copyright © 2019 sadegh. All rights reserved.
//

import UIKit


class ContentTablview: UITableViewController {
    
    var presentedVc: BottomScreenViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let viewController = BottomScreenViewController(viewTitle: "Unit Sadegh", viewStatusLabel: "Compeleted", viewMainLabel: "\(indexPath.row)")
        
            self.presentedVc = viewController
        
            self.present(viewController, animated: true, completion: nil)
           
    }

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.presentedVc?.setLastOffset(last: scrollView.contentOffset.y)
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.presentedVc?.viewStatus(in: scrollView)

    }
    
}


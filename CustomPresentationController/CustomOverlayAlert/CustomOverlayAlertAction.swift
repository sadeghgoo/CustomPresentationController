//
//  CustomAlertAction.swift
//  ESL
//
//  Created by Seyed Samad Gholamzadeh on 8/20/19.
//  Copyright © 2019 Seyed Samad Gholamzadeh. All rights reserved.
//

import UIKit

final class CustomOverlayAlertAction: UIControl {

    public enum Style : Int {
        
        case `default`
        
        case cancel
        
        case destructive
    }

    var title: String?
    let style: Style
    var handler: ((CustomOverlayAlertAction) -> Void)?

    public required init(title: String?, style: CustomOverlayAlertAction.Style, handler: ((CustomOverlayAlertAction) -> Void)?) {
        
        self.title = title
        self.style = style
        self.handler = handler
        super.init(frame: CGRect.zero)
        self.backgroundColor = .red
        self.layer.cornerRadius = 25
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

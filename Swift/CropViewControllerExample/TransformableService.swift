//
//  TransformableService.swift
//  CropViewController
//
//  Created by Taras Chernysh on 10/9/19.
//  Copyright © 2019 Tim Oliver. All rights reserved.
//

import UIKit

public class TransformableService {
    static let shared = TransformableService()
    private init() {}
    
    var resetTapped: (() -> Void)?
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedResetButton), for: .touchUpInside)
        return button
    }()
    
    /// Resets object of TOCropViewController class as if
    /// user pressed reset button in the bottom bar themself
    @objc func tappedResetButton() {
        resetTapped?()
    }
    
    /// init UIColor from hex string
    func hexStringToUIColor(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func setupToolbar(inCropVC vc: CropViewController) {
        
        let yellow = TransformableService.shared.hexStringToUIColor(hex: "#CBB147")
        let white = TransformableService.shared.hexStringToUIColor(hex: "#FFFFFF")
        vc.toolbar.cancelTextButton.setTitleColor(yellow, for: .normal)
        vc.toolbar.doneTextButton.setTitleColor(white, for: .normal)
        
        vc.doneButtonTitle = "Cancel"
        vc.cancelButtonTitle = "Done"
    }
    
    
    func addConstraintToResetButton(inView view: UIView) {
        view.addSubview(resetButton)
        
        let topConstraint = NSLayoutConstraint(item: resetButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 12)
        let rightConstraint = NSLayoutConstraint(item: resetButton,
                                                 attribute: .leading,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .leading,
                                                 multiplier: 1,
                                                 constant: 16)
        let heightConstraint = NSLayoutConstraint(item: resetButton,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 20)
        
        view.addConstraints([topConstraint, rightConstraint, heightConstraint])
    }
}


//
//  HHTabButton.swift
//  WHTabView
//
//  Created by natsu on 2020/5/15.
//  Copyright © 2020 natsu. All rights reserved.
//

import UIKit

class HHTabButton: UIButton {

    static func button(tabStyle style: HHTabStyle) -> HHTabButton {
        
        let btn = HHTabButton(type: .custom)
        
        btn.setAttributedTitle(style.attributedTitle, for: .normal)
        btn.setTitle(style.title, for: .normal)
        btn.setTitleColor(style.titleColor, for: .normal)
        btn.setTitleColor(style.selectedTitleColor, for: .selected)
        btn.setTitleColor(style.highlightTitleColor, for: .highlighted)
        if let font = style.font {
            btn.titleLabel?.font = font
        } else if style.fontSize > 0 {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: style.fontSize)
        }
        btn.titleLabel?.textAlignment = style.textAlignment
        
        btn.backgroundColor = style.backgroundColor
        btn.setBackgroundImage(style.backgroundImage, for: .normal)
        btn.setImage(style.image, for: .normal)
        btn.setImage(style.selectedImage, for: .selected)
        
        btn.isUserInteractionEnabled = style.enable
        btn.titleLabel?.adjustsFontSizeToFitWidth = style.adjustedFont
        btn.contentEdgeInsets = style.contentEdgeInsets
        
        
        
        return btn
    }

}

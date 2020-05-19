//
//  HHTabStyle.swift
//  WHTabView
//
//  Created by natsu on 2020/5/15.
//  Copyright © 2020 natsu. All rights reserved.
//

import UIKit

class HHTabStyle {
    //内容边距，默认zero
    var contentEdgeInsets: UIEdgeInsets = .zero
    //富标题
    var attributedTitle: NSAttributedString?
    //标题
    var title: String?
    //标题颜色，默认深色
    var titleColor: UIColor = UIColor.darkText
    //选中颜色
    var selectedTitleColor: UIColor?
    //高亮颜色
    var highlightTitleColor: UIColor?
    //图片
    var image: UIImage?
    //选择图片
    var selectedImage: UIImage?
    //背景图片
    var backgroundImage: UIImage?
    //背景色
    var backgroundColor: UIColor = UIColor.white
    //字体
    var font: UIFont?
    //默认字体大小15.0
    var fontSize: CGFloat = 15.0
    //默认可以点击
    var enable: Bool = true
    //字体自动适应大小
    var adjustedFont: Bool = true
    //字体对齐方式
    var textAlignment: NSTextAlignment = .center
    
    init() {
        
    }
    
    init(_ title: String) {
        self.title = title
    }
    
    init(_ tabStyle: HHTabStyle) {
        contentEdgeInsets = tabStyle.contentEdgeInsets
        attributedTitle = tabStyle.attributedTitle
        title = tabStyle.title
        titleColor = tabStyle.titleColor
        selectedTitleColor = tabStyle.selectedTitleColor
        highlightTitleColor = tabStyle.highlightTitleColor
        image = tabStyle.image
        selectedImage = tabStyle.selectedImage
        backgroundImage = tabStyle.backgroundImage
        backgroundColor = tabStyle.backgroundColor
        font = tabStyle.font
        fontSize = tabStyle.fontSize
        enable = tabStyle.enable
        adjustedFont = tabStyle.adjustedFont
        textAlignment = tabStyle.textAlignment
    }
    
}

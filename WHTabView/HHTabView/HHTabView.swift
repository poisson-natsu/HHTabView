//
//  HHTabView.swift
//  WHTabView
//
//  Created by natsu on 2020/5/15.
//  Copyright © 2020 natsu. All rights reserved.
//

import UIKit

protocol HHTabViewDelegate: NSObjectProtocol {
    
    func tabview(_ tabview:HHTabView, didTapTabAtIndex index: Int)
    
    
}

class HHTabView: UIView {
    
    private let bottomLineHeight:CGFloat = 3
    private let leftRightPadding:CGFloat = 20
    
    private var scrollView: UIScrollView?
    
    weak var delegate: HHTabViewDelegate?
    

    func createTabView(withTitles titles: [String], tabStyle: HHTabStyle) {
        self.titles = titles
        self.customTabStyle = tabStyle
        self.tabs.removeAll(keepingCapacity: true)
        for title in titles {
            let style = HHTabStyle(self.customTabStyle)
            style.title = title
            self.tabs.append(style)
        }
        createUI()
    }
    
    // Connect UIScrollView to HHTabView
    func registerScrollView(_ scrollView: UIScrollView) {
        self.scrollView = scrollView
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let scrollView = object as? UIScrollView {
            if let point = change?[NSKeyValueChangeKey.newKey] as? CGPoint {
                var frame = self.lineView.frame
                frame.origin.x = point.x/scrollView.bounds.size.width*(self.lineView.bounds.size.width+self.leftRightPadding*2)+self.leftRightPadding
                self.lineView.frame = frame
                self.currentIndex = Int.init(point.x/scrollView.bounds.size.width)
            }
        }
    }
    
    func createUI() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        for i in 0..<self.tabs.count {
            let button = HHTabButton.button(tabStyle: self.tabs[i])
            self.addSubview(button)
            button.addTarget(self, action: #selector(didSelectedTab(_:)), for: .touchUpInside)
        }
        self.addSubview(self.lineView)
        self.currentIndex = 0
    }
    
    var bottomLineViewColor: UIColor = UIColor.blue {
        
        willSet {
            assert(self.lineView.superview != nil, "[You'd like to call createTabView function first...]")
            self.lineView.backgroundColor = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let count = self.titles.count
        let width = self.bounds.size.width/CGFloat(integerLiteral: count)
        for i in 0..<count {
            if let btn = self.subviews[i] as? UIButton {
                btn.frame = CGRect(x: width*CGFloat(i), y: 0, width: width, height: self.bounds.size.height-bottomLineHeight)
            }
        }
        //bottom line view
        self.lineView.frame = bottomViewFrame()
    }
    
    @objc private func didSelectedTab(_ button: HHTabButton) {
        
        if let idx = self.subviews.firstIndex(of: button) {
            if idx == currentIndex {
                return
            }
            self.moveLine(idx)
        }
    }
    
    
    private var titles: [String] = []
    private(set) var currentIndex: Int = 0 {
        
        willSet {
            
            if let currentTab = self.subviews[newValue] as? HHTabButton {
                currentTab.isSelected = true
            }
            if currentIndex == newValue {
                return
            }
            if let lastTab = self.subviews[currentIndex] as? HHTabButton {
                lastTab.isSelected = false
            }
        }
    }
    
    private lazy var customTabStyle: HHTabStyle = {
        let style = HHTabStyle()
        let color = UIColor.init(red: 88/255.0, green: 105/255.0, blue: 129/255.0, alpha: 1)
        style.titleColor = color
        style.selectedTitleColor = color
        style.backgroundColor = UIColor.white
        return style
    }()
    
    private lazy var tabs: [HHTabStyle] = {
        let array = [HHTabStyle]()
        return array
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    private func bottomViewFrame() -> CGRect {
        if self.currentIndex >= self.subviews.count {
            return CGRect()
        }
        let currentBtn = self.subviews[self.currentIndex]
        return CGRect(x: currentBtn.frame.origin.x+leftRightPadding, y: currentBtn.bounds.size.height, width: currentBtn.bounds.size.width-2*leftRightPadding, height: bottomLineHeight)
    }
    
    func moveLine(_ index: Int) {
        currentIndex = index
        if let deleg = self.delegate {
            deleg.tabview(self, didTapTabAtIndex: currentIndex)
        }
        let frame = self.bottomViewFrame()
        UIView.animate(withDuration: 0.5) {
            self.lineView.frame = frame
        }
    }
    
    deinit {
        print("deinit")
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
        self.scrollView = nil
    }

}

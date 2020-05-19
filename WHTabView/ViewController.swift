//
//  ViewController.swift
//  WHTabView
//
//  Created by natsu on 2020/5/15.
//  Copyright © 2020 natsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HHTabViewDelegate {
    
    /// HHTabViewDelegate
    func tabview(_ tabview: HHTabView, didTapTabAtIndex index: Int) {
        print("now \(index) clicked.....")
    }
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 160, width: UIScreen.main.bounds.size.width, height: 200)
//        scrollView.frame = CGRect(x: 0, y: 160, width: 300, height: 200)
        scrollView.isPagingEnabled = true
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width*3, height: 200)
        
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        //构造HHTabView
        let tabView = HHTabView()
        tabView.delegate = self
        view.addSubview(tabView)
        tabView.frame = CGRect(x: 0, y: 80, width: self.view.bounds.size.width, height: 80)

        let tabStyle = HHTabStyle()
        tabStyle.selectedTitleColor = UIColor.blue
        tabStyle.backgroundColor = UIColor.yellow
        tabView.createTabView(withTitles: ["first", "second", "Third"], tabStyle: tabStyle)
        tabView.backgroundColor = UIColor.blue
        tabView.bottomLineViewColor = UIColor.red
        
        //构造UIScrollView
        self.view.addSubview(self.scrollView)
        for i in 0..<3 {
            let view = UIView()
            view.backgroundColor = UIColor.init(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 1)
            view.frame = CGRect(origin: CGPoint(x:CGFloat(i)*self.scrollView.bounds.size.width, y:0.0), size:self.scrollView.bounds.size)
            self.scrollView.addSubview(view)
        }

        //关联scrollview
        tabView.registerScrollView(self.scrollView)
        
        //返回按钮
        let btn = UIButton(type: .close)
        btn.frame = CGRect(x: 0, y: 40, width: 60, height: 40)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    @objc func back() {
        self.dismiss(animated: true) {
            
        }
    }

    deinit {
        print("ViewController deinit...")
    }

}


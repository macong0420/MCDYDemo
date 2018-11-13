//
//  PageTitleView.swift
//  MCDYDemo
//
//  Created by 马聪聪 on 2018/11/13.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {

    //MARK:- 定义属性
    private var titles : [String]
//    private var titleLabels :[UILabel]
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    //MARK:- 懒加载一个scrowview
    private lazy var scrowView : UIScrollView = {
        let scrowView = UIScrollView()
        scrowView.showsHorizontalScrollIndicator = false
        scrowView.scrollsToTop = false
        scrowView.bounces = false
        return scrowView
    }()
    
    //MARK:- 懒加载滑块
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //MARK:- 自定义构造函数
    
    
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:- 设置UI界面
extension PageTitleView {
    
    private func setupUI() {
        //1. 添加scrowview
        addSubview(scrowView)
        scrowView.frame = bounds
        
        //2.添加title对应的label
        setupLabels()
        
        //3. 添加底部划款和分割线
        setupBottomLineScrollLine()
        
    }
    
    private func setupLabels() {
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //1.创建label
            let label = UILabel()
            //2.设置属性
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.tag = index
            label.textAlignment = .center
            
            let labelX = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrowView.addSubview(label)
            titleLabels.append(label)
        }
        
    }
    
    private func setupBottomLineScrollLine() {
        //1.底部边线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.gray
        bottomLine.frame = CGRect(x: 0, y: frame.height-0.5, width: frame.width, height: 0.5)
        addSubview(bottomLine)
        
        //2.滑块
        scrowView.addSubview(scrollLine)
        guard let fristLabel = titleLabels.first else { return }
        fristLabel.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: fristLabel.frame.origin.x, y: frame.height-kScrollLineH, width: fristLabel.frame.width, height: kScrollLineH)
        
        
    }
}

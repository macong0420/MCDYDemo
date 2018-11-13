//
//  PageTitleView.swift
//  MCDYDemo
//
//  Created by 马聪聪 on 2018/11/13.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class { //定义成class 表示只有类能遵守这个代理
    ///代理方法一般以代理类名开头
    func pageTitleView(titleView: PageTitleView, selectIndex index : Int)
}

private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85,85,85) //元组 灰色色值
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255,125,0) //橙色

class PageTitleView: UIView {

    //MARK:- 定义属性
    private var titles : [String]
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    weak var delegate : PageTitleViewDelegate? //代理可选
    
    //保存titlelabel的下标
    private var cureentIndex : Int = 0;
    
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
            
            //给label添加手势
            //1.打开用户交互
            label.isUserInteractionEnabled = true
            //手势
            let tapG = UITapGestureRecognizer(target: self, action: #selector(self.titlelabelClick(tapG:)))
            label.addGestureRecognizer(tapG)
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

//MARK:- 监听手势点击
extension PageTitleView {
    //监听手势 需要添加关键字 @objc
    @objc private func titlelabelClick(tapG: UITapGestureRecognizer) {
        //拿到当前label
        guard let cureentLabel = tapG.view as? UILabel else {return}
        //上一个label
        if cureentLabel.tag == cureentIndex {
            return
        }
        let preLabel = titleLabels[cureentIndex]

        //更新cureentIndex值
        cureentIndex = cureentLabel.tag
        
        //更新颜色
        cureentLabel.textColor = UIColor.orange
        preLabel.textColor = UIColor.darkGray
        
        //滚动滑块位移
        let scrollLineX = CGFloat(cureentLabel.tag) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //设置代理 通知pagecontengView移动
        
        delegate?.pageTitleView(titleView: self, selectIndex: cureentIndex)
    }
}

//MARK:- 对f外方法
extension PageTitleView {
    func setProGress(progress: CGFloat, cureentIndex: Int, targetIndex: Int) {
        //1.取出label
        let cureentLable = titleLabels[cureentIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块滑动的逻辑
        let movetoX = targetLabel.frame.origin.x - cureentLable.frame.origin.x
        let moveX = movetoX * progress
        
        scrollLine.frame.origin.x = cureentLable.frame.origin.x + moveX
        
        //3,设置颜色渐变
        //设置颜色变化范围
        let colorDelta = (kSelectedColor.0-kNormalColor.0,kSelectedColor.1-kNormalColor.1,kSelectedColor.2-kNormalColor.2)
        cureentLable.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g:kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress, a: 1.0)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress, a: 1.0)
        
        self.cureentIndex = targetIndex
    }
}

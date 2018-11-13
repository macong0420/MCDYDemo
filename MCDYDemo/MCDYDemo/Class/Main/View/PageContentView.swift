//
//  PageContentView.swift
//  MCDYDemo
//
//  Created by 马聪聪 on 2018/11/13.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, cureentIndex: Int, targetIndex: Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    //MARK:- 定义属性
    private var childVcs: [UIViewController]
    ///weak 修饰只能修饰可选类型 所以后面添加一个问号
    private weak var parentVC: UIViewController?
    
    ///contentview 滑动的index
    private var startScorllX : CGFloat = 0;
    
    //点击 是否禁用 d滑动代理
    private var isForbitScrollDelegate : Bool = false
    
    weak var delegate : PageContentViewDelegate?
    
    //MARK:- 懒加载属性
    /// 闭包里面使用self最好也使用weak 否则有可能会出现循环引用
    ///闭包里的weak使用 [weak self] in
    private lazy var collectionView : UICollectionView = { [weak self] in
       //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal //水平滚动
        
        //2.创建collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
        
    }()
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentVC: UIViewController?) {
        self.childVcs = childVcs
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    
    private func setupUI() {
        //1.将所有子控制器添加到父控制器中
        for childvc in childVcs {
            parentVC?.addChild(childvc)
        }
        
        //2.添加UICollectionView 用于cell中存放控制器view
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}


//MARK:- 遵守UICollectionview协议
extension PageContentView : UICollectionViewDataSource {
    
    //数据源方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //g2.给cell设置内容
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

//MARK:- 遵守UIColectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    //滑动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startScorllX = scrollView.contentOffset.x
        isForbitScrollDelegate = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbitScrollDelegate {return}
        
        //定义所需数据
        var progress : CGFloat = 0
        var cureentIndex : Int = 0
        var targetIndex : Int = 0
        
        //判断左滑 还是 右滑
        let cureentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if cureentOffsetX > startScorllX { //左滑
            progress = cureentOffsetX / scrollViewW - floor((cureentOffsetX / scrollViewW))
            cureentIndex = Int(cureentOffsetX / scrollViewW)
            targetIndex = cureentIndex + 1
            //防止越界
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if cureentOffsetX - startScorllX == scrollViewW {
                progress = 1.0
                targetIndex = cureentIndex
            }
            
            
        } else { //右滑
            progress = 1 - (cureentOffsetX / scrollViewW - floor((cureentOffsetX / scrollViewW)))
            targetIndex = Int(cureentOffsetX / scrollViewW)
            cureentIndex = targetIndex + 1
            
            if cureentIndex >= childVcs.count {
                cureentIndex = childVcs.count - 1
            }
        }
        
        //MARK:- 将progress,cureentIndex,targetIndex 传递给 titleView
        delegate?.pageContentView(pageContentView: self, progress: progress, cureentIndex: cureentIndex, targetIndex: targetIndex)
        
    }
}

//MARK:- 公开的方法

extension PageContentView {
    //滚动contentview
    func setContentViewIndex(index: Int) {
        isForbitScrollDelegate = true
        let offsetX = CGFloat(index) * collectionView.frame.size.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
}

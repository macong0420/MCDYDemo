//
//  PageContentView.swift
//  MCDYDemo
//
//  Created by 马聪聪 on 2018/11/13.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    //MARK:- 定义属性
    private var childVcs: [UIViewController]
    private var parentVC: UIViewController
    
    //MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {
       //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal //水平滚动
        
        //2.创建collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
        
    }()
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentVC: UIViewController) {
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
            parentVC.addChild(childvc)
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

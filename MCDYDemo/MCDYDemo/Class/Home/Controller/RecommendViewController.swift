//
//  RecommendViewController.swift
//  MCDYDemo
//
//  Created by 马聪聪 on 2018/11/14.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

private let kMargin : CGFloat = 10
private let kNomalCellW : CGFloat = (kScreenW - kMargin * 3 ) / 2
private let kNomalCellH : CGFloat = kNomalCellW * 3 / 4
private let kPretyCellH : CGFloat = kNomalCellW * 4 / 3
private let kCellHeadrH : CGFloat = 50

private let kNomalCellID = "kNomalCellID"
private let kHeaderID = "kHeaderID"
private let kCollectionPretyCellID = "kCollectionPretyCellID"

class RecommendViewController: UIViewController {

    //MARK:- 懒加载
    private lazy var collectionView : UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNomalCellW, height: kNomalCellH)
        layout.minimumLineSpacing = 0 //item 行间距
        layout.minimumInteritemSpacing = kMargin //item 横向间距
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kCellHeadrH)
        //设置组内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
    
        let collectionView = UICollectionView(frame: self.view.bounds , collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        //设置collectionView的高度随父控件拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        ///注册cell
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNomalCellID)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNomalCellID)
        //
        collectionView.register(UINib(nibName: "CollectionPretyCell", bundle: nil), forCellWithReuseIdentifier: kCollectionPretyCellID)
        
        ///注册头view
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        //设置UI界面
        setupUI()
    }
}


//MARK:- 设置UI
extension RecommendViewController {
    private func setupUI() {
        view.addSubview(collectionView)
    }
}

//MARK:-UICollectionViewDataSource

extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionPretyCellID, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNomalCellID, for: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNomalCellW, height: kPretyCellH)
        } else {
            return CGSize(width: kNomalCellW, height: kNomalCellH)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath)
        return headerView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
}


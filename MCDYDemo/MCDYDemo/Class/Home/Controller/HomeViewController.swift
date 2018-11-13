//
//  HomeViewController.swift
//  MCDYDemo
//
//  Created by 马聪聪 on 2018/11/12.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

private let kTitleViewH = 40

class HomeViewController: UIViewController {

    //MARK:- 懒加载
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleFrame = CGRect(x: 0, y: kNavgationBarh+kStatusBarH, width: Int(kScreenW), height: kTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    //MARK:- 懒加载pageContenView
    private lazy var pageContentView : PageContentView = { [weak self] in
        let contenY : CGFloat = CGFloat(kStatusBarH + kNavgationBarh + kTitleViewH)
        let contenH : CGFloat = kScreenH - contenY
        let contenFrame = CGRect(x: 0, y: contenY, width: kScreenW, height: contenH)
        
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)), a: 1.0)
            childVcs.append(vc)
        }
        
        let pageContentView = PageContentView(frame: contenFrame, childVcs: childVcs, parentVC: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    //MARK:- 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI () {
        // 不要调整UIScrollview的内边距
        automaticallyAdjustsScrollViewInsets = false
        //MARK:- 设置导航栏
        setUpNavgationBarItem()
        //MARK:- 添加TitleView
        view.addSubview(pageTitleView)
        
        //MARK:- 添加contentPageView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setUpNavgationBarItem() {
        
        // logo
        let logoBtn = UIButton()
        logoBtn.setImage(UIImage(named: "cm_logo_capture"), for: .normal)
        logoBtn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoBtn)
        
        let size = CGSize(width: 40, height: 40)
        
        /*
        // 历史
        let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named: "cm_nav_history_white_HL"), for: .normal)
        historyBtn.setImage(UIImage(named: "cm_nav_history_white"), for: .highlighted)
        historyBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        let historyItem = UIBarButtonItem(customView: historyBtn)
        
        // 搜索
        let searchBtn = UIButton()
        searchBtn.setImage(UIImage(named: "cm_search_black_normal"), for: .normal)
        searchBtn.setImage(UIImage(named: "cm_search_black_pressed"), for: .highlighted)
        searchBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        let searchItem = UIBarButtonItem(customView: searchBtn)
        
        //二维码
        let qrcodeBtn = UIButton()
        qrcodeBtn.setImage(UIImage(named: "btn_qr_scan_normal"), for: .normal)
        qrcodeBtn.setImage(UIImage(named: "btn_qr_scan_selected"), for: .highlighted)
        qrcodeBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
        */
        
        //类方法调用
        /*
         let historyItem = UIBarButtonItem.createBatBtnItem(imageName: "cm_nav_history_white_HL", highlightName: "cm_nav_history_white", size: size)
         let searchItem = UIBarButtonItem.createBatBtnItem(imageName: "cm_search_black_normal", highlightName: "cm_search_black_normal", size: size)
         let qrcodeItem = UIBarButtonItem.createBatBtnItem(imageName: "btn_qr_scan_normal", highlightName: "btn_qr_scan_selected", size: size)
         */
        
        //便利构造函数
        let historyItem = UIBarButtonItem(imageName: "cm_nav_history_white_HL", highlightName: "cm_nav_history_white", size: size)
        let searchItem = UIBarButtonItem(imageName: "cm_search_black_normal", highlightName: "cm_search_black_pressed", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "btn_qr_scan_normal", highlightName: "btn_qr_scan_selected", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }

}


//MARK:- 遵守pageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setContentViewIndex(index: index)
    }
}

//MARK:- 遵守PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, cureentIndex: Int, targetIndex: Int) {
        self.pageTitleView.setProGress(progress: progress, cureentIndex: cureentIndex, targetIndex: targetIndex)
    }
}

//
//  HomeViewController.swift
//  MCDYDemo
//
//  Created by 马聪聪 on 2018/11/12.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
    }
    
    private func setUpUI () {
        
        setUpNavgationBarItem()
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

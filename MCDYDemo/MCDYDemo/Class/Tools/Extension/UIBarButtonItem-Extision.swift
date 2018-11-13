//
//  File.swift
//  MCDYDemo
//
//  Created by 马聪聪 on 2018/11/12.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /// 类方法
    class func createBatBtnItem(imageName: String, highlightName: String, size: CGSize) ->UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highlightName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        let item = UIBarButtonItem(customView: btn)
        return item
    }
    
    /// 便利方法 - 构造函数
    /*
     * swift 中使用的最多的就是构造函数
     * 构造函数 不需要写返回值
     * 在extension 扩充构造函数 需要 convenience 关键字 作为构造函数的开始 必须写
     * 构造函数 必须 调用一个设计的构造函数 (self 调用)
     */
    convenience init(imageName: String, highlightName: String, size: CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highlightName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        self.init(customView: btn) //调用设计构造函数
    }
    
}

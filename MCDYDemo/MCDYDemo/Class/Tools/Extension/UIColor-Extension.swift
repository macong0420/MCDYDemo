//
//  UIColor-Extension.swift
//  MCDYDemo
//
//  Created by 马聪聪 on 2018/11/13.
//  Copyright © 2018 马聪聪. All rights reserved.
//

import UIKit

extension UIColor {
    
    // 便利构造函数
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat,a: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
}

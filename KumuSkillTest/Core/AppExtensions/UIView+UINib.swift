//
//  UIView+UINib.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/12/21.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

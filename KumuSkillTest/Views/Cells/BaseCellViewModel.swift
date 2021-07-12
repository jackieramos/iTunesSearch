//
//  BaseCellViewModel.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import UIKit

class BaseCellViewModel {
    var title: String
    var subTitle: String
    var placeholderImage = UIImage(named: "placeholder")

    init(title: String, subTitle: String) {
        self.title = title
        self.subTitle = subTitle
    }
}

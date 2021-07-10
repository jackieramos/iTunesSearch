//
//  AppStoryBoard.swift
//  KumuSkillTest
//
//  Created by Jackie Ramos on 7/10/21.
//

import UIKit

enum AppStoryboard: String {
    case main = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T? {
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
        let scene = instance.instantiateViewController(withIdentifier: storyBoardID) as? T
        return scene
    }
}

extension UIViewController {
    static var storyboardID: String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)!
    }
}

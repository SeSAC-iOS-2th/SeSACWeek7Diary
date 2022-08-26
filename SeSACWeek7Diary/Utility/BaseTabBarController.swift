//
//  BaseTapBarController.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/26.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
        setupTabBarAppeareance()
    }
    
    func configureTabBarController() { }
    
    func setupTabBarAppeareance() { }
}

extension BaseTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
}

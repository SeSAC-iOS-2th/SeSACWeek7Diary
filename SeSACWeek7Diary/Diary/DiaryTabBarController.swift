//
//  DiaryTabBarController.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/26.
//

import UIKit

class DiaryTabBarController: BaseTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureTabBarController() {
        let firstVC = HomeViewController()
        firstVC.tabBarItem.title = "달력 화면"
        firstVC.tabBarItem.image = UIImage(systemName: "calendar")
        let firstNav = UINavigationController(rootViewController: firstVC)
        
        let secondVC = DiarySearchViewController()
        secondVC.tabBarItem = UITabBarItem(title: "일기 검색", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        let thirdVC = SettingViewContoller()
        thirdVC.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        setViewControllers([firstNav, secondVC, thirdVC], animated: true)
    }
    
    override func setupTabBarAppeareance() {
        let appearence = UITabBarAppearance()
        appearence.configureWithTransparentBackground()
        appearence.backgroundColor = .purple
        tabBar.standardAppearance = appearence
        tabBar.scrollEdgeAppearance = appearence
        tabBar.tintColor = .black
    }
    
    
}

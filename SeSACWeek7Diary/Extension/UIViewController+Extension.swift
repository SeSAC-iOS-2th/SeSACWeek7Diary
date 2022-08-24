//
//  UIViewController+Extension.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/18.
//

import Foundation
import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present //네비게이션 없이 Present
        case presentNavigation //네비게이션 임베드 Present
        case presentFullNavigation //네비게이션 풀스크린
        case push
    }
    
    func transitionViewController<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .presentFullNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        }
    }
    
    
}

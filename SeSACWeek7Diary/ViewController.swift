//
//  ViewController.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/16.
//

import UIKit
import SeSACUIFramework

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        testOpen()
        
//        showSesacAlert(title: "테스트 얼럿", message: "테스트 메시지", buttonTitle: "변경") { _ in
//            self.view.backgroundColor = .lightGray
//        }
        
//        let image = UIImage(systemName: "star.fill")!
//        let shareURL = "https://www.apple.com"
//        let text = "WWDC What's New!!!"
//        sesacShowActivityViewController(shareImage: image, shareURL: shareURL, shareText: text)
        
        OpenWebView.presentWebViewController(self, url: "https://www.naver.com", transitionStyle: .present)
        
    }
        
        

}


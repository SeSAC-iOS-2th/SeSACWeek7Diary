//
//  BaseViewController.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/19.
//


import UIKit

//final 키워드를 사용하면 그 클래스는 상속 불가능!
//final => static dispatch 방식으로 바뀌기 때문에, 성능이 향상됨!
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
    }
    
    
    func configure() {}
    
    func setConstraints() {}
    
    func showAlertMessage(title: String, button: String = "확인") { //매개변수 기본값
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}



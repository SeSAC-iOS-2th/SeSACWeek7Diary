//
//  WriteViewController.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/19.
//

import UIKit
import SnapKit
import RealmSwift

class WriteViewController: BaseViewController {
    

    let mainView = WriteView()
    let localRealm = try! Realm() //Realm 테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근
    
    override func loadView() { //super.loadView X
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    override func configure() {
        mainView.titleTextField.addTarget(self, action: #selector(titleTextFieldClicked(_:)), for: .editingDidEndOnExit)
        mainView.sampleButton.addTarget(self, action: #selector(sampleButtonClicked), for: .touchUpInside)
    }
    
    //Realm Create Sample
    @objc func sampleButtonClicked() {
        
        let task = UserDiary(diaryTitle: "오늘의 일기\(Int.random(in: 1...1000))", diaryContent: "일기 테스트 내용", diaryDate: Date(), regdate: Date(), imageURL: nil) // => Record
        
        try! localRealm.write {
            localRealm.add(task) //Create
            print("Realm Succeed")
        }
    }
    
    @objc func titleTextFieldClicked(_ textField: UITextField) {
        guard let text = textField.text, text.count > 0 else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
    }
}

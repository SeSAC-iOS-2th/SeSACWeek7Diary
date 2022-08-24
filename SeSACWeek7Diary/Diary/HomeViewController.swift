//
//  HomeViewController.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/22.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift //Realm 1. import

class HomeViewController: BaseViewController {
    
    let localRealm = try! Realm() //Realm 2.
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }() //즉시 실행 클로저
    
    var tasks: Results<UserDiary>! {
        didSet {
            //화면 갱신은 화면 전환 코드 및 생명 주기 실행 점검 필요!
            //present, overCurrentContext, overFullScreen > viewWillAppear X
            tableView.reloadData()
            print("Tasks changed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Realm 3. Realm 데이터를 정렬해 tasks에 담기
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
        fetchRealm()
    }
    
    func fetchRealm() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
    }
    
    override func configure() {
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonclicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func plusButtonclicked() {
        let vc = WriteViewController()
        vc.modalPresentationStyle  = .fullScreen
        transitionViewController(vc, transitionStyle: .presentFullNavigation)
    }
    
    @objc func sortButtonClicked() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "regdate", ascending: true)
    }
    
    //realm filter query, NSPredicate
    @objc func filterButtonClicked() {
        tasks = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] 'a'")
        //filter("diaryTitle = '오늘의 일기171'")
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } //Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) //세부 경로. 이미지를 저장할 위치
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }

    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! //as? HomeTableViewCell else { return UITableViewCell() }
        //cell.diaryImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        //cell.setData(data: tasks[indexPath.row])
        return cell
    }
    
    //참고. TableView Editing Mode
    //테이블뷰 셀 높이가 작을 경우, 이미지가 없을 때, 시스템 이미지가 아닌 경우
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let bookMark = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            //realm data update
            try! self.localRealm.write {
                //하나의 레코드에서 특정 컬럼 하나만 변경
                //self.tasks[indexPath.row].bookMark =! self.tasks[indexPath.row].bookMark
                
                //하나의 테이블에 특정 컬럼 전체 값을 변경
                //self.tasks.setValue(true, forKey: "bookMark")
                
                //하나의 레코드에서 여러 컬럼들이 변경
                //self.localRealm.create(UserDiary.self, value: ["objectId": self.tasks[indexPath.row].objectId, "diaryContent": "변경 테스트", "diaryTitle": "제목임"], update: .modified)
                
                print("Realm Update Succeed, reloadRows 필요")
            }
            
            //1. 스와이프 셀 하나만 ReloadRows 코드를 구현
            //2. 데이터가 변경됐으니 다시 realm에서 데이터를 가지고 오기
            self.fetchRealm()
            
        }
        
        //realm 데이터 기준
        let image = tasks[indexPath.row].bookMark ? "star.fill" : "star"
        bookMark.image = UIImage(systemName: image)
        bookMark.backgroundColor = .systemPink
        
        return UISwipeActionsConfiguration(actions: [bookMark])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let bookmark = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            print("bookmark Button Clicked")
        }
        
        let example = UIContextualAction(style: .normal, title: "예시") { action, view, completionHandler in
            print("example Button Clicked")
        }
        
        return UISwipeActionsConfiguration(actions: [bookmark, example])
    }

}

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
import FSCalendar

class HomeViewController: BaseViewController {
    
    let repository = UserDiaryRepository()
    
    lazy var calendar: FSCalendar = {
        let view = FSCalendar()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }() //즉시 실행 클로저
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        return formatter
    }()
    
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
        tasks = repository.localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
        fetchRealm()
    }
    
    func fetchRealm() {
        tasks = repository.fetch()
    }
    
    override func configure() {
        view.addSubview(tableView)
        view.addSubview(calendar)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonclicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            make.topMargin.equalTo(300)
        }
        calendar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
    }
    
    @objc func plusButtonclicked() {
        let vc = WriteViewController()
        vc.modalPresentationStyle  = .fullScreen
        transitionViewController(vc, transitionStyle: .presentFullNavigation)
    }
    
    @objc func sortButtonClicked() {
        tasks = repository.fetchSort("regdate")
    }
    
    //realm filter query, NSPredicate
    @objc func filterButtonClicked() {
        tasks = repository.fetchFilter()
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
            self.repository.updateBookMark(item: self.tasks[indexPath.row])
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
        
        let bookMark = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            
            let task = self.tasks[indexPath.row]
            self.repository.deleteItem(item: task)
            
            //self.fetchRealm()
            
        }
        
        
        return UISwipeActionsConfiguration(actions: [bookMark])
        
    }

}

extension HomeViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDate(date: date).count
    }
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "새싹"
//    }
    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star.fill")
//    }
//
    //date: yyyyMMdd hh:mm:ss => dateformatter
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return formatter.string(from: date) == "220907" ? "오프라인 모임" : nil
    }


    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tasks = repository.fetchDate(date: date)
    }
    
}

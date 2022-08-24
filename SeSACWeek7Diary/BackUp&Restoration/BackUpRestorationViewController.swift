//
//  BackUpRestorationViewController.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/24.
//

import UIKit
import Kingfisher

class BackUpRestorationViewController: BaseViewController {
    
    let mainView = BackUpRstorationView()
    
    let seqArray = [Int](1...10)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
    }
    
    override func configure() {
        mainView.backupFileListTableView.delegate = self
        mainView.backupFileListTableView.dataSource = self
        mainView.backupFileListTableView.register(BackUpRestorationTableViewCell.self, forCellReuseIdentifier: "BackUpRestorationTableViewCell")
        
    }
}

extension BackUpRestorationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BackUpRestorationTableViewCell", for: indexPath) as? BackUpRestorationTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .lightGray
        cell.tagLabel.text = "\(seqArray[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

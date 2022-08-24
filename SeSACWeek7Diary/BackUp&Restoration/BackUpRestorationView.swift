//
//  BackUpRestorationView.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/24.
//

import UIKit
import SnapKit

class BackUpRstorationView: BaseView {
    
    let backupButton: UIButton = {
        let view = UIButton()
        view.setTitle("백업", for: .normal)
        view.backgroundColor = .red
        return view
    }()
    
    let restorationButton: UIButton = {
        let view = UIButton()
        view.setTitle("복구", for: .normal)
        view.backgroundColor = .blue
        return view
    }()
    
    let backupFileListTableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func configureUI() {
        [backupButton, restorationButton, backupFileListTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        backupButton.snp.makeConstraints { make in
            make.top.leading.equalTo(100)
            make.height.width.equalTo(60)
        }
        restorationButton.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.trailing.equalTo(-100)
            make.height.width.equalTo(60)
        }
        backupFileListTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(backupButton.snp.bottom).offset(100)
        }

    }
    
}

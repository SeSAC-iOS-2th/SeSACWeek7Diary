//
//  DiarySearchView.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/27.
//

import UIKit
import SnapKit

class DiarySearchView: BaseView {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "제목을 검색하세요"
        return searchBar
    }()
    
    override func configureUI() {
        [searchBar].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
}

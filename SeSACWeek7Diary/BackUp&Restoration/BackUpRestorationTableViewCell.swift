//
//  BackUpRestorationTableViewCell.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/25.
//

import UIKit
import SnapKit

class BackUpRestorationTableViewCell: BaseTableViewCell {
    
    
    let tagLabel: UILabel = {
       let view = UILabel()
       view.text = ""
       view.textAlignment = .center
       view.layer.borderWidth = 2
       view.layer.borderColor = UIColor.black.cgColor
       view.layer.cornerRadius = 10
       return view
    }()
    
    
    override func configure() {
        [tagLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalTo(self)
            make.height.width.equalTo(20)
        }
    }
    
}

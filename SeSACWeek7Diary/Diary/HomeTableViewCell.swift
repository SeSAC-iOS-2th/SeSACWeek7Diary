//
//  HomeTableViewCell.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/26.
//

import UIKit
import SnapKit

class HomeTableViewCell: BaseTableViewCell {
    
    let diarytTitleLabel: UILabel = {
       let view = UILabel()
       return view
    }()
    
    let writeDateLabel: UILabel = {
       let view = UILabel()
       return view
    }()
    
    let diaryContentsLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let diaryImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    
    override func configure() {
        [diarytTitleLabel, writeDateLabel, diaryContentsLabel, diaryImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {

        
    }
    
    
}

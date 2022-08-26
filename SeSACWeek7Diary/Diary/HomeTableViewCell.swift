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
       view.text = "다이어리 제목"
       view.font = UIFont.systemFont(ofSize: 18)
       return view
    }()
    
    let writeDateLabel: UILabel = {
       let view = UILabel()
       view.text = "작성 날짜"
       view.font = UIFont.systemFont(ofSize: 16)
       return view
    }()
    
    let diaryContentsLabel: UILabel = {
        let view = UILabel()
        view.text = "다이어리 내용"
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()
    
    let diaryImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        return view
    }()
    
    
    override func configure() {
        [diarytTitleLabel, writeDateLabel, diaryContentsLabel, diaryImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {

        diarytTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(20)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        writeDateLabel.snp.makeConstraints { make in
            make.top.equalTo(diarytTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.width.equalTo(diarytTitleLabel.snp.width)
            make.height.equalTo(25)
        }
        
        diaryContentsLabel.snp.makeConstraints { make in
            make.top.equalTo(writeDateLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.width.equalTo(diarytTitleLabel.snp.width)
            make.height.equalTo(50)
        }
        
        diaryImageView.snp.makeConstraints { make in
            make.leading.equalTo(diarytTitleLabel.snp.trailing).offset(40)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.bottom.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    func setData(data: UserDiary) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        diarytTitleLabel.text = data.diaryTitle
        writeDateLabel.text = formatter.string(from: data.diaryDate)
        diaryContentsLabel.text = data.diaryContent
    }
    
}

//
//  WriteView.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/19.
//

import UIKit

class WriteView: BaseView {
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleTextField: WhiteRadiusTextField = {
        let view = WhiteRadiusTextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    let dateTextField: WhiteRadiusTextField = {
        let view = WhiteRadiusTextField()
        view.placeholder = "날짜를 입력해주세요"
        return view
    }()
    
    let contentTextView: UITextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let searchImageButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "photo"), for: .normal)
        view.tintColor = .white
        view.backgroundColor = .red
        view.layer.cornerRadius = 25
        return view
    }()

    
    let sampleButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .green
        return view
    }()
    
    override func configureUI() {
        [photoImageView, titleTextField, dateTextField, contentTextView, searchImageButton, sampleButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.35)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)

        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            
        }
        
        searchImageButton.snp.makeConstraints { make in
            make.trailing.equalTo(photoImageView.snp.trailing).offset(-12)
            make.bottom.equalTo(photoImageView.snp.bottom).offset(-12)
            make.width.height.equalTo(50)
        }

        sampleButton.snp.makeConstraints { make in
            make.trailing.equalTo(photoImageView.snp.trailing).offset(12)
            make.bottom.equalTo(photoImageView.snp.top).offset(32)
            make.width.height.equalTo(50)
        }

    }
    
}

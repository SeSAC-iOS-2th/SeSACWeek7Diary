//
//  ImageSearchCollectionViewCell.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/22.
//

import UIKit
import Kingfisher

class ImageSearchCollectionViewCell: BaseCollectionViewCell {
    
    let searchImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
            
    override func configure() {
        self.addSubview(searchImageView)
    }
    
    override func setConstraints() {
        searchImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func setImage(data: String) {
        let url = URL(string: data)
        searchImageView.kf.setImage(with: url)
    }
}

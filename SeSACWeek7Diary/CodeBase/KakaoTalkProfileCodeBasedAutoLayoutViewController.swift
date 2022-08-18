//
//  CodeBasedAutoLayoutViewController.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/17.
//

import UIKit

class KakaoTalkProfileCodeBasedAutoLayoutViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background1")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "i16010172480")
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        return view
    }()
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let giftButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "gift"), for: .normal)
        view.tintColor = .white
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        return view
    }()
    
    let sendMoneyButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "die.face.5"), for: .normal)
        view.tintColor = .white
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        return view
    }()
    
    let settingButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "gearshape"), for: .normal)
        view.tintColor = .white
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        return view
    }()
    
    let chatWithMeButton: UIButton = {
        let view = UIButton()
        let title = "나와의 채팅"
        let iconImage: UIImage! = UIImage(systemName: "message.fill")
        view.configuration = UIButton.Configuration.customButton(title: title, iconImage: iconImage)
        return view
    }()
    
    let editProfileButton: UIButton = {
        let view = UIButton()
        let title = "프로필 편집"
        let iconImage: UIImage! = UIImage(systemName: "pencil")
        view.configuration = UIButton.Configuration.customButton(title: title, iconImage: iconImage)
        return view
    }()
    
    let kakaoStoryButton: UIButton = {
        let view = UIButton()
        let title = "카카오스토리"
        let iconImage: UIImage! = UIImage(systemName: "shield.fill")
        view.configuration = UIButton.Configuration.customButton(title: title, iconImage: iconImage)
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "JoongWon"
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }()
    
    let statusMessageLabel: UILabel = {
        let view = UILabel()
        view.text = "ios 개발자"
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()
    
    let contourView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    
    func configureUI() {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        [backgroundImageView, profileImageView, cancelButton, giftButton, sendMoneyButton, settingButton, chatWithMeButton, editProfileButton, kakaoStoryButton, nameLabel, statusMessageLabel, contourView].forEach {
            view.addSubview($0)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(0)
            make.trailingMargin.equalTo(0)
            make.bottomMargin.equalTo(0)

        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.leadingMargin.equalTo(15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.trailingMargin.equalTo(-15)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        sendMoneyButton.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.trailing.equalTo(settingButton).offset(-45)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        giftButton.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.trailing.equalTo(sendMoneyButton).offset(-45)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        chatWithMeButton.snp.makeConstraints { make in
            make.leading.equalTo(screenWidth * 0.12)
            make.bottom.equalTo(-(screenHeight * 0.08))
            make.height.equalTo(88)
            make.width.equalTo(88)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(-(screenHeight * 0.08))
            make.height.equalTo(88)
            make.width.equalTo(88)
        }
        
        kakaoStoryButton.snp.makeConstraints { make in
            make.trailing.equalTo(-(screenWidth * 0.12))
            make.bottom.equalTo(-(screenHeight * 0.08))
            make.height.equalTo(88)
            make.width.equalTo(88)

        }
        
        contourView.snp.makeConstraints { make in
            make.leadingMargin.equalTo(0)
            make.trailingMargin.equalTo(0)
            make.height.equalTo(0.5)
            make.bottomMargin.equalTo(editProfileButton).offset(-90)
        }
        
        statusMessageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(contourView).offset(-35)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(statusMessageLabel).offset(-25)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.height.equalTo(90)
            make.width.equalTo(90)
            make.bottom.equalTo(nameLabel).offset(-35)
        }
        
    }
    


}

@available(iOS 15.0, *)
extension UIButton.Configuration {
    
    static func customButton(title: String, iconImage: UIImage) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        var titleAttr = AttributedString.init(title)
        titleAttr.font = UIFont.systemFont(ofSize: 12)
        configuration.attributedTitle = titleAttr
        configuration.image = iconImage
        configuration.imagePadding = 12
        configuration.imagePlacement = .top
        configuration.baseBackgroundColor = .clear
        
        return configuration
    }
}

//
//  RealmModel.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/22.
//

import Foundation
import RealmSwift

//UserDiary: 테이블 이름
//@Persisted: 컬럼
class UserDiary: Object {
    @Persisted var diaryTitle: String //제목(필수)
    @Persisted var diaryContent: String? //내용(옵션)
    @Persisted var diaryDate = Date() //작성 날짜(필수)
    @Persisted var regdate = Date() //등록 날짜(필수)
    @Persisted var bookMark: Bool //즐겨찾기(필수)
    @Persisted var imageURL: String? //사진URL-String(옵션)
    
    //PK(필수): Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(diaryTitle: String, diaryContent: String?, diaryDate: Date, regdate: Date, imageURL: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.diaryDate = diaryDate
        self.regdate = regdate
        self.bookMark = false
        self.imageURL = imageURL
    }
}

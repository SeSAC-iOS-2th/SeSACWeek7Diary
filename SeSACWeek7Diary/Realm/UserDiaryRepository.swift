//
//  UserDiaryRepository.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/26.
//

import Foundation
import RealmSwift

// 여러개의 테이블 => CRUD

protocol UserDiaryRepositoryType {
    func fetch() -> Results<UserDiary>
    func fetchSort(_ sort: String) -> Results<UserDiary>
    func fetchFilter() -> Results<UserDiary>
    func fetchDate(date: Date) -> Results<UserDiary>
    func updateBookMark(item: UserDiary)
    func deleteItem(item: UserDiary)
    func addItem(item: UserDiary)
    
}


class UserDiaryRepository : UserDiaryRepositoryType {
    
    func fetchDate(date: Date) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryDate >= %@ AND diaryDate < %@", date, Date(timeInterval: 86400, since: date)) //NSPredicate
    }
    
    func addItem(item: UserDiary) {
        
    }
    
    let localRealm = try! Realm() // struct => singleTon이 의미 없는 이유?
    
    func fetch() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
    }
    
    func fetchSort(_ sort: String) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: sort, ascending: true)
    }
    
    func fetchFilter() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] 'a'")
    }
    
    func updateBookMark(item: UserDiary) {
        try! localRealm.write {
            //하나의 레코드에서 특정 컬럼 하나만 변경
            item.bookMark = !item.bookMark
            
            //item.bookMark.toggle() -> Bool Type 바꾸기
            
            //하나의 테이블에 특정 컬럼 전체 값을 변경
            //self.tasks.setValue(true, forKey: "bookMark")
            
            //하나의 레코드에서 여러 컬럼들이 변경
            //self.localRealm.create(UserDiary.self, value: ["objectId": self.tasks[indexPath.row].objectId, "diaryContent": "변경 테스트", "diaryTitle": "제목임"], update: .modified)
            
            print("Realm Update Succeed, reloadRows 필요")
        }
    }
    
    func deleteItem(item: UserDiary) {
        try! localRealm.write {
            localRealm.delete(item)
        }
        
        removeImageFromDocument(fileName: "\(item.objectId).jpg")
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
}

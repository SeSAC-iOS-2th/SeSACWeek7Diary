//
//  BackUpRestorationViewController.swift
//  SeSACWeek7Diary
//
//  Created by 이중원 on 2022/08/24.
//

import UIKit
import Zip

class BackUpRestorationViewController: BaseViewController {
    
    let mainView = BackUpRstorationView()
    
    var backupFileUrlArray: [String] = []
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        mainView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        mainView.restorationButton.addTarget(self, action: #selector(restoreButtonClickd), for: .touchUpInside)
        view.backgroundColor = .black
        
        backupFileUrlArray.append(fetchDocumentZipFile())
    }
    
    override func configure() {
        mainView.backupFileListTableView.delegate = self
        mainView.backupFileListTableView.dataSource = self
        mainView.backupFileListTableView.register(BackUpRestorationTableViewCell.self, forCellReuseIdentifier: "BackUpRestorationTableViewCell")
        
    }
    
    @objc func backupButtonClicked() {
        
        var urlPaths = [URL]()
        
        //Document 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "Document 위치에 오류가 있습니다")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm")
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlertMessage(title: "백업할 파일이 없습니다")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!)
        
        //백업 파일 압축: URL
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "SeSACDiary_1")
            print("Archive Location: \(zipFilePath)")
        } catch {
            showAlertMessage(title: "압축을 실패했습니다")
        }
        
        //ActivityViewController
        showActivityViewController()
        
    }
    
    func showActivityViewController() {
        //Document 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "Document 위치에 오류가 있습니다")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("SeSACDiary_1.zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @objc func restoreButtonClickd() {
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
}

extension BackUpRestorationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backupFileUrlArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BackUpRestorationTableViewCell", for: indexPath) as? BackUpRestorationTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .lightGray
        cell.tagLabel.text = "\(indexPath.row + 1)"
        cell.filePath.text = "\(backupFileUrlArray[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

extension BackUpRestorationViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            showAlertMessage(title: "선택하신 파일에 오류가 있습니다")
            return
        }
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "Document 위치에 오류가 있습니다")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다")
                })
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다")
            }
            
        } else {
            
            do {
                //파일 앱의 zip -> Document 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다")
                })
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다")
            }
        }
    }
}

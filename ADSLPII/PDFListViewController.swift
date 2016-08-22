//
//  PDFListViewController.swift
//  ADSLPII
//
//  Created by John Lima on 21/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class PDFListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "cell"
    private let numberOfSections = 1
    private var tableData = [PDFFilesModel]()
    private let model = PDFFilesModel()
    
    var identifier: Int?
    var titleName: String!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getData()
        self.updateUI()
    }
    
    // MARK: Actions
    func getData() {
        
        if let identifier = self.identifier {
            switch identifier {
            case PDFFileId.MS.rawValue:
                self.tableData = self.model.getModelingSystemsData()
            case PDFFileId.PBD.rawValue:
                self.tableData = self.model.getDatabaseProjectData()
            default:
                break
            }
        }
    }
    
    func updateUI() {
        
        self.title = self.titleName
        
        let button = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = button
        
        let background = UIView(frame: .zero)
        self.tableView.tableFooterView = background
        self.tableView.backgroundColor = UIColor.white
    }
    
    // MARK: TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = self.tableData[indexPath.row].pdfName!.uppercased()
        
        cell.textLabel?.textColor = UIColor(hexString: Colors.Default.rawValue)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return cell
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if
            let file = self.tableData[indexPath.row].pdfFileName,
            let name = self.tableData[indexPath.row].pdfName {
        
            UserDefaults.saveObject(object: file as AnyObject, key: .File)
            UserDefaults.saveObject(object: name as AnyObject, key: .Title)
            
            UIStoryboard.startWith(storyboardName: .Main, controllerName: .FileWebViewController, target: self)
        }
    }
}

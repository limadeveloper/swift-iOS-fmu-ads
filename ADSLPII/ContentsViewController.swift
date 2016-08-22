//
//  ContentsViewController.swift
//  ADSLPII
//
//  Created by John Lima on 21/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class ContentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "cell"
    private let numberOfSections = 1
    private var tableData = [ContentsModel]()
    private let model = ContentsModel()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getData()
        self.updateUI()
    }
    
    // MARK: Actions
    func getData() {
        
        self.tableData = self.model.getContents()
    }
    
    func updateUI() {
        
        self.title = Title.Contents.rawValue
        
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
        
        cell.textLabel?.text = self.tableData[indexPath.row].name!.uppercased()
        cell.detailTextLabel?.text = self.tableData[indexPath.row].weekName
        
        cell.textLabel?.textColor = UIColor(hexString: Colors.Default.rawValue)
        cell.detailTextLabel?.textColor = UIColor.darkGray
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return cell
    }

    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let id = self.tableData[indexPath.row].id {
            switch id {
            case ContentId.LPII.rawValue:
                self.performSegue(withIdentifier: Segue.LPII.rawValue, sender: indexPath)
            default:
                self.performSegue(withIdentifier: Segue.PDFList.rawValue, sender: indexPath)
                break
            }
        }
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.LPII.rawValue:
                let controler = segue.destination as! ListDetailClasses
                controler.identifier = identifier
            default:
                let controler = segue.destination as! PDFListViewController
                if
                    let indexPath = sender as? IndexPath,
                    let titleName = self.tableData[indexPath.row].name,
                    let id = self.tableData[indexPath.row].id {
                    
                    controler.identifier = id
                    controler.titleName = titleName
                }
            }
        }
    }
    
}

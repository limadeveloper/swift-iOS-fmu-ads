//
//  HomeViewController.swift
//  ADSLPII
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    private var tableDataSections = [String]()
    private var tableDataRows = Dictionary<String,[HomeModel]>()
    private let cellIdentifier = "cell"
    private let cellHeader = "header"
    private let headerHight: CGFloat = 30
    private let homeModel = HomeModel()
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()
        self.updateUI()
    }
    
    // MARK: Actions
    private func updateUI() {
        
        self.title = NSLocalizedString(NavigationName.Home.rawValue, comment: "")
        
        let background = UIView(frame: .zero)
        self.tableView.tableFooterView = background
        self.tableView.backgroundColor = UIColor.white
    }
    
    private func getData() {
        
        let data = self.homeModel.getData()
        
        if let dictionaryArray = self.homeModel.convertModelArrayToDictionaryArray(array: data) {
            
            let sectionsAndRows = Requests.formateDataFromArray(data: dictionaryArray, sectionKey: HomeAttributes.Title.rawValue, idKey: HomeAttributes.Id.rawValue)
            
            if
                let sections = sectionsAndRows.sections,
                let rows = sectionsAndRows.rows,
                let formatedRows = self.homeModel.formateModelDictionary(item: rows) {
                
                self.tableDataSections = sections
                self.tableDataRows = formatedRows
            }
        }
        
    }
    
    // MARK: TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableDataSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = self.tableDataSections[section]
        let rows = self.tableDataRows[key]
        return rows != nil ? rows!.count : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellHeader)
        let label = cell?.viewWithTag(2) as! UILabel
        
        if self.tableDataSections.count > 0 {
            label.text = self.tableDataSections[section]
            return cell
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let items = self.tableDataRows[self.tableDataSections[indexPath.section]]
        
        cell.textLabel?.text = items?[indexPath.row].subtitle
        cell.detailTextLabel?.text = items?[indexPath.row].date
        
        return cell
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let items = self.tableDataRows[self.tableDataSections[indexPath.section]]
        if let index = items?[indexPath.row].index {
        
            switch index {
            case 0: self.performSegue(withIdentifier: Segue.OrderNumbers.rawValue, sender: nil)
            case 1: self.performSegue(withIdentifier: Segue.Average.rawValue, sender: nil)
            default:
                break
            }
            
        }
    }
    
}


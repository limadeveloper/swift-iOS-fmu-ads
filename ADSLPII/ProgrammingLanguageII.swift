//
//  ProgrammingLanguageII.swift
//  ADSLPII
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class ProgrammingLanguageII: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    private var tableDataSections = [String]()
    private var tableDataRows = Dictionary<String,[ProgrammingLanguageIIModel]>()
    private let cellIdentifier = "cell"
    private let cellHeader = "header"
    private let headerHight: CGFloat = 30
    private let programmingLanguageIIModel = ProgrammingLanguageIIModel()
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()
        self.updateUI()
    }
    
    // MARK: Actions
    private func updateUI() {
        
        self.title = NSLocalizedString(NavigationName.ProgrammingLanguageII.rawValue, comment: "")
        
        let background = UIView(frame: .zero)
        self.tableView.tableFooterView = background
        self.tableView.backgroundColor = UIColor.white
        
        let button = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = button
    }
    
    private func getData() {
        
        let data = self.programmingLanguageIIModel.getData()
        
        if let dictionaryArray = self.programmingLanguageIIModel.convertModelArrayToDictionaryArray(array: data) {
            
            let sectionsAndRows = Requests.formateDataFromArray(data: dictionaryArray, sectionKey: ProgrammingLanguageIIAttributes.Title.rawValue, idKey: ProgrammingLanguageIIAttributes.Id.rawValue)
            
            if
                let sections = sectionsAndRows.sections,
                let rows = sectionsAndRows.rows,
                let formatedRows = self.programmingLanguageIIModel.formateModelDictionary(item: rows) {
                
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
        
        cell.textLabel?.textColor = UIColor(hexString: Colors.Default.rawValue)
        
        return cell
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let items = self.tableDataRows[self.tableDataSections[indexPath.section]]
        let item = items?[indexPath.row]
        if let id = item?.id {
        
            switch id {
            case ProgrammingLanguageIIModelIds.First.rawValue: self.performSegue(withIdentifier: Segue.First.rawValue, sender: item)
            case ProgrammingLanguageIIModelIds.Second.rawValue: self.performSegue(withIdentifier: Segue.Second.rawValue, sender: item)
            default:
                break
            }
            
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            
            let firstController = segue.destination as! FirstViewController
            
            firstController.identifier = identifier
            
            if let modelData = sender as? ProgrammingLanguageIIModel {
                firstController.modelData = modelData
            }
        }
    }
}


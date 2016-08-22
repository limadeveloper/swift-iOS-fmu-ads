//
//  ListDetailClasses.swift
//  ADSLPII
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class ListDetailClasses: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    private var tableDataSections = [String]()
    private var tableDataRows = Dictionary<String,[DetailClassesModel]>()
    private let cellIdentifier = "cell"
    private let cellHeader = "header"
    private let headerHight: CGFloat = 30
    private let model = DetailClassesModel()
    private var pdfDataFiles = [AnyObject]()
    
    var identifier: String?
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()
        self.updateUI()
    }
    
    // MARK: Actions
    private func updateUI() {
        
        let background = UIView(frame: .zero)
        self.tableView.tableFooterView = background
        self.tableView.backgroundColor = UIColor.white
        
        let button = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = button
        
        if self.pdfDataFiles.count > 0 {
            let fileButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(self.showPdfDataFiles))
            self.navigationItem.rightBarButtonItem = fileButton
        }
    }
    
    private func getData() {
        
        var data = [DetailClassesModel]()
        
        if let identifier = self.identifier {
            switch identifier {
            case Segue.LPII.rawValue:
                data = self.model.getProgrammingLanguageIIModelData()
            default:
                break
            }
        }
        
        self.title = data.first!.name!
        
        if let dictionaryArray = self.model.convertModelArrayToDictionaryArray(array: data) {
            
            let sectionsAndRows = Requests.formateDataFromArray(data: dictionaryArray, sectionKey: DetailClassesAttributes.Title.rawValue, idKey: DetailClassesAttributes.Id.rawValue)
            
            if
                let sections = sectionsAndRows.sections,
                let rows = sectionsAndRows.rows,
                let formatedRows = self.model.formateModelDictionary(item: rows) {
                
                self.tableDataSections = sections
                self.tableDataRows = formatedRows
            }
        }
        
    }
    
    @objc private func showPdfDataFiles() {
        print("has no files")
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
        
        cell?.backgroundColor = UIColor(hexString: Colors.DefaultTranslucent.rawValue)?.withAlphaComponent(0.9)
        cell?.backgroundView?.backgroundColor = cell?.backgroundColor
        label.textColor = UIColor.white
        
        label.font = UIFont.boldSystemFont(ofSize: 13)
        
        if self.tableDataSections.count > 0 {
            label.text = self.tableDataSections[section].uppercased()
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
        
        cell.textLabel?.text = items?[indexPath.row].subtitle?.uppercased()
        cell.detailTextLabel?.text = items?[indexPath.row].date
        
        cell.textLabel?.textColor = UIColor(hexString: Colors.Default.rawValue)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return cell
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let items = self.tableDataRows[self.tableDataSections[indexPath.section]]
        let item = items?[indexPath.row]
        if let id = item?.id {
            switch id {
            case DetailClassesModelIds.First.rawValue: self.performSegue(withIdentifier: Segue.First.rawValue, sender: item)
            case DetailClassesModelIds.Second.rawValue: self.performSegue(withIdentifier: Segue.Second.rawValue, sender: item)
            case DetailClassesModelIds.Third.rawValue: self.performSegue(withIdentifier: Segue.Calculator.rawValue, sender: item)
            default:
                break
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.First.rawValue, Segue.Second.rawValue, Segue.Calculator.rawValue:
                // Order values, Average value, Calculator
                let controller = segue.destination as! FirstViewController
                controller.identifier = identifier
                if let modelData = sender as? DetailClassesModel {
                    controller.model = modelData
                }
            default:
                break
            }
        }
    }
    
}


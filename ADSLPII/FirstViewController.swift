//
//  ViewController.swift
//  OrderValues
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 John Lima. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var collectionData = [String]()
    private var numbers = [Int]()
    private var orderNumbers = [String]()
    private let cellIdentifier = "cell"
    private let numberOfSections = 1
    private var done: Bool = false
    private var buttonFile = UIBarButtonItem()
    
    var identifier: String?
    var modelData: ProgrammingLanguageIIModel!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()
        self.updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.layoutIfNeeded()
    }

    // MARK: - Actions
    private func updateUI() {
        
        self.isNavButton(show: true)
        
        let defaultTitleMessage = Message.EnterWithNumber.rawValue
        
        if let identifier = self.identifier {
            switch identifier {
            case Segue.First.rawValue:
                self.title = Title.First.rawValue
            case Segue.Second.rawValue:
                self.title = Title.Second.rawValue
            default:
                self.title = defaultTitleMessage
            }
        }else {
            self.title = defaultTitleMessage
        }
        
        if self.numbers.count > 0 {
            
            let messageSelectedNumbers = "\(Message.SelectedNumbers.rawValue): \n\(self.numbers)"
            
            var number = Int()
            
            for i in 0 ..< self.numbers.count {
                for j in i+1 ..< self.numbers.count {
                    if self.numbers[i] > self.numbers[j] {
                        number = self.numbers[i]
                        self.numbers[i] = self.numbers[j]
                        self.numbers[j] = number
                    }
                }
            }
            
            print("Order: \(self.numbers)")
            
            let messageOrderedNumbers = "\(Message.OrderedNumbers.rawValue): \n\(self.numbers)"
            let message = "\(messageSelectedNumbers)\n\n\(messageOrderedNumbers)"
            
            let ok = UIAlertAction(title: ButtonTitle.Ok.rawValue, style: .destructive, handler: nil)
            DispatchQueue.main.async { [weak self] in
                UIAlertController.createAlert(title: Message.Result.rawValue, message: message, style: .alert, actions: [ok], target: self, isPopover: false, buttonItem: nil)
            }
            
            self.numbers = [Int]()
        }
        
        self.collectionView.reloadData()
    }
    
    private func getData() {
        
        var count = Int()
        
        if let id = self.modelData.id {
            switch id {
            case ProgrammingLanguageIIModelIds.First.rawValue, ProgrammingLanguageIIModelIds.Second.rawValue:
                count = 10
            default:
                break
            }
        }
        
        self.collectionData = [String]()
        
        if count > 0 {
            for i in 0 ..< count {
                self.collectionData.append("\(i+1)")
            }
        }
    }
    
    private func isNavButton(show: Bool) {
        self.buttonFile = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(self.showFile))
        if show {
            self.navigationItem.rightBarButtonItem = buttonFile
        }
    }
    
    @objc private func showFile() {
        
        if let file = modelData.file, let title = modelData.title {
            
            let file = file as AnyObject
            let title = title as AnyObject
            
            UserDefaults.saveObject(object: file, key: .File)
            UserDefaults.saveObject(object: title, key: .Title)
            
            UIStoryboard.startWith(storyboardName: .ProgrammingLanguageII, controllerName: .FileWebViewController, target: self)
        }
    }
    
    private func isRow(selected: Bool, label: UILabel) {
        
        if selected {
            UIView.animate(withDuration: 3) {
                label.layer.borderWidth = 5
            }
        }else {
            UIView.animate(withDuration: 3) {
                label.layer.borderWidth = 1
            }
        }
        
        self.view.layoutIfNeeded()
    }
    
    // MARK: - UICollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath)
        
        let label = cell.viewWithTag(1) as! UILabel
        label.text = self.collectionData[indexPath.row]
        label.textColor = UIColor(hexString: Colors.Default.rawValue)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(hexString: Colors.Default.rawValue)?.cgColor
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        let label = cell?.viewWithTag(1) as! UILabel
        
        self.isRow(selected: true, label: label)
        
        if self.numbers.count < 10 && label.text != "" {
            self.numbers.append(Int(label.text!)!)
        }else {
            
            self.done = true
            
            let ok = UIAlertAction(title: ButtonTitle.Order.rawValue, style: .destructive) { [weak self] (action) in
                self?.updateUI()
            }
            
            let message = "\(Message.YouSelectedThisNumbers.rawValue) \n\(self.numbers)"
            
            DispatchQueue.main.async { [weak self] in
                UIAlertController.createAlert(title: Message.Done.rawValue, message: message, style: .alert, actions: [ok], target: self, isPopover: false, buttonItem: nil)
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        let label = cell?.viewWithTag(1) as! UILabel
        
        self.isRow(selected: false, label: label)
    }

}


//
//  CalculatorViewController.swift
//  ADSLPII
//
//  Created by John Lima on 21/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var infoTextView: UITextView!
    
    private var collectionData = [String]()
    private var numbers = [Int]()
    private var done: Bool = false
    private var buttonFile = UIBarButtonItem()
    private let cellIdentifier = "cell"
    private let numberOfSections = 1
    private var isOperator: Bool = false
    private var selectedOperator = String()
    private let countOfNumbersInArray: Int = 10
    
    var identifier: String?
    var modelData: ProgrammingLanguageIIModel!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData(count: self.countOfNumbersInArray)
        self.updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Actions
    private func updateUI() {
        
        self.isNavButton(show: true)
        
        self.title = Requests.getNavigationTitle(identifier: self.identifier)
        
        self.infoTextView.textColor = UIColor(hexString: Colors.Default.rawValue)
        self.infoTextView.text = Message.ChooseTwoNumbers.rawValue
        
        if self.numbers.count > 0 {
            self.getResultCalculus()
        }
    }
    
    private func getData(count: Int) {
        
        self.collectionData = [String]()
        
        let count = count
        
        if count == self.countOfNumbersInArray {
            self.isOperator = false
            for i in 0 ..< count {
                self.collectionData.append("\(i+1)")
            }
        }else {
            self.collectionData = Arrays.operatorArray
            self.isOperator = true
        }
        
        self.collectionView.reloadData()
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
    
    private func getResultCalculus() {
        
        var result = String()
        
        let ok = UIAlertAction(title: ButtonTitle.Ok.rawValue, style: .destructive) { [weak self] (action) in
            self?.numbers = [Int]()
            self?.selectedOperator = String()
            self?.isOperator = false
            self?.getData(count: self!.countOfNumbersInArray)
            self?.updateUI()
        }
        
        result = Calculus.getResultCalculatorCalculus(numbers: self.numbers, operatorValue: self.selectedOperator)
        
        DispatchQueue.main.async { [weak self] in
            UIAlertController.createAlert(title: Message.Result.rawValue, message: result, style: .alert, actions: [ok], target: self, isPopover: false, buttonItem: nil)
        }
        
        self.infoTextView.text = result
    }
    
    // MARK: - CollectionView DataSource
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
        
        if self.isOperator {
            self.selectedOperator = label.text!
            self.done = true
            self.updateUI()
        }else {
            self.numbers.append(Int(label.text!)!)
            if self.numbers.count == 2 && label.text != "" && label.text != "\(0)" {
                self.infoTextView.text = Message.ChooseTheOperator.rawValue
                self.getData(count: Arrays.operatorArray.count)
            }else {
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        let label = cell?.viewWithTag(1) as! UILabel
        
        self.isRow(selected: false, label: label)
    }

}

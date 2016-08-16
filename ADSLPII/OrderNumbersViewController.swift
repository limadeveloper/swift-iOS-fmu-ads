//
//  ViewController.swift
//  OrderValues
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 John Lima. All rights reserved.
//

import UIKit

class OrderNumbersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelNumbers: UILabel!
    @IBOutlet weak var labelOrderNumbers: UILabel!
    
    private var collectionData = [String]()
    private var numbers = [Int]()
    private var orderNumbers = [String]()
    private let cellIdentifier = "cell"
    private let numberOfSections = 1
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()
        self.updateUI()
    }

    // MARK: - Actions
    private func updateUI() {
    
        self.labelOrderNumbers.textColor = UIColor(hexString: Colors.Default.rawValue)
        self.labelNumbers.textColor = UIColor.darkGray
        
        if self.numbers.count > 0 {
            
            self.labelNumbers.text = "\(Message.ChooseNumbers.rawValue): \n\(self.numbers)"
            
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
            
            self.labelOrderNumbers.text = "\(Message.OrderNumbers.rawValue): \n\(self.numbers)"
        }
        
        self.collectionView.reloadData()
    }
    
    private func getData() {
        
        let count = 10
        
        self.collectionData = [String]()
        
        for i in 0 ..< count {
            self.collectionData.append("\(i+1)")
        }
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
        
        print("index: \(indexPath.row)")
        
        let cell = collectionView.cellForItem(at: indexPath)
        let label = cell?.viewWithTag(1) as! UILabel
        
        if self.numbers.count < 10 && label.text != "" {
            self.numbers.append(Int(label.text!)!)
        }else {
            
            let ok = UIAlertAction(title: ButtonTitle.Order.rawValue, style: .default, handler: { [weak self] (action) in
                self?.updateUI()
            })
            
            let alert = UIAlertController(title: Message.Done.rawValue, message: "\(Message.SelectedNumbers.rawValue) \n\(self.numbers)", preferredStyle: .alert)
            
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
        }
    }

}


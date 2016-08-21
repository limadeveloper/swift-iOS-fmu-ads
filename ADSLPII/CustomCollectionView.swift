//
//  CustomCollectionViewController.swift
//  ADSLPII
//
//  Created by John Lima on 20/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

protocol CustomCollectionViewDelegate {
    func didSelectItemAt(label: UILabel)
    func didDeselectItemAt(label: UILabel)
}

class CustomCollectionView: UICollectionViewController {

    // MARK: - Properties
    private let cellIdentifier = "cell"
    private let numberOfSections = 1
    private var collectionData = [AnyObject]()
    private var modelType: DataType?
    private var collection = UICollectionView()
    
    var delegate: CustomCollectionViewDelegate?
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    func setup(data: [AnyObject], type: DataType, collectionView: UICollectionView) {
        
        self.collectionData = data
        self.modelType = type
        
        self.collection = collectionView
        
        self.collectionView?.reloadData()
    }
    
    // MARK: - CollectionView DataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.numberOfSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collection.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath)
        
        let label = cell.viewWithTag(1) as! UILabel
        label.text = self.collectionData[indexPath.row] as? String
        label.textColor = UIColor(hexString: Colors.Default.rawValue)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(hexString: Colors.Default.rawValue)?.cgColor
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = self.collection.cellForItem(at: indexPath)
        
        if let modelType = self.modelType {
            switch modelType {
            case .LPII:
                let label = cell?.viewWithTag(1) as! UILabel
                self.delegate?.didSelectItemAt(label: label)
            default:
                break
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = self.collection.cellForItem(at: indexPath)
        
        if let modelType = self.modelType {
            switch modelType {
            case .LPII:
                let label = cell?.viewWithTag(1) as! UILabel
                self.delegate?.didDeselectItemAt(label: label)
            default:
                break
            }
        }
    }

}

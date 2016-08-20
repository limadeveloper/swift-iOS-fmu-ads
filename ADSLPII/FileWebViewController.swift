//
//  FileWebViewController.swift
//  ADSLPII
//
//  Created by John Lima on 20/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class FileWebViewController: UIViewController, UIWebViewDelegate {

    // MARK: - Properties
    @IBOutlet weak var webView: UIWebView!
    
    private var file: String?
    private var textTitle: String?
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
        self.getData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        UserDefaults.deleteObject(forKey: .File)
        UserDefaults.deleteObject(forKey: .Title)
    }
    
    // MARK: - Methods
    private func updateUI() {
        
        self.file = UserDefaults.getObject(forKey: .File) as? String
        self.textTitle = UserDefaults.getObject(forKey: .Title) as? String
        
        if let title = self.textTitle {
            self.title = title
        }else {
            self.title = Title.WebFile.rawValue
        }
        
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.back))
        self.navigationItem.rightBarButtonItem = button
    }
    
    private func getData() {
        
        if let file = self.file {
            
            App.isNetworkActivityIndicatorVisible = true
            
            DispatchQueue.main.async { [weak self] in
                
                if let bundle = Bundle.main.path(forResource: file, ofType:"pdf") {
                    let pdf = URL(fileURLWithPath: bundle)
                    let request = URLRequest(url: pdf)
                    self?.webView.loadRequest(request)
                }else {
                    let ok = UIAlertAction(title: ButtonTitle.Ok.rawValue, style: .destructive) { [weak self] (action) in
                        self?.back()
                    }
                    UIAlertController.createAlert(title: Message.Error.rawValue, message: Message.FileNoFound.rawValue, style: .alert, actions: [ok], target: self, isPopover: false, buttonItem: nil)
                }
                
                App.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    @objc private func back() {
        self.dismiss(animated: true, completion: nil)
    }

}

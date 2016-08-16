//
//  NavigationViewController.swift
//  ADSLPII
//
//  Created by John Lima on 13/08/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = UIColor(hexString: Colors.Default.rawValue)
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17), NSForegroundColorAttributeName: UIColor.white]
    }

}

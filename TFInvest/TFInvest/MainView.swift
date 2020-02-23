//
//  ViewController.swift
//  TFInvest
//
//  Created by Михаил Борисов on 23.02.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import AuthFramework

class MainView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AuthView.shared.test()
        // Do any additional setup after loading the view.
    }

}

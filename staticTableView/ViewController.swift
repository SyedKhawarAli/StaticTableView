//
//  ViewController.swift
//  staticTableView
//
//  Created by Khawar Shah on 21.11.2022.
//

import UIKit

class ViewController: UIViewController {

    let tableViewController = StaticTableViewWithEnum(style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableViewController.view)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableViewController.view.frame = view.safeAreaLayoutGuide.layoutFrame
    }


}


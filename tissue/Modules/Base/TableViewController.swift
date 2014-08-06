//
//  TableViewController.swift
//  tissue
//
//  Created by Alex Fish on 7/2/14.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var repo: Repo
    var data: [AnyObject] = []

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.repo = Repo()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder!) {
        self.repo = Repo()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitle()
        setupTableView()

        getData({
            self.tableView.reloadData()
        })
    }

    func setupTitle() {
        self.title = NSString()
    }

    func setupTableView() {
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    func getData(completionHandler: () -> Void) {
    }
}

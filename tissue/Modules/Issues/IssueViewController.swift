//
//  IssueViewController.swift
//  tissue
//
//  Created by Alex Fish on 07/06/2014.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

class IssueViewController: UITableViewController {

    var issues: Issue[] = []
    let repo = Repo(id: "CocoaPods/Core")

    // #pragma mark - Init

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitle()
        setupTableView()
        getIssues()
    }

    // #pragme mark - Setup

    func setupTitle() {
        self.title = repo.id
    }

    func setupTableView() {
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    func getIssues() {
        let client: Client = Client()

        client.getIssues(repo, { issues, error in
            if issues {
                self.issues = issues
                self.tableView.reloadData()
            } else {
                UIAlertView(title: "Error", message: "Error loading issues", delegate: nil, cancelButtonTitle: "Ok").show()
            }
        })
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.issues.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        if indexPath!.row < self.issues.count  {
            let issue: Issue = self.issues[indexPath!.row]
            cell.text = "#\(issue.id) - \(issue.title)"
        }

        return cell
    }
}

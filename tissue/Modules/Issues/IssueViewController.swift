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
    let repo = Repo(id: "CocoaPods/Core", title: "Hello")

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitle()
        setupTableView()

        getIssues({
            self.tableView.reloadData()
        })
    }

    func setupTitle() {
        self.title = repo.id
    }

    func setupTableView() {
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    func getIssues(completionHandler: () -> Void) {
        let client: Client = Client(repo: self.repo)

        client.getObjects(Issue.self, { issues in
            self.issues = issues as Issue[]
            completionHandler()
        })
    }
}

extension IssueViewController : UITableViewDataSource {

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

//
//  IssueViewController.swift
//  tissue
//
//  Created by Alex Fish on 07/06/2014.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

class IssueViewController: TableViewController {

    override func setupTitle() {
        self.title = repo.id
    }

    override func getData(completionHandler: () -> Void) {
        let client: Client = Client(repo: self.repo)

        client.getObjects(Issue.self, { issues in
            self.data = issues
            completionHandler()
        })
    }
}

extension IssueViewController : UITableViewDataSource {

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        if indexPath!.row < self.data.count  {
            let issue: Issue = self.data[indexPath!.row] as Issue
            cell.text = "#\(issue.id) - \(issue.title)"
        }

        return cell
    }
}

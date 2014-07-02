//
//  RepoViewController.swift
//  tissue
//
//  Created by Alex Fish on 7/2/14.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

class RepoViewController: TableViewController {

    override func setupTitle() {
        self.title = "Repositories"
    }
    
    override func getData(completionHandler: () -> Void) {
        let client: Client = Client()

        client.getObjects(Repo.self, { objects in
            self.data = objects as Repo[]
            completionHandler()
        })
    }
}

extension RepoViewController : UITableViewDataSource {

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        if indexPath!.row < self.data.count  {
            let repo: Repo = self.data[indexPath!.row] as Repo
            cell.text = repo.title
        }

        return cell
    }
}

extension RepoViewController : UITableViewDelegate {

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let repo = self.data[indexPath.row] as Repo
        let issueViewController = IssueViewController(nibName: nil, bundle: nil)
        issueViewController.repo = repo

        self.navigationController.pushViewController(issueViewController, animated: true)
    }
}

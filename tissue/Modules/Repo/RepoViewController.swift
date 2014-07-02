//
//  RepoViewController.swift
//  tissue
//
//  Created by Alex Fish on 7/2/14.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

class RepoViewController: UITableViewController {

    var repos: Repo[] = []

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitle()
        setupTableView()

        getRepos({
            self.tableView.reloadData()
        })
    }

    func setupTitle() {
        self.title = "Repositories"
    }

    func setupTableView() {
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    func getRepos(compleitionHandler: () -> Void) {
        let client: Client = Client()

        client.getObjects(Repo.self, { objects in
            self.repos = objects as Repo[]
            compleitionHandler()
        })
    }
}

extension RepoViewController : UITableViewDataSource {

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        if indexPath!.row < self.repos.count  {
            let repo: Repo = self.repos[indexPath!.row]
            cell.text = repo.title
        }

        return cell
    }
}

extension RepoViewController : UITableViewDelegate {

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let repo = self.repos[indexPath.row]
        let issueViewController = IssueViewController(nibName: nil, bundle: nil)
        issueViewController.repo = repo

        self.navigationController.pushViewController(issueViewController, animated: true)
    }
}

//
//  RepoViewController.swift
//  tissue
//
//  Created by Alex Fish on 7/1/14.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        performSegueWithIdentifier("IssueSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

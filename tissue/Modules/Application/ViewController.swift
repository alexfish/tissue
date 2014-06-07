//
//  ViewController.swift
//  tissue
//
//  Created by Alex Fish on 6/4/14.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let repo: Repo = Repo(id: "alexfish/yolo")
        let client: Client = Client()

        client.issues(repo, {
            println($0)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


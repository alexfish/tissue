//
//  Client.swift
//  tissue
//
//  Created by Alex Fish on 05/06/2014.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

class Client: NSObject {

    let queue: NSOperationQueue = NSOperationQueue()

    func issues(repo: Repo) {
        let url: NSURL = NSURL(string: "https://api.github.com/repos/\(repo.id)/issues")
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)

        urlRequest.HTTPMethod = "GET"

        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue, completionHandler: {response, data, error in
            let json : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
            println("json: \(json)")
        })
    }
}

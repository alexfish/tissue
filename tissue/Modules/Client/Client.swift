//
//  Client.swift
//  tissue
//
//  Created by Alex Fish on 05/06/2014.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

struct ClientHTTPMethod {
    static let GET  = "GET"
    static let POST = "POST"
}

struct ClientURL {
    static let GitHub = NSURL(string: "https://api.github.com/")
}

class Client: NSObject {

    let queue = NSOperationQueue()

    func getURL(url: NSURL, completionHandler: (json: AnyObject!, error: NSError!) -> Void) {
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)

        urlRequest.HTTPMethod = ClientHTTPMethod.GET

        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue, completionHandler: {response, data, error in
            if error {
                completionHandler(json: nil, error: error)
            } else {
                let (response: AnyObject!, error: NSError!) = Parser.parseJSON(data)
                completionHandler(json: response, error: error)
            }
        })
    }
}

extension Client {

    func getIssues(repo: Repo, issues: (Issue[]) -> Void) {
        let issuesPath = "repos/\(repo.id)/issues"
        let url = NSURL(string: issuesPath, relativeToURL: ClientURL.GitHub)

        getURL(url, {
            if !$1 {
                let json : AnyObject! = $0
                issues([])
            }
        })
    }

}
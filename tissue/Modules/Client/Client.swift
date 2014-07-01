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
    var timeoutInterval: NSTimeInterval

    init(timeout: NSTimeInterval) {
        self.timeoutInterval = timeout
        super.init()
    }

    convenience init() {
        self.init(timeout: 30)
    }

    func getURL(url: NSURL, completionHandler: (json: AnyObject!, error: NSError!) -> Void) {
        self.toggleActicityIndicator()

        let urlRequest: NSURLRequest = self.urlGETRequest(url)
        let parser = Parser()

        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue, completionHandler: {response, data, error in
            self.toggleActicityIndicator()

            if error {
                completionHandler(json: nil, error: error)
            } else {
                let (response: AnyObject!, error: NSError!) = parser.parseJSON(data)
                completionHandler(json: response, error: error)
            }
        })
    }

    func urlGETRequest(url: NSURL) -> NSURLRequest {
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)

        urlRequest.HTTPMethod = ClientHTTPMethod.GET
        urlRequest.timeoutInterval = timeoutInterval

        return urlRequest
    }

    func toggleActicityIndicator() {
        let application: UIApplication = UIApplication.sharedApplication()
        application.networkActivityIndicatorVisible = !application.networkActivityIndicatorVisible
    }
}

extension Client {

    func issues(repo: Repo, completionHandler: (issues: Issue[]!) -> Void) {

        let parser = IssueParser()
        let url = NSURL(string: repo.issuesAPIPath(), relativeToURL: ClientURL.GitHub)

        getURL(url, { response, error in
            let issues = IssueParser.parseIssues(response as NSArray)

            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(issues: issues)
            })
        })
    }
}
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

        let application: UIApplication = UIApplication.sharedApplication()
        application.networkActivityIndicatorVisible = true

        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue, completionHandler: {response, data, error in

            application.networkActivityIndicatorVisible = false

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

    func getIssues(repo: Repo, completionHandler: (issues: Issue[]!, error: NSError!) -> Void) {

        let parserError = NSError(domain: ParserError.domain, code: ParserError.code, userInfo: ParserError.userInfo)
        let issuesPath = "repos/\(repo.id)/issues"
        let url = NSURL(string: issuesPath, relativeToURL: ClientURL.GitHub)

        getURL(url, {
            if !$1 {
                let json : AnyObject! = $0

                dispatch_async(dispatch_get_main_queue(), {
                    if let issues = IssueParser.parseIssues(json as NSArray) {
                        completionHandler(issues: issues, error: nil)
                    } else {
                        completionHandler(issues: nil, error: parserError)
                    }
                })
            }
        })
    }

}
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

struct ClientBaseURL {
    static let GitHubAPI = NSURL(string: "https://api.github.com/")
}

class Client: NSObject {

    let queue = NSOperationQueue()

    func getURL(url: NSURL, completionHandler: (json: AnyObject!, error: NSError!) -> Void) {
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)

        urlRequest.HTTPMethod = ClientHTTPMethod.GET

        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue, completionHandler: {response, data, error in
            if let json : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) {
                completionHandler(json: json, error: nil)
            } else {
                completionHandler(json: nil, error: NSError())
            }
        })
    }
}

extension Client {

    func issues(repo: Repo, issues: (Issue[]) -> Void) {
        let url = NSURL(string: "repos/\(repo.id)/issues", relativeToURL: ClientBaseURL.GitHubAPI)

        getURL(url, {
            let json = $0

            issues([])
        })
    }

}
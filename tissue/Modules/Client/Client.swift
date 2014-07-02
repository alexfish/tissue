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
    let repo: Repo

    init(timeout: NSTimeInterval) {
        self.timeoutInterval = timeout
        self.repo = Repo()

        super.init()
    }

    init(repo: Repo, timeout: NSTimeInterval) {
        self.timeoutInterval = timeout
        self.repo = repo

        super.init()
    }

    convenience init(repo: Repo) {
        self.init(repo: repo, timeout: 30)
    }

    convenience init() {
        self.init(timeout: 30)
    }

    func getURL(url: NSURL, completionHandler: (json: AnyObject!, error: NSError!) -> Void) {
        self.toggleActicityIndicator()

        let urlRequest = self.urlGETRequest(url)
        let parser = Parser()

        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue, completionHandler: {response, data, error in
            self.toggleActicityIndicator()

            let (response: AnyObject!, error: NSError!) = parser.parseJSON(data)
            completionHandler(json: response, error: error)
        })
    }

    func getObjects(type: AnyClass, completionHandler: (objects: AnyObject[]!) -> Void) {
        let parser = Parser.parser(type)

        getURL(self.repo.url(type), { response, error in
            let objects = parser.parseObjects(response as NSArray)

            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(objects: objects)
            })
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
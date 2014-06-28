//
//  Repo.swift
//  tissue
//
//  Created by Alex Fish on 05/06/2014.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

class Repo: Model {

    func issuesAPIPath() -> String {
        return "repos/\(self.id)/issues"
    }
}

//
//  Repository.swift
//  GithubSearchRepositories
//
//  Created by Vadim Denisov on 28/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import ObjectMapper

class Repository: Mappable {
    var identifier: Int!
    var language: String!
    var url: String!
    var name: String!
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        identifier <- map["id"]
        language <- map["language"]
        url <- map["url"]
        name <- map["name"]
    }
}

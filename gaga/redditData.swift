//
//  redditData.swift
//  
//
//  Created by User17 on 2020/5/22.
//

import Foundation
struct redditData: Identifiable {
    var id: String
    var title: String
    var author: String
    var url: String
    var imurl: String
    var score: String
    var selftext: String
    var num_comments : Int
}

struct redditAbout: Identifiable {
    var id: String
    var banner : String
    var icon : String
    var public_description : String
    var display_name : String
    var accounts_active : Int
    var subscribers : Int
    var description : String
}

struct redditRules: Identifiable {
    var id : Int
    var description : String
    var short_name : String
    var violation_reason : String
}

struct redditMod: Identifiable {
    var id : String
    var name : String
}

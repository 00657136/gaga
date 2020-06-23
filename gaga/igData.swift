//
//  igData.swift
//  gaga
//
//  Created by User17 on 2020/6/23.
//  Copyright © 2020 NTOU. All rights reserved.
//

import Foundation

struct instagramProfileData : Identifiable {
    var id : String
    var profile_pic_url_hd : String
    var username : String
    var is_verified : Bool
    var edge_followed_by : Int
    var edge_follow : Int
    var full_name : String
    var biography : String
    var external_url : String
    var edge_owner_to_timeline_media_postcount : Int
}

struct instagramPostData : Identifiable {
    var id : String
    var display_url : String
    var text : String
    var comment : Int
    var liked : Int
    var thumbnail : String
}

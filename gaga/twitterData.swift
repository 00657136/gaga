//
//  twitterData.swift
//  
//
//  Created by User17 on 2020/6/3.
//

import Foundation
struct twitterProfileData: Identifiable {
    var id: String
    var name: String
    var screen_name: String
    var description: String
    var url: String
    var friends_count: String
    var followers_count: String
    var profile_image_url_https: String
    var profile_banner_url: String
}

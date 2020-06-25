//
//  youtubeData.swift
//  gaga
//
//  Created by User17 on 2020/6/24.
//  Copyright © 2020 NTOU. All rights reserved.
//

import Foundation

struct youtubePlaylistData : Identifiable {
    var id : String
    var title : String
    var thumbnail : String
    var channelTitle : String
    var publishedAt : String
    var videoId : String
}

struct youtubeChannelData :  Identifiable{
    var id : String
    var bannerMobileExtraHdImageUrl : String
    var thumbnails : String
    var title : String
    var subscriberCount : String
    var description : String
    var publishedAt : String
    var viewCount : String
    var videoCount : String
}

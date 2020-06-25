//
//  youtubeVideoUIView.swift
//  gaga
//
//  Created by User17 on 2020/6/25.
//  Copyright © 2020 NTOU. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit
struct youtubeVideoUIView: View {
    var videoId : String
    var body: some View {
            wkWebView(url: "https://www.youtube.com/watch?v="+videoId)
                .frame(width: UIScreen.main.bounds.width)
        
    }
}

struct youtubeVideoUIView_Previews: PreviewProvider {
    static var previews: some View {
        youtubeVideoUIView(videoId: "")
    }
}


/*
 https://www.googleapis.com/youtube/v3/videos?id=Fc2qWBIToKU&part=snippet&key=AIzaSyA2zjS7yzt4mgfHruaa-pnWCGi9xHf5KTw
 */

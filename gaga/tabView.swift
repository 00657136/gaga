//
//  tabView.swift
//  gaga
//
//  Created by User17 on 2020/6/10.
//  Copyright © 2020 NTOU. All rights reserved.
//

import SwiftUI

struct tabView: View {
    var body: some View {
        TabView{
            youtubeUIView().tabItem{
                Image("youtube")
                Text("Youtube")
            }
            twitterUIView().tabItem{
                Image("twitter")
                Text("Twitter")
            }
            spotifyUIView().tabItem{
                Image("spotify")
                Text("Spotify")
            }
            redditUIView().tabItem{
                Image("reddit")
                Text("Reddit")
            }
            igUIView().tabItem{
                Image("ig")
                Text("Instagram")
            }
            
        }.accentColor(.black)
    }
}

struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView()
    }
}

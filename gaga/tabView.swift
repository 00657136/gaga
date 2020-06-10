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
            twitterUIView().tabItem{
                Image("twitter")
                Text("Twitter")
            }
            redditUIView().tabItem{
                Image("reddit")
                Text("Reddit")
            }
        }
    }
}

struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView()
    }
}

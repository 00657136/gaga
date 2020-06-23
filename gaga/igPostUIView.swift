//
//  igPostUIView.swift
//  gaga
//
//  Created by User17 on 2020/6/24.
//  Copyright © 2020 NTOU. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct igPostUIView: View {
    @ObservedObject var results = getinstagramProfileData()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            ForEach(results.data){result in
                VStack(alignment: .leading, spacing: 10){
                    HStack(alignment: .center, spacing: 10){
                        ZStack{
                            Circle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 74/255, green: 55/255, blue: 222/255), Color.init(red: 244/255, green: 191/255, blue: 102/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                                .frame(width:UIScreen.main.bounds.width/10+3,height:UIScreen.main.bounds.width/10+3)
                            WebImage(url: URL(string: result.profile_pic_url_hd)!)
                                .resizable()
                                .scaledToFit()
                                .frame(width:UIScreen.main.bounds.width/10,height: UIScreen.main.bounds.width/10)
                                .cornerRadius(UIScreen.main.bounds.width/10)
                        }
                        HStack(alignment: .center, spacing: 5){
                            Text(result.username)
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                            if result.is_verified == true{
                                Image("verified")
                                .resizable()
                                .scaledToFit()
                                .frame(width:UIScreen.main.bounds.width/25,height: UIScreen.main.bounds.width/25)
                            }
                        }
                        Spacer()
                    }.padding(.horizontal)
                }.padding(.vertical)
            }
            
            Text("hi")
        }
    }
}

struct igPostUIView_Previews: PreviewProvider {
    static var previews: some View {
        igPostUIView()
    }
}

// https://www.instagram.com/p/CBLoGTZFPgL/?__a=1

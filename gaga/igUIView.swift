//
//  igUIView.swift
//  gaga
//
//  Created by User17 on 2020/6/21.
//  Copyright © 2020 NTOU. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct igUIView: View {
    @ObservedObject var results = getinstagramProfileData()
    @ObservedObject var posts = getinstagramPostData()
    @State private var show = false
    
    var body: some View {
            let collec = posts.data.collection(into: 3)
            return NavigationView{
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(results.data){result in
                        VStack(alignment: .leading, spacing: 10){
                            //第一行 頭貼 id 勾勾 貼文數 粉絲 追隨
                            HStack(alignment: .center, spacing: 30){
                                ZStack{
                                    Circle()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 74/255, green: 55/255, blue: 222/255), Color.init(red: 244/255, green: 191/255, blue: 102/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                                        .frame(width:UIScreen.main.bounds.width/5+8.5,height:UIScreen.main.bounds.width/5+8.5)
                                    WebImage(url: URL(string: result.profile_pic_url_hd)!)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.width/5)
                                        .cornerRadius(UIScreen.main.bounds.width/5)
                                }
                                VStack(alignment: .leading, spacing: 10){
                                    HStack(alignment: .center, spacing: 5){
                                        Text(result.username)
                                            .fontWeight(.bold)
                                            .font(.system(size: 20))
                                        if result.is_verified == true{
                                            Image("verified")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:UIScreen.main.bounds.width/25,height: UIScreen.main.bounds.width/25)
                                        }
                                    }
                                    HStack(spacing: 20){
                                        VStack(alignment: .center){
                                            Text("\(result.edge_owner_to_timeline_media_postcount)")
                                                .fontWeight(.bold)
                                                .font(.system(size: 15))
                                            Text("貼文數")
                                                .font(.system(size: 13))
                                        }
                                        VStack(alignment: .center){
                                            Text("\(result.edge_followed_by)")
                                                .fontWeight(.bold)
                                                .font(.system(size: 15))
                                            Text("粉絲人數")
                                                .font(.system(size: 13))
                                        }
                                        VStack(alignment: .center){
                                            Text("\(result.edge_follow)")
                                                .fontWeight(.bold)
                                                .font(.system(size: 15))
                                            Text("追蹤中")
                                                .font(.system(size: 13))
                                        }
                                        Spacer()
                                    }
                                }
                            }.padding(.horizontal)
                            //全名 自傳 外部連結
                             VStack(alignment: .leading, spacing: 5){
                                Text(result.full_name)
                                    .fontWeight(.bold)
                                Text(result.biography)
                                    .font(.system(size: 13))
                                Text(result.external_url)
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(red: 0.108, green: 0.586, blue: 0.881)).onTapGesture {
                                        self.show.toggle()
                                        
                                    }.sheet(isPresented: self.$show){
                                        SafariView(url: URL(string: result.external_url)!)
                                    }
                            }.padding(.horizontal)
                            
                        }.padding(.vertical)
                    }
                    ForEach(0..<collec.count){ row in
                        HStack{
                            ForEach(collec[row]){ collecs in
                                NavigationLink(destination: igPostUIView()){
                                    WebImage(url: URL(string: collecs.thumbnail)!)
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:UIScreen.main.bounds.width/3,height: UIScreen.main.bounds.width/3)
                                }
                            }
                        }
                    }
                }.navigationBarTitle("Instagram",displayMode: .inline)
            }//.edgesIgnoringSafeArea(.top)
            
        
    }
}

struct igUIView_Previews: PreviewProvider {
    static var previews: some View {
        igUIView()
    }
}





class getinstagramProfileData : ObservableObject {
    @Published var data = [instagramProfileData]()
    init(){
        let url = "https://www.instagram.com/ladygaga/?__a=1"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            let id = json["graphql"]["user"]["id"].stringValue
            let profile_pic_url_hd = json["graphql"]["user"]["profile_pic_url_hd"].stringValue
            let username = json["graphql"]["user"]["username"].stringValue
            let is_verified = json["graphql"]["user"]["is_verified"].boolValue
            let edge_followed_by = json["graphql"]["user"]["edge_followed_by"]["count"].intValue
            let edge_follow = json["graphql"]["user"]["edge_follow"]["count"].intValue
            let full_name = json["graphql"]["user"]["full_name"].stringValue
            let biography = json["graphql"]["user"]["biography"].stringValue
            let external_url = json["graphql"]["user"]["external_url"].stringValue
            let edge_owner_to_timeline_media_postcount = json["graphql"]["user"]["edge_owner_to_timeline_media"]["count"].intValue
            DispatchQueue.main.async {
                self.data.append(instagramProfileData(id: id, profile_pic_url_hd: profile_pic_url_hd, username: username, is_verified: is_verified, edge_followed_by: edge_followed_by, edge_follow: edge_follow, full_name: full_name, biography: biography, external_url: external_url, edge_owner_to_timeline_media_postcount: edge_owner_to_timeline_media_postcount))
            }
        }.resume()
        
        
    }
}

class getinstagramPostData: ObservableObject {
    @Published var data = [instagramPostData]()
    init(){
        let url = "https://www.instagram.com/ladygaga/?__a=1"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            let edges = json["graphql"]["user"]["edge_owner_to_timeline_media"]["edges"].array!
            for i in edges{
                let id = i["node"]["id"].stringValue
                let display_url = i["node"]["display_url"].stringValue
                let text = i["node"]["edge_media_to_caption"]["edges"][0]["node"]["text"].stringValue
                let comment = i["node"]["edge_media_to_comment"]["count"].intValue
                let liked = i["node"]["edge_liked_by"]["count"].intValue
                let thumbnail = i["node"]["thumbnail_resources"][4]["src"].stringValue
                DispatchQueue.main.async {
                    self.data.append(instagramPostData(id: id, display_url: display_url, text: text, comment: comment, liked: liked, thumbnail: thumbnail))
                }
            }
            
        }.resume()
        
        
    }
}

extension Array{
    func collection(into size: Int) -> [[Element]]{
        return stride(from: 0, to: count, by: size).map{
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

//CBLoGTZFPgL https://www.instagram.com/p/CBLoGTZFPgL/media/?size=l

/*
 
 https://scontent.cdninstagram.com/v/t50.2886-16/103435192_120999152963452_8029942739370787312_n.mp4?_nc_ht=scontent.cdninstagram.com&_nc_cat=104&_nc_ohc=RwIuzniOYSoAX-WYEbP&oe=5EF4532B&oh=8cd243f37b91145cf317ed362c29b567
 
 https://scontent-tpe1-1.cdninstagram.com/v/t51.2885-15/e35/102665162_675283306586646_3411576164114691128_n.jpg?_nc_ht=scontent-tpe1-1.cdninstagram.com&_nc_cat=1&_nc_ohc=NNFXZQ1JefEAX_iRsc2&oh=50256669111951f3502276f90d1bc9f1&oe=5EF3D6F3
 
 <video class="tWeCl" controls="" controlslist="nodownload" playsinline="" poster="https://scontent-tpe1-1.cdninstagram.com/v/t51.2885-15/e35/102665162_675283306586646_3411576164114691128_n.jpg?_nc_ht=scontent-tpe1-1.cdninstagram.com&amp;_nc_cat=1&amp;_nc_ohc=NNFXZQ1JefEAX_iRsc2&amp;oh=647b6b16013955d9ffd4836a916670e6&amp;oe=5EF47FB3" preload="metadata" type="video/mp4" src="https://scontent-tpe1-1.cdninstagram.com/v/t50.2886-16/103435192_120999152963452_8029942739370787312_n.mp4?_nc_ht=scontent-tpe1-1.cdninstagram.com&amp;_nc_cat=104&amp;_nc_ohc=RwIuzniOYSoAX-Y_Ubm&amp;oe=5EF4532B&amp;oh=b042a8245dc3f1acc4aa86c9199ad2df"></video>
 
 
 
 
 
 */



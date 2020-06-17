//
//  spotifyUIView.swift
//  gaga
//
//  Created by User17 on 2020/6/16.
//  Copyright © 2020 NTOU. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct spotifyUIView: View {
    @ObservedObject var results = getspotifyProfileData()
    var body: some View {
        ScrollView{
        
            VStack(alignment: .leading){
                ForEach(results.data){result in
                    ZStack{
                        WebImage(url: URL(string: result.imgurl )!)
                        .resizable()
                        .scaledToFill()
                        .frame(width:UIScreen.main.bounds.width)
                        .blur(radius: 5)
                    VStack(alignment: .center,spacing: 5){
                        WebImage(url: URL(string: result.imgurl )!)
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/4)
                            .cornerRadius(UIScreen.main.bounds.width/4)
                        Text(result.name)
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .foregroundColor(Color(.white))
                        HStack(alignment: .center){
                            Image("genres")
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/25)
                            Text("類型:" + result.genres).fontWeight(.medium).font(.system(size: 18)).foregroundColor(Color(.white)).fixedSize()
                        }
                        HStack(alignment: .center){
                            Image("popularity")
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/25)
                            Text("人氣: \(result.popularity)/100").fontWeight(.medium).font(.system(size: 18)).foregroundColor(Color(.white)).fixedSize()
                        }
                        HStack(alignment: .center){
                            Image("follower")
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/25)
                            Text("關注者: \(result.followers)").fontWeight(.medium).font(.system(size: 18)).foregroundColor(Color(.white)).fixedSize()
                        }
                    }.padding(.top,UIScreen.main.bounds.height/5)
                }
                }
            }
        
        
        }.background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 207/255, green: 247/255, blue: 177/255), Color.init(red: 85/255, green: 228/255, blue: 201/255)]), startPoint: UnitPoint(x: 0, y: 1), endPoint: UnitPoint(x: 1, y: 0)))
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct spotifyUIView_Previews: PreviewProvider {
    static var previews: some View {
        spotifyUIView()
    }
}


class getspotifyProfileData: ObservableObject {
    
    @Published var data = [spotifyProfileData]()
    init(){
        var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer BQAStfUcWesaNgY04x3zD7Pax52b0pW_LuKuboNLPNAxCl13n5-71c-pwvxJM7yoaej7w2jIP98hArm9SuCh0nO7C6VHtR2xzbywsQoOvPqT9PnTl3UMcHnqKjzR46jT4hTPLL4WlO4QtIkSmpg9411BXwyt", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request){(data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            let id = json["id"].stringValue
            let name = json["name"].stringValue
            let imgurl = json["images"][0]["url"].stringValue
            let popularity = json["popularity"].intValue
            let followers = json["followers"]["total"].intValue
            let genres0 = json["genres"][0].stringValue
            let genres1 = json["genres"][1].stringValue
            let genres = genres0+","+genres1
            DispatchQueue.main.async {
                self.data.append(spotifyProfileData(id: id, name: name, imgurl: imgurl, popularity: popularity,followers: followers,genres:genres))
            }
        }.resume()
        
        
    }
}

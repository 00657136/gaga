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
    @ObservedObject var Albums = getspotifyAlbumData()
    @ObservedObject var relatedArtists = getspotifyRelatedArtistsProfileData()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
        
           
                //profile******************************
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
                //profile******************************
                
                //album******************************
            Text("歷年專輯")
            .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.init(red: 187, green: 185, blue: 172))
            
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                    ForEach(Albums.data){album in
                        HStack{
                            WebImage(url: URL(string: album.imgurl )!)
                            .resizable()
                            .scaledToFit()
                                .frame(width:UIScreen.main.bounds.width/2.5).cornerRadius(25)
                            
                            Spacer()
                            VStack(alignment: .leading,spacing:10){
                                HStack{
                                    Image("date")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:UIScreen.main.bounds.width/25)
                                    Text("發行日期：")
                                        .font(.system(size: 10))
                                    Text(album.release_date)
                                        .font(.system(size: 10))
                                }
                                HStack{
                                    Image("music")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:UIScreen.main.bounds.width/25)
                                    Text("歌曲數：")
                                        .font(.system(size: 10))
                                    Text("\(album.total_track)")
                                        .font(.system(size: 10))
                                }
                                HStack{
                                    Image("album")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:UIScreen.main.bounds.width/25)
                                    Text("專輯名稱：")
                                        .font(.system(size: 10))
                                    Text(album.name)
                                        .font(.system(size: 10))
                                        .padding(5)
                                        //.background(Color.white)
                                        .cornerRadius(5)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 2))
                                }
                            }
                        }.frame(width:UIScreen.main.bounds.width/1.2,height: 290)
                        .background(
                            Color.white.opacity(0.2).cornerRadius(25)
                                .rotation3DEffect(.init(degrees: 20), axis: (x:0,y:-1,z:0))
                                .padding(.vertical,35)
                                
                        )
                            .padding(.horizontal)
                    }
            }
                }
                //album******************************
                //relatedArtists*********************
            Text("相關歌手")
            .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.init(red: 187, green: 185, blue: 172))
            VStack(alignment: .leading){
            ForEach(relatedArtists.data){relatedArtist in
                HStack(alignment: .top,spacing: 20){
                     WebImage(url: URL(string: relatedArtist.imgurl )!)
                    .resizable().scaledToFit().frame(width:UIScreen.main.bounds.width/6,height: UIScreen.main.bounds.width/6).cornerRadius(UIScreen.main.bounds.width/6)
                       // .padding(30)
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(relatedArtist.name)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(Color(.black))
                        HStack(alignment: .center){
                            Image("genres")
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/25)
                            Text("類型:" + relatedArtist.genres).fontWeight(.medium).font(.system(size: 15)).foregroundColor(Color(.black)).fixedSize()
                        }
                        HStack(alignment: .center){
                            Image("popularity")
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/25)
                            Text("人氣: \(relatedArtist.popularity)/100").fontWeight(.medium).font(.system(size: 15)).foregroundColor(Color(.black)).fixedSize()
                        }
                        HStack(alignment: .center){
                            Image("follower")
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/25)
                            Text("關注者: \(relatedArtist.followers)").fontWeight(.medium).font(.system(size: 15)).foregroundColor(Color(.black)).fixedSize()
                        }
                    }
                }
                
            }
        }
                //relatedArtists*********************
        
        
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
        request.addValue("Bearer BQDfubLZ565XSVAEqiSbXuBhWBBlavkw69TMor6yS4lR3lPyzEirKzoh8RH_RwLkrQNX8oZ1THCABnAs1t_EFbh1zzRj7-rTaz4S6R6VW1m4LtRyvtiPKL2FHIPumGBkcrTGU3Ul1K4oKmqRN-HmrmkoulUW", forHTTPHeaderField: "Authorization")
        
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

class getspotifyAlbumData: ObservableObject {
    
    @Published var data = [spotifyAlbumData]()
    init(){
        
        
        var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms/albums")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer BQDfubLZ565XSVAEqiSbXuBhWBBlavkw69TMor6yS4lR3lPyzEirKzoh8RH_RwLkrQNX8oZ1THCABnAs1t_EFbh1zzRj7-rTaz4S6R6VW1m4LtRyvtiPKL2FHIPumGBkcrTGU3Ul1K4oKmqRN-HmrmkoulUW", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request){(data, _, err) in
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            let item = json["items"].array!
            for i in item{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy/MM/dd"
                let id = i["id"].stringValue
                let name = i["name"].stringValue
                let imgurl  = i["images"][0]["url"].stringValue
                let release_date0 = i["release_date"].stringValue
                let release_Date = dateFormatter.date(from: release_date0)
                let release_date = dateFormat.string(from: release_Date!)
                let total_track = i["total_tracks"].intValue
            DispatchQueue.main.async {
                self.data.append(spotifyAlbumData(id: id, name: name, imgurl: imgurl, release_date: release_date, total_track: total_track))
            }
        }
        }.resume()
        
        
    }
}

class getspotifyRelatedArtistsProfileData: ObservableObject {
    
    @Published var data = [spotifyProfileData]()
    init(){
        var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms/related-artists")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer BQDfubLZ565XSVAEqiSbXuBhWBBlavkw69TMor6yS4lR3lPyzEirKzoh8RH_RwLkrQNX8oZ1THCABnAs1t_EFbh1zzRj7-rTaz4S6R6VW1m4LtRyvtiPKL2FHIPumGBkcrTGU3Ul1K4oKmqRN-HmrmkoulUW", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request){(data, _, err) in
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            let artists = json["artists"].array!
            for i in artists{
                let id = i["id"].stringValue
                let name = i["name"].stringValue
                let imgurl = i["images"][0]["url"].stringValue
                let popularity = i["popularity"].intValue
                let followers = i["followers"]["total"].intValue
                let genres = i["genres"][0].stringValue
                DispatchQueue.main.async {
                    self.data.append(spotifyProfileData(id: id, name: name, imgurl: imgurl, popularity: popularity,followers: followers,genres:genres))
                }
            }
            
        }.resume()
        
        
    }
}
//  top tracks: https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms/top-tracks?country=TW


/*

let refreshToken = "AQCnSfyIOtgnD2xY-bINyEqwPnYeyYgiDVO665OfOz5FKeedZqQg5KZlNKaQUSu1nPZ2POD9PNYrgRfpz2oMSciz38Huj99_sDJc2CNt-eoes4Sl9XuSVhiYGEEnNnd8Rzc"
if let url = URL(string: " https://accounts.spotify.com/api/token"), let postData = "grant_type=refresh_token&refresh_token=\(refreshToken)".data(using: .utf8) {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("NDQ5OWZjZjRmYTQwNGZhM2E1YTlhNDNjYzljYzIyZmE6ZGMzYWMyOGJhNGMwNDEyMTlhYzAzMjk5MWM3YzNmMTg=", forHTTPHeaderField: "Authorization: Basic")
    request.httpBody = postData
}
 
*/

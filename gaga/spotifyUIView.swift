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
    @ObservedObject var TopTracks = getspotifyTrackData()
    @State private var show = false
    @State var url = ""
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
                
                //TopTracks****************************
            Text("熱門歌曲")
                .foregroundColor(Color(.black))
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.init(red: 187, green: 185, blue: 172))
            VStack(alignment: .leading, spacing: 10){
                ForEach(TopTracks.data){track in
                    HStack(alignment: .center, spacing: 20){
                        WebImage(url: URL(string: track.imgurl )!)
                        .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/6,height: UIScreen.main.bounds.width/6)
                        VStack(alignment: .leading, spacing: 5){
                            Text(track.name)
                                .foregroundColor(Color(.black))
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                            Text(track.artists)
                                .foregroundColor(Color(.black))
                                .font(.system(size: 15))
                        }
                        Spacer()
                        Button(action: {
                            self.url = track.external_urls
                            self.show.toggle()
                        }){
                            Image("play-button")
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/10,height: UIScreen.main.bounds.width/10)
                        }
                    }
                }.sheet(isPresented: self.$show){
                    SafariView(url: URL(string: self.url)!)
                }
            }.padding(.horizontal)
            
                //TopTracks****************************
            
                //album******************************
            Text("歷年專輯")
                .foregroundColor(Color(.black))
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
                                        .foregroundColor(Color(.black))
                                        .font(.system(size: 10))
                                    Text(album.release_date)
                                        .foregroundColor(Color(.black))
                                        .font(.system(size: 10))
                                }
                                HStack{
                                    Image("music")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:UIScreen.main.bounds.width/25)
                                    Text("歌曲數：")
                                        .foregroundColor(Color(.black))
                                        .font(.system(size: 10))
                                    Text("\(album.total_track)")
                                        .foregroundColor(Color(.black))
                                        .font(.system(size: 10))
                                }
                                HStack{
                                    Image("album")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:UIScreen.main.bounds.width/25)
                                    Text("專輯名稱：")
                                        .foregroundColor(Color(.black))
                                        .font(.system(size: 10))
                                    Text(album.name)
                                        .foregroundColor(Color(.black))
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
                .foregroundColor(Color(.black))
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.init(red: 187, green: 185, blue: 172))
            VStack(alignment: .leading,spacing: 10){
            ForEach(relatedArtists.data){relatedArtist in
                HStack(alignment: .top,spacing: 20){
                     WebImage(url: URL(string: relatedArtist.imgurl )!)
                    .resizable().scaledToFit().frame(width:UIScreen.main.bounds.width/6,height: UIScreen.main.bounds.width/6)
                        .cornerRadius(UIScreen.main.bounds.width/6)
                       
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(relatedArtist.name)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(Color(.black))
                        HStack(alignment: .center){
                            Image("genresB")
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/25)
                            Text("類型:" + relatedArtist.genres).fontWeight(.medium).font(.system(size: 15)).foregroundColor(Color(.black)).fixedSize()
                        }
                        HStack(alignment: .center){
                            Image("popularityB")
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/25)
                            Text("人氣: \(relatedArtist.popularity)/100").fontWeight(.medium).font(.system(size: 15)).foregroundColor(Color(.black)).fixedSize()
                        }
                        HStack(alignment: .center){
                            Image("followerB")
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/25)
                            Text("關注者: \(relatedArtist.followers)").fontWeight(.medium).font(.system(size: 15)).foregroundColor(Color(.black)).fixedSize()
                        }
                    }
                    Spacer()
                }
                
            }
            }.padding(.horizontal)
                //relatedArtists*********************
        
        
        }.background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 207/255, green: 247/255, blue: 177/255), Color.init(red: 85/255, green: 228/255, blue: 201/255)]), startPoint: UnitPoint(x: 0, y: 1), endPoint: UnitPoint(x: 1, y: 0)))
            .edgesIgnoringSafeArea(.top)
        
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
         
        let parameters = "grant_type=refresh_token&refresh_token=AQCnSfyIOtgnD2xY-bINyEqwPnYeyYgiDVO665OfOz5FKeedZqQg5KZlNKaQUSu1nPZ2POD9PNYrgRfpz2oMSciz38Huj99_sDJc2CNt-eoes4Sl9XuSVhiYGEEnNnd8Rzc"
        let postData =  parameters.data(using: .utf8)
        if let url = URL(string: "https://accounts.spotify.com/api/token"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
             request.addValue("Basic NDQ5OWZjZjRmYTQwNGZhM2E1YTlhNDNjYzljYzIyZmE6ZGMzYWMyOGJhNGMwNDEyMTlhYzAzMjk5MWM3YzNmMTg=", forHTTPHeaderField: "Authorization")
               request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
               request.addValue("__Host-device_id=AQBPwRuubEaHLe3qzncUC_qxhNi3w6W_sXdPNQenUVz1lXG86eZs3u2hW3kbO2RZEz7-XaJA9gE6J-ZHFpnGNlfS-n3BCM6aYe4; __Secure-TPASESSION=AQCz/AtmF0i7zemzOI63JpokY8izsrk2ImSVSTMRoV9wFeKzaJ3fo6PpoDMKHrlkARSTo8l56+mTXLbOHybt/hF9KwIxAZ4C11Q=; csrf_token=AQDysFWy0rN9M1GtLlb6eRbkaTuqNeRmyQmw5VIxjzUTAVHxYgmK41DZhtFdkivrgIZcEgbMBqQFFmDlGQ", forHTTPHeaderField: "Cookie")
            request.httpBody = postData
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                let json = try! JSON(data: data!)
                let token = json["access_token"].stringValue
               var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms")!,timeoutInterval: Double.infinity)
               request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
               
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
            }.resume()
        }
        
        
    }
}

class getspotifyAlbumData: ObservableObject {
    
    @Published var data = [spotifyAlbumData]()
    init(){
        
        
        let parameters = "grant_type=refresh_token&refresh_token=AQCnSfyIOtgnD2xY-bINyEqwPnYeyYgiDVO665OfOz5FKeedZqQg5KZlNKaQUSu1nPZ2POD9PNYrgRfpz2oMSciz38Huj99_sDJc2CNt-eoes4Sl9XuSVhiYGEEnNnd8Rzc"
        let postData =  parameters.data(using: .utf8)
        if let url = URL(string: "https://accounts.spotify.com/api/token"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
             request.addValue("Basic NDQ5OWZjZjRmYTQwNGZhM2E1YTlhNDNjYzljYzIyZmE6ZGMzYWMyOGJhNGMwNDEyMTlhYzAzMjk5MWM3YzNmMTg=", forHTTPHeaderField: "Authorization")
               request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
               request.addValue("__Host-device_id=AQBPwRuubEaHLe3qzncUC_qxhNi3w6W_sXdPNQenUVz1lXG86eZs3u2hW3kbO2RZEz7-XaJA9gE6J-ZHFpnGNlfS-n3BCM6aYe4; __Secure-TPASESSION=AQCz/AtmF0i7zemzOI63JpokY8izsrk2ImSVSTMRoV9wFeKzaJ3fo6PpoDMKHrlkARSTo8l56+mTXLbOHybt/hF9KwIxAZ4C11Q=; csrf_token=AQDysFWy0rN9M1GtLlb6eRbkaTuqNeRmyQmw5VIxjzUTAVHxYgmK41DZhtFdkivrgIZcEgbMBqQFFmDlGQ", forHTTPHeaderField: "Cookie")
            request.httpBody = postData
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                let json = try! JSON(data: data!)
                let token = json["access_token"].stringValue
               var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms/albums")!,timeoutInterval: Double.infinity)
               request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")

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
            }.resume()
        }
        
        
    }
}

class getspotifyRelatedArtistsProfileData: ObservableObject {
    
    @Published var data = [spotifyProfileData]()
    init(){
        
        let parameters = "grant_type=refresh_token&refresh_token=AQCnSfyIOtgnD2xY-bINyEqwPnYeyYgiDVO665OfOz5FKeedZqQg5KZlNKaQUSu1nPZ2POD9PNYrgRfpz2oMSciz38Huj99_sDJc2CNt-eoes4Sl9XuSVhiYGEEnNnd8Rzc"
        let postData =  parameters.data(using: .utf8)
        if let url = URL(string: "https://accounts.spotify.com/api/token"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
             request.addValue("Basic NDQ5OWZjZjRmYTQwNGZhM2E1YTlhNDNjYzljYzIyZmE6ZGMzYWMyOGJhNGMwNDEyMTlhYzAzMjk5MWM3YzNmMTg=", forHTTPHeaderField: "Authorization")
               request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
               request.addValue("__Host-device_id=AQBPwRuubEaHLe3qzncUC_qxhNi3w6W_sXdPNQenUVz1lXG86eZs3u2hW3kbO2RZEz7-XaJA9gE6J-ZHFpnGNlfS-n3BCM6aYe4; __Secure-TPASESSION=AQCz/AtmF0i7zemzOI63JpokY8izsrk2ImSVSTMRoV9wFeKzaJ3fo6PpoDMKHrlkARSTo8l56+mTXLbOHybt/hF9KwIxAZ4C11Q=; csrf_token=AQDysFWy0rN9M1GtLlb6eRbkaTuqNeRmyQmw5VIxjzUTAVHxYgmK41DZhtFdkivrgIZcEgbMBqQFFmDlGQ", forHTTPHeaderField: "Cookie")
            request.httpBody = postData
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                let json = try! JSON(data: data!)
                let token = json["access_token"].stringValue
               var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms/related-artists")!,timeoutInterval: Double.infinity)
               request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
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
            }.resume()
        }
        
        
    }
}

class getspotifyTrackData: ObservableObject {
    
    @Published var data = [spotifyTrackData]()
    init(){
        
        let parameters = "grant_type=refresh_token&refresh_token=AQCnSfyIOtgnD2xY-bINyEqwPnYeyYgiDVO665OfOz5FKeedZqQg5KZlNKaQUSu1nPZ2POD9PNYrgRfpz2oMSciz38Huj99_sDJc2CNt-eoes4Sl9XuSVhiYGEEnNnd8Rzc"
        let postData =  parameters.data(using: .utf8)
        if let url = URL(string: "https://accounts.spotify.com/api/token"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
             request.addValue("Basic NDQ5OWZjZjRmYTQwNGZhM2E1YTlhNDNjYzljYzIyZmE6ZGMzYWMyOGJhNGMwNDEyMTlhYzAzMjk5MWM3YzNmMTg=", forHTTPHeaderField: "Authorization")
               request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
               request.addValue("__Host-device_id=AQBPwRuubEaHLe3qzncUC_qxhNi3w6W_sXdPNQenUVz1lXG86eZs3u2hW3kbO2RZEz7-XaJA9gE6J-ZHFpnGNlfS-n3BCM6aYe4; __Secure-TPASESSION=AQCz/AtmF0i7zemzOI63JpokY8izsrk2ImSVSTMRoV9wFeKzaJ3fo6PpoDMKHrlkARSTo8l56+mTXLbOHybt/hF9KwIxAZ4C11Q=; csrf_token=AQDysFWy0rN9M1GtLlb6eRbkaTuqNeRmyQmw5VIxjzUTAVHxYgmK41DZhtFdkivrgIZcEgbMBqQFFmDlGQ", forHTTPHeaderField: "Cookie")
            request.httpBody = postData
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                let json = try! JSON(data: data!)
                let token = json["access_token"].stringValue
                var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms/top-tracks?country=TW")!,timeoutInterval: Double.infinity)
                request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")

                request.httpMethod = "GET"
                let session = URLSession(configuration: .default)
                session.dataTask(with: request){(data, _, err) in
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        return
                    }
                    
                    let json = try! JSON(data: data!)
                    let tracks = json["tracks"].array!
                    for i in tracks{
                        let id = i["id"].stringValue
                        let name = i["name"].stringValue
                        let imgurl  = i["album"]["images"][0]["url"].stringValue
                        let artistArr = i["artists"].array!
                        var artists = ""
                        for j in artistArr{
                            if artists == ""{
                                artists = j["name"].stringValue
                            }
                            else {
                                artists = artists + "," + j["name"].stringValue
                            }
                        }
                        let external_urls = i["external_urls"]["spotify"].stringValue
                    DispatchQueue.main.async {
                        self.data.append(spotifyTrackData(id: id, name: name, artists: artists, imgurl: imgurl, external_urls: external_urls))
                    }
                }
                }.resume()
         
         
            }.resume()
        }
        
        
    }
}



//  top tracks: https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms/top-tracks?country=TW

/*
 class getspotifyTrackData: ObservableObject {
     
     @Published var data = [spotifyTrackData]()
     init(){
         let token = test()
         var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms/top-tracks?country=TW")!,timeoutInterval: Double.infinity)
         request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")

         request.httpMethod = "GET"
         let session = URLSession(configuration: .default)
         session.dataTask(with: request){(data, _, err) in
             if err != nil{
                 
                 print((err?.localizedDescription)!)
                 return
             }
             
             let json = try! JSON(data: data!)
             let tracks = json["tracks"].array!
             for i in tracks{
                 let id = i["id"].stringValue
                 let name = i["name"].stringValue
                 let imgurl  = i["album"]["images"][0]["url"].stringValue
                 let artistArr = i["artists"].array!
                 var artists = ""
                 for j in artistArr{
                     if artists == ""{
                         artists = j["name"].stringValue
                     }
                     else {
                         artists = artists + "," + j["name"].stringValue
                     }
                 }
                 let external_urls = i["external_urls"]["spotify"].stringValue
             DispatchQueue.main.async {
                 self.data.append(spotifyTrackData(id: id, name: name, artists: artists, imgurl: imgurl, external_urls: external_urls))
             }
         }
         }.resume()
         
         
     }
 }
 

 

 class getspotifyRelatedArtistsProfileData: ObservableObject {
     
     @Published var data = [spotifyProfileData]()
     init(){
         let token = test()
         var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms/related-artists")!,timeoutInterval: Double.infinity)
         request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
         print(token)
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
 
 class getspotifyAlbumData: ObservableObject {
     
     @Published var data = [spotifyAlbumData]()
     init(){
         
         let token = test()
         var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms/albums")!,timeoutInterval: Double.infinity)
         request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")

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
 
 class getspotifyProfileData: ObservableObject {
     
     @Published var data = [spotifyProfileData]()
     init(){
         

         let token = test()
         var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/artists/1HY2Jd0NmPuamShAr6KMms")!,timeoutInterval: Double.infinity)
         request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
         
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
 
 */

//
//  twitterUIView.swift
//  gaga
//
//  Created by User17 on 2020/6/3.
//  Copyright © 2020 NTOU. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
struct twitterUIView: View {
    @ObservedObject var results = getteitterProfileData()
    @ObservedObject var tweetresults = gettweetData()
    var body: some View {
        ZStack(alignment: .top){
            Color(red: 0.081, green: 0.125, blue: 0.17).frame(minWidth: 0, maxWidth: .infinity)
            
            VStack{
        ForEach(results.data){result in
                VStack(alignment: .leading, spacing: 10){
                    
                    profileView(profile_banner_url: result.profile_banner_url, name: result.name, screen_name: result.screen_name, description: result.description, url: result.url, profile_image_url_https: result.profile_image_url_https, display_url: result.display_url)
                    HStack{
                        Text(result.friends_count+" 個跟隨中").foregroundColor(Color(.white)).fontWeight(.medium)
                        Text(result.followers_count+" 位跟隨者").foregroundColor(Color(.white)).fontWeight(.medium)
                    }.offset(x:10,y:-UIScreen.main.bounds.width/8+10)
            }
        }
            
                List(tweetresults.data){result in
                    VStack{
                        
                        VStack(alignment: .leading){
                        HStack(alignment: .top){

                            WebImage(url: URL(string: result.profile_image_url_https )!).resizable().scaledToFit().frame(width:UIScreen.main.bounds.width/6,height: UIScreen.main.bounds.width/6).cornerRadius(UIScreen.main.bounds.width/6)

                            VStack(alignment: .leading){
                                Text(result.name).fontWeight(.heavy)
                                Text(result.screen_name).foregroundColor(Color.gray).underline()
                                Text(result.text).fontWeight(.medium).frame(width: UIScreen.main.bounds.width*2/3)
                            }
                        }
                            //img
                            //fav & retweet
                        }
                        
                        
                        
                    }
                }
                
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}


struct twitterUIView_Previews: PreviewProvider {
    static var previews: some View {
        twitterUIView()
    }
}

class getteitterProfileData: ObservableObject {
    @Published var data = [twitterProfileData]()
    init(){
        var request = URLRequest(url: URL(string: "https://api.twitter.com/1.1/users/show.json?screen_name=ladygaga")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer AAAAAAAAAAAAAAAAAAAAANVMEwEAAAAAz5uoa0Uq3sPCioWj9Y2QXF1%2BIhY%3D7FaZvITYT2vdNYoZ7dHzYnHuyRJRwtxw6ooDLtzO2ymkBUD2sH", forHTTPHeaderField: "Authorization")
        request.addValue("personalization_id=\"v1_lrzacwVLE4YSmOX2j5NL0A==\"; guest_id=v1%3A159118165707713468", forHTTPHeaderField: "Cookie")

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
            let screen_name = json["screen_name"].stringValue
            let description = json["description"].stringValue
            let url = json["entities"]["url"]["urls"][0]["url"].stringValue
            let display_url = json["entities"]["url"]["urls"][0]["display_url"].stringValue
            let friends_count = json["friends_count"].stringValue
            let followers_count = json["followers_count"].stringValue
            var profile_image_url_https = json["profile_image_url_https"].stringValue
            profile_image_url_https = profile_image_url_https.replacingOccurrences(of: "_normal", with: "")
            let profile_banner_url = json["profile_banner_url"].stringValue
            DispatchQueue.main.async {
                self.data.append(twitterProfileData(id: id, name: name, screen_name: screen_name, description: description, url: url, friends_count: friends_count, followers_count: followers_count, profile_image_url_https: profile_image_url_https, profile_banner_url: profile_banner_url, display_url: display_url))
            }
        }.resume()
        
        
    }
}

class gettweetData: ObservableObject {
    @Published var data = [tweetData]()
    init(){
        var request = URLRequest(url: URL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=ladygaga&count=10")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer AAAAAAAAAAAAAAAAAAAAANVMEwEAAAAAz5uoa0Uq3sPCioWj9Y2QXF1%2BIhY%3D7FaZvITYT2vdNYoZ7dHzYnHuyRJRwtxw6ooDLtzO2ymkBUD2sH", forHTTPHeaderField: "Authorization")
        request.addValue("personalization_id=\"v1_lrzacwVLE4YSmOX2j5NL0A==\"; guest_id=v1%3A159118165707713468", forHTTPHeaderField: "Cookie")
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
               session.dataTask(with: request){(data, _, err) in
                   if err != nil{
                       print((err?.localizedDescription)!)
                       return
                   }
                   let json = try! JSON(data: data!)
                let array = json.array!
                for i in array {
                let id = i["id"].stringValue
                    let url = i["entities"]["urls"][0]["url"].stringValue
                    let name = i["user"]["name"].stringValue
                    let screen_name = i["user"]["screen_name"].stringValue
               var text = i["text"].stringValue
                    text = text.replacingOccurrences(of: url, with: "")
                let retweet_count = i["retweet_count"].stringValue
                let favorite_count = i["favorite_count"].stringValue
                    var profile_image_url_https = i["user"]["profile_image_url_https"].stringValue
                    profile_image_url_https = profile_image_url_https.replacingOccurrences(of: "_normal", with: "")
                   DispatchQueue.main.async {
                    self.data.append(tweetData(id: id,name: name,url: url,screen_name: screen_name, text: text, retweet_count: retweet_count, favorite_count: favorite_count, profile_image_url_https: profile_image_url_https))
                   }
        }
               }.resume()
    }
}


struct profileView: View {
    var profile_banner_url:String
    var name:String
    var screen_name:String
    var description:String
    var url:String
    var profile_image_url_https:String
    var display_url:String
    @State var show = false
        var body: some View {
        VStack(alignment: .leading) {
        
            WebImage(url: URL(string: profile_banner_url)!).resizable().scaledToFit().frame(width:UIScreen.main.bounds.width)
            
                Group{
                    ZStack{
                         Circle().frame(width:UIScreen.main.bounds.width/5+7,height:UIScreen.main.bounds.width/5+7).foregroundColor(Color(red: 0.081, green: 0.125, blue: 0.17))
            WebImage(url: URL(string: profile_image_url_https )!).resizable().scaledToFit().frame(width:UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.width/5).cornerRadius(UIScreen.main.bounds.width/5)
            }
                    Group{
                    Text(name).fontWeight(.black).foregroundColor(Color(.white))
                    
                    Text("@"+screen_name).font(.system(size: 12)).fontWeight(.thin).foregroundColor(Color(red: 0.535, green: 0.599, blue: 0.654))
                    }
                    
                    Text(description).font(.system(size: 15)).fontWeight(.bold).foregroundColor(Color(.white)).fixedSize(horizontal: false, vertical: true).frame(width:UIScreen.main.bounds.width-20).background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 0.0, green: 0.436, blue: 0.952), Color.init(red: 0.01, green: 0.719, blue: 0.701)]), startPoint: UnitPoint(x: 0, y: 1), endPoint: UnitPoint(x: 1, y: 0))).cornerRadius(5).offset(y: 10)
                    HStack(alignment: .bottom){
                        Image("chain").resizable().scaledToFit().frame(width:UIScreen.main.bounds.width/25)
                    Text(display_url).font(.system(size: 15)).fontWeight(.bold).foregroundColor(Color(red: 0.108, green: 0.586, blue: 0.881)).onTapGesture {
                        self.show.toggle()
                        
                    }.sheet(isPresented: self.$show){
                        //wkWebView(url: self.url)
                        SafariView(url: URL(string: self.url)!)
                    }
            }.offset(y: 20)
                    
            }.offset(x:10,y:-UIScreen.main.bounds.width/8-10)
        }
    }
}

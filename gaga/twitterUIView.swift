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
    var body: some View {
        List(results.data){result in
            
                //WebImage(url: URL(string: result.profile_banner_url)!).resizable().scaledToFit().frame(width:UIScreen.main.bounds.width*11/12).cornerRadius(10)
                VStack(alignment: .leading, spacing: 10){
                  WebImage(url: URL(string: result.profile_banner_url)!).resizable().scaledToFit().frame(width:UIScreen.main.bounds.width*11/12).cornerRadius(10)
                    
//                    Text(result.name).fontWeight(.black)
//                    Text(result.screen_name).fontWeight(.black)
//                    Text(result.description).fontWeight(.black)
//                    Text("link: "+result.url).fontWeight(.black)
            
                    HStack{
                    Text(result.friends_count+"個跟隨中").fontWeight(.black)
                    Text(result.followers_count+"位跟隨者").fontWeight(.black)
                    }
                }
            
        }
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
            let url = json["url"].stringValue
            let friends_count = json["friends_count"].stringValue
            let followers_count = json["followers_count"].stringValue
            let profile_image_url_https = json["profile_image_url_https"].stringValue
            let profile_banner_url = json["profile_banner_url"].stringValue
            DispatchQueue.main.async {
                self.data.append(twitterProfileData(id: id, name: name, screen_name: screen_name, description: description, url: url, friends_count: friends_count, followers_count: followers_count, profile_image_url_https: profile_image_url_https, profile_banner_url: profile_banner_url))
            }
        }.resume()
        
        
    }
}



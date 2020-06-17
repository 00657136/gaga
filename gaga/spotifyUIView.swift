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
                    VStack(alignment: .center){
                        WebImage(url: URL(string: result.imgurl )!)
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/6)
                            .cornerRadius(UIScreen.main.bounds.width/6)
                        Text(result.name)
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                            .foregroundColor(Color(.white))
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
        request.addValue("Bearer BQD1FZb6Yi5WxC3d1LtpUamruEiwQKz6IusilcHeYJ9eL2Etd9fXVAWDfMOfEFqWKzBdQcQ0gaFP60g96Q41ldRR52TVc5QhvUp9GlOMDd_KorGNRwHW7-TtEczi_0jhQQv3drXb-ix4RnopbV5bOafBx0_Q", forHTTPHeaderField: "Authorization")

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
            DispatchQueue.main.async {
                self.data.append(spotifyProfileData(id: id, name: name, imgurl: imgurl, popularity: popularity))
            }
        }.resume()
        
        
    }
}

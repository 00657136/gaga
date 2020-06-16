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
        ZStack(alignment: .top){
            Color(.black).frame(minWidth: 0, maxWidth: .infinity)
            VStack{
                ForEach(results.data){result in
                    VStack(alignment: .leading){
                        WebImage(url: URL(string: result.imgurl )!)
                            .resizable()
                            .scaledToFill()
                            .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height/3)
                        Text(result.name)
                            .fontWeight(.bold)
                            .font(.system(size: 40))
                            .foregroundColor(Color(.white))
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
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
        request.addValue("Bearer BQBlVPiNv2NyKEb0RfAMfCCpTHQrBg8qHyC9NeIzmilrNFKpZxezBV-HTBqH6f2FjqSBMyBVuiL2QbQ7is-7hK-OLeLpUZ7AT-PPNPE6xcfQ6SXkY_sLaVowjUEUwuBITGWAxkCGvwgjv_2JsPnwu2aO5w5U", forHTTPHeaderField: "Authorization")

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

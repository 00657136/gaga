//
//  youtubeUIView.swift
//  gaga
//
//  Created by User17 on 2020/6/24.
//  Copyright © 2020 NTOU. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct youtubeUIView: View {
    @ObservedObject var results = getyoutubePlaylistData()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            
            ForEach(results.data){result in
                HStack(alignment: .top, spacing: 10){
                    WebImage(url: URL(string: result.thumbnail)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.width/3)
                    VStack(alignment: .leading){
                        Text(result.title)
                            .fontWeight(.medium)
                            .font(.system(size: 15))
                        Text(result.channelTitle)
                            .foregroundColor(Color(.gray))
                            .font(.system(size: 13))
                        Text(result.publishedAt)
                            .foregroundColor(Color(.gray))
                            .font(.system(size: 13))
                    }
                    Spacer()
                }.padding(.horizontal)
            }
            
        }
    }
}

struct youtubeUIView_Previews: PreviewProvider {
    static var previews: some View {
        youtubeUIView()
    }
}

class getyoutubePlaylistData: ObservableObject {
    @Published var data = [youtubePlaylistData]()
    init(){
        let url = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UUNL1ZadSjHpjm4q9j2sVtOA&key=AIzaSyA2zjS7yzt4mgfHruaa-pnWCGi9xHf5KTw&maxResults=50"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            let items = json["items"].array!
            for i in items{
                let id = i["id"].stringValue
                let title = i["snippet"]["title"].stringValue
                let thumbnail = i["snippet"]["thumbnails"]["high"]["url"].stringValue
                let channelTitle = i["snippet"]["channelTitle"].stringValue
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"//"E MMM d HH:mm:ss Z yyyy"
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-MM-dd HH:mm"
                let published = i["snippet"]["publishedAt"].stringValue
                let publishedA = dateFormatter.date(from: published)
                let publishedAt = dateFormat.string(from: publishedA!)
                DispatchQueue.main.async {
                    self.data.append(youtubePlaylistData(id: id, title: title, thumbnail: thumbnail, channelTitle: channelTitle, publishedAt: publishedAt))
                }
            }
            
        }.resume()
        
        
    }
}


// AIzaSyA2zjS7yzt4mgfHruaa-pnWCGi9xHf5KTw
//UCNL1ZadSjHpjm4q9j2sVtOA
// upload UUNL1ZadSjHpjm4q9j2sVtOA
/*
 
 https://www.googleapis.com/youtube/v3/channels?part=contentDetails&id=UCNL1ZadSjHpjm4q9j2sVtOA&key=AIzaSyA2zjS7yzt4mgfHruaa-pnWCGi9xHf5KTw
 
 https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UUNL1ZadSjHpjm4q9j2sVtOA&key=AIzaSyA2zjS7yzt4mgfHruaa-pnWCGi9xHf5KTw&maxResults=50
 
 */

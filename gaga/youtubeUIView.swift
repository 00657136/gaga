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
    var segmentedControl = ["影片","簡介"]
    @State private var selectedIndex = 0
    @ObservedObject var results = getyoutubePlaylistData()
    @ObservedObject var channels = getyoutubeChannelData()
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                //*************banner
                ForEach(channels.data){channel in
                    VStack(alignment: .leading, spacing: 10){
                        WebImage(url: URL(string: channel.bannerMobileExtraHdImageUrl)!)
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 0, maxWidth: .infinity)
                        HStack(alignment: .center, spacing: 20){
                            ZStack{
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 250/255, green: 81/255, blue: 55/255), Color.init(red: 220/255, green: 42/255, blue: 118/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                                    .frame(width:UIScreen.main.bounds.width/5+8.5,height:UIScreen.main.bounds.width/5+8.5)
                                WebImage(url: URL(string: channel.thumbnails)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.width/5)
                                    .cornerRadius(UIScreen.main.bounds.width/5)
                            }
                            VStack(alignment: .leading, spacing: 5){
                                Text(channel.title)
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                Text(channel.subscriberCount+" 位訂閱者")
                                    .foregroundColor(Color(.gray))
                                    .font(.system(size: 15))
                            }
                            Spacer()
                        }.padding(.horizontal)
                    }
                }
                //*************picker
                Picker(selection: $selectedIndex, label: Text("")) {
                   ForEach(0..<segmentedControl.count) { (index) in
                      Text(self.segmentedControl[index])
                   }
                    }.pickerStyle(SegmentedPickerStyle()).background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 250/255, green: 81/255, blue: 55/255), Color.init(red: 220/255, green: 42/255, blue: 118/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                
                //*******影片
                if selectedIndex == 0 {
                    ForEach(results.data){result in
                        NavigationLink(destination: youtubeVideoUIView(videoId: result.videoId)){
                            HStack(alignment: .top, spacing: 10){
                                WebImage(url: URL(string: result.thumbnail)!)
                                    .renderingMode(.original)
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
                //**********簡介
                else if selectedIndex == 1 {
                    ForEach(channels.data){i in
                        HStack{
                            VStack(alignment: .leading, spacing: 10){
                                Text(i.description)
                                    .font(.system(size: 13))
                                Text(i.publishedAt)
                                    .foregroundColor(Color(.gray))
                                    .font(.system(size: 13))
                                HStack(spacing:1){
                                    Text("觀看次數：")
                                        .foregroundColor(Color(.gray))
                                        .font(.system(size: 13))
                                    Text(i.viewCount)
                                        .foregroundColor(Color(.gray))
                                        .fontWeight(.bold)
                                        .font(.system(size: 13))
                                }
                                Text(i.videoCount+"部影片")
                                    .foregroundColor(Color(.gray))
                                    .font(.system(size: 13))
                            }
                            Spacer()
                        }.padding(.horizontal)
                    }
                    
                }
                
                
                }.navigationBarItems(leading:
                    HStack{
                        Image("Youtube-Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/4)
                    }
                    )
                    //.navigationBarTitle("Youtube",displayMode: .inline)
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
        let url = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UUNL1ZadSjHpjm4q9j2sVtOA&key=AIzaSyB3_kr30K9oyQ4trq0lcJlzngaZzY8dbVU&maxResults=50"
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
                let videoId = i["snippet"]["resourceId"]["videoId"].stringValue
                DispatchQueue.main.async {
                    self.data.append(youtubePlaylistData(id: id, title: title, thumbnail: thumbnail, channelTitle: channelTitle, publishedAt: publishedAt,videoId: videoId))
                }
            }
            
        }.resume()
        
        
    }
}

class getyoutubeChannelData: ObservableObject {
    @Published var data = [youtubeChannelData]()
    init(){
        let url = "https://www.googleapis.com/youtube/v3/channels?part=brandingSettings,snippet,contentDetails,statistics,status&id=UCNL1ZadSjHpjm4q9j2sVtOA&key=AIzaSyB3_kr30K9oyQ4trq0lcJlzngaZzY8dbVU"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            let id = json["items"][0]["id"].stringValue
            let bannerMobileExtraHdImageUrl = json["items"][0]["brandingSettings"]["image"]["bannerMobileExtraHdImageUrl"].stringValue
            let thumbnails = json["items"][0]["snippet"]["thumbnails"]["high"]["url"].stringValue
            let title = json["items"][0]["snippet"]["title"].stringValue
            let subscriberCount = json["items"][0]["statistics"]["subscriberCount"].stringValue
            let description = json["items"][0]["snippet"]["description"].stringValue
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"//"E MMM d HH:mm:ss Z yyyy"
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "加入日期：yyyy年MM月dd日"
            let published = json["items"][0]["snippet"]["publishedAt"].stringValue
            let publishedA = dateFormatter.date(from: published)
            let publishedAt = dateFormat.string(from: publishedA!)
            let viewCount = json["items"][0]["statistics"]["viewCount"].stringValue
            let videoCount = json["items"][0]["statistics"]["videoCount"].stringValue
            DispatchQueue.main.async {
                self.data.append(youtubeChannelData(id: id, bannerMobileExtraHdImageUrl: bannerMobileExtraHdImageUrl, thumbnails: thumbnails, title: title, subscriberCount: subscriberCount, description: description, publishedAt: publishedAt, viewCount: viewCount, videoCount: videoCount))
            }
            
            
        }.resume()
        
        
    }
}



// AIzaSyA2zjS7yzt4mgfHruaa-pnWCGi9xHf5KTw
//UCNL1ZadSjHpjm4q9j2sVtOA
// upload UUNL1ZadSjHpjm4q9j2sVtOA
/*
 
 contentOwnerDetails
 
 https://www.googleapis.com/youtube/v3/channels?part=contentDetails&id=UCNL1ZadSjHpjm4q9j2sVtOA&key=AIzaSyA2zjS7yzt4mgfHruaa-pnWCGi9xHf5KTw
 
 https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UUNL1ZadSjHpjm4q9j2sVtOA&key=AIzaSyA2zjS7yzt4mgfHruaa-pnWCGi9xHf5KTw&maxResults=50
 
  https://www.googleapis.com/youtube/v3/channels?part=brandingSettings,snippet,contentDetails,statistics,status&id=UCNL1ZadSjHpjm4q9j2sVtOA&key=AIzaSyA2zjS7yzt4mgfHruaa-pnWCGi9xHf5KTw
 
invideoPromotion
 https://www.googleapis.com/youtube/v3/channels?part=invideoPromotion&id=UCNL1ZadSjHpjm4q9j2sVtOA&key=AIzaSyA2zjS7yzt4mgfHruaa-pnWCGi9xHf5KTw
 
 */

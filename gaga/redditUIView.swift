//
//  redditUIView.swift
//  gaga
//
//  Created by User17 on 2020/5/22.
//  Copyright © 2020 NTOU. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit
struct redditUIView: View {
    @ObservedObject var results = getRedditData()
    @State var show = false
    @State var url = ""
    var body: some View {
                List(results.data){result in
            VStack(alignment: .leading, spacing: 10){
                
                Text("Posted by u/"+result.author).font(.system(size: 12)).foregroundColor(Color.gray)
                Text(result.title).fontWeight(.black)
                    
                
                if result.imurl != "self"{
                    WebImage(url: URL(string: result.imurl)!).resizable().scaledToFit().frame(width:UIScreen.main.bounds.width*11/12).cornerRadius(10)
                }
                Text("score: "+result.score).font(.system(size: 15))
                
                
            }.onTapGesture {
                self.url = result.url
                self.show.toggle()
            }
        }.sheet(isPresented: self.$show){
            wkWebView(url: self.url)
        }
        
    
    }
}

struct wkWebView : UIViewRepresentable{
    var url : String
    func makeUIView(context: UIViewRepresentableContext<wkWebView>) -> WKWebView{
        let webview = WKWebView()
        webview.load(URLRequest(url: URL(string: url)!))
        return webview
    }
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<wkWebView>) {
        
    }
}

struct redditUIView_Previews: PreviewProvider {
    static var previews: some View {
        redditUIView()
    }
}

class getRedditData: ObservableObject {
    @Published var data = [redditData]()
    init(){
        let url = "https://www.reddit.com/r/ladygaga.json"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            let children = json["data"]["children"].array!
            for i in children{
                let id = i["data"]["id"].stringValue
                let title = i["data"]["title"].stringValue
                let author = i["data"]["author"].stringValue
                let url = i["data"]["url"].stringValue
                let imurl = i["data"]["thumbnail"].stringValue
                let score = i["data"]["score"].stringValue
                DispatchQueue.main.async {
                    self.data.append(redditData(id: id, title: title, author: author, url: url, imurl: imurl,score: score))
                }
            }
            
        }.resume()
        
        
    }
}

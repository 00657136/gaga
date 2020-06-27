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
    @ObservedObject var aboutdata = getRedditAboutData()
    @ObservedObject var Rules = getRedditRuleData()
    @ObservedObject var Mods = getRedditModData()
    @State var show = false
    @State var url = ""
    var segmentedControl = ["Posts","About"]
    @State private var selectedIndex = 0
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            
            ForEach(aboutdata.data){abo in
                VStack(alignment: .leading, spacing: 10){
                    WebImage(url: URL(string: abo.banner)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width,height:UIScreen.main.bounds.height/6)
                    
                    HStack(alignment: .center, spacing: 20){
                        ZStack{
                            Circle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 236/255, green: 26/255, blue: 58/255), Color.init(red: 252/255, green: 147/255, blue: 43/255)]), startPoint: UnitPoint(x: 0.5, y: 1), endPoint: UnitPoint(x: 0.5, y: 0)))
                                .frame(width:UIScreen.main.bounds.width/5+8.5,height:UIScreen.main.bounds.width/5+8.5)
                            WebImage(url: URL(string: abo.icon)!)
                                .resizable()
                                .scaledToFit()
                                .frame(width:UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.width/5)
                                .cornerRadius(UIScreen.main.bounds.width/5)
                        }
                        VStack(alignment: .leading, spacing: 10){
                            HStack{
                                Text(abo.display_name)
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                Spacer()
                            }.padding(.horizontal)
                            VStack(alignment: .leading, spacing: 3){
                                HStack{
                                    Text("\(abo.subscribers) Little Monsters\n\(abo.accounts_active) Online Little Monsters")
                                        .foregroundColor(Color(.gray))
                                        .font(.system(size: 13))
                                    Spacer()
                                }.padding(.horizontal)
                                HStack{
                                    Text(abo.public_description)
                                        .font(.system(size: 13))
                                    Spacer()
                                }.padding(.horizontal)
                            }
                        }
                        Spacer()
                    }.padding(.horizontal)

                }
            }
           
                Picker(selection: $selectedIndex, label: Text("")) {
                ForEach(0..<segmentedControl.count) { (index) in
                   Text(self.segmentedControl[index])
                }
                 }.pickerStyle(SegmentedPickerStyle()).background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 236/255, green: 26/255, blue: 58/255), Color.init(red: 252/255, green: 147/255, blue: 43/255)]), startPoint: UnitPoint(x: 0, y: 1), endPoint: UnitPoint(x: 1, y: 0)))
                
                
                
                if selectedIndex == 0 {
                    ForEach(results.data){result in
                        VStack(alignment: .leading, spacing: 10){
                            HStack{
                                Text("Posted by u/"+result.author)
                                    .font(.system(size: 15))
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }.padding(.horizontal)
                            HStack{
                                Text(result.title).fontWeight(.bold)
                                Spacer()
                            }.padding(.horizontal)
                            
                            if result.imurl != "self"{
                                WebImage(url: URL(string: result.url)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:UIScreen.main.bounds.width)
                            }
                            else {
                                HStack{
                                    Text(result.selftext)
                                        .font(.system(size: 13))
                                    Spacer()
                                }.padding(.horizontal)
                            }
                            HStack(alignment: .center, spacing: 50){
                                HStack(alignment: .center){
                                    Image("clap")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:UIScreen.main.bounds.width/20)
                                    Text(result.score)
                                        .font(.system(size: 15))
                                }
                                HStack(alignment: .center){
                                    Image("num_comments")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:UIScreen.main.bounds.width/20)
                                    Text("\(result.num_comments)")
                                        .font(.system(size: 15))
                                }
                                HStack(alignment: .center){
                                    Image("share")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:UIScreen.main.bounds.width/20)
                                    Text("share")
                                        .font(.system(size: 15))
                                }
                                Spacer()
                            }.padding(.horizontal).padding(.bottom)
                            
                        }.onTapGesture {
                            self.url = result.url
                            self.show.toggle()
                        }
                    }.sheet(isPresented: self.$show){
                        wkWebView(url: self.url)
                    }
                }
                    
                    
                    
                else if selectedIndex == 1{
                    Group{
                        HStack{
                            Image("rule")
                                .resizable()
                                .scaledToFit()
                                .frame(width:UIScreen.main.bounds.width/10)
                            Text("Rules")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                            Spacer()
                        }.padding(.horizontal)
                        
                        ForEach(Rules.data){rule in
                            ruleView(short_name: rule.short_name, description: rule.description, violation_reason: rule.violation_reason)

                        }
                        HStack{
                            Image("robot")
                                .resizable()
                                .scaledToFit()
                                .frame(width:UIScreen.main.bounds.width/7)
                            Text("Moderators")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                            Spacer()
                        }.padding(.horizontal)
                        ForEach(Mods.data){mod in
                            VStack(alignment: .leading, spacing: 15){
                                HStack{
                                    
                                    Text("u/"+mod.name)
                                        .font(.system(size: 15))
                                    Spacer()
                                                           
                                }.padding(.horizontal)
 
                            }

                        }
                        
                        
                    }
                }
            
        }.edgesIgnoringSafeArea(.top)
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
                let score = i["data"]["ups"].stringValue
                let selftext = i["data"]["selftext"].stringValue
                let num_comments = i["data"]["num_comments"].intValue
                DispatchQueue.main.async {
                    self.data.append(redditData(id: id, title: title, author: author, url: url, imurl: imurl,score: score,selftext: selftext,num_comments: num_comments))
                }
            }
            
        }.resume()
        
        
    }
}

class getRedditAboutData: ObservableObject {
    @Published var data = [redditAbout]()
    init(){
        let url = "https://www.reddit.com/r/LadyGaga/about.json"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            let id = json["data"]["id"].stringValue
            let banner = json["data"]["mobile_banner_image"].stringValue
            let icon = json["data"]["icon_img"].stringValue
            let public_description = json["data"]["public_description"].stringValue
            let display_name = json["data"]["display_name_prefixed"].stringValue
            let accounts_active = json["data"]["accounts_active"].intValue
            let subscribers = json["data"]["subscribers"].intValue
            let description = json["data"]["description"].stringValue
            DispatchQueue.main.async {
                self.data.append(redditAbout(id: id, banner: banner, icon: icon, public_description: public_description, display_name: display_name, accounts_active: accounts_active, subscribers: subscribers, description: description))
            }
            
        }.resume()
        
        
    }
}

class getRedditRuleData: ObservableObject {
    @Published var data = [redditRules]()
    init(){
        let url = "https://www.reddit.com/r/LadyGaga/about/rules.json"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            let rules = json["rules"].array!
            for i in rules{
                let id = i["created_utc"].intValue
                let description = i["description"].stringValue
                let short_name = i["short_name"].stringValue
                let violation_reason = i["violation_reason"].stringValue
                DispatchQueue.main.async {
                    self.data.append(redditRules(id: id, description: description, short_name: short_name, violation_reason: violation_reason))
                }
            }
            
        }.resume()
        
        
    }
}

class getRedditModData: ObservableObject {
    @Published var data = [redditMod]()
    init(){
        let url = "https://www.reddit.com/r/LadyGaga/about/moderators.json"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!){(data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            let children = json["data"]["children"].array!
            for i in children{
                let id = i["id"].stringValue
                let name = i["name"].stringValue
                DispatchQueue.main.async {
                    self.data.append(redditMod(id: id, name: name))
                }
            }
            
        }.resume()
        
        
    }
}

struct ruleView: View {
    var short_name : String
    @State var expand = false
    var description : String
    var violation_reason : String
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            HStack{
                Text(short_name)
                    .font(.system(size: 15))
                Spacer()
                Toggle(isOn: $expand) {
                    if expand{
                        Text("")
                    }
                    else{
                        Text("")
                    }
                }.frame(width:110,height:40)
            }.padding(.horizontal)
            if expand == true {
                HStack{
                    Text(description)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 13))
                    Spacer()
                    
                }.padding(.horizontal)
                HStack{
                    Text("原因： ")
                        .font(.system(size: 13))
                    Text(violation_reason)
                        .font(.system(size: 13))
                    Spacer()
                    
                }.padding(.horizontal)
            }
        }
    }
}

//
//  SafariView.swift
//  gaga
//
//  Created by User17 on 2020/6/5.
//  Copyright © 2020 NTOU. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SFSafariViewController {
         SFSafariViewController(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
            
    }
    
    let url: URL
}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "https://www.ladygaga.com/")!)
    }
}

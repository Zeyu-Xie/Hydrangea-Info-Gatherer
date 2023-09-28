//
//  ContentView.swift
//  Hydrangea Info Gatherer
//
//  Created by Acan on 2023/9/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hydrangea Info Gatherer").font(.largeTitle)
            Text("")
            Link("- Made by Acan", destination: URL(string: "https://zeyu-xie.github.io/Acan")!)
        }.frame(width: 1280, alignment: .leading).padding(.top)
        
        VStack {
            TabView {
                BaiduNews().tabItem({Text("Baidu News")}).tag(0)
                BaiduNews().tabItem({Text("Weibo News")}).tag(1)
            }
        }.frame(width: 1280, alignment: .leading).padding(.top).padding(.bottom)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

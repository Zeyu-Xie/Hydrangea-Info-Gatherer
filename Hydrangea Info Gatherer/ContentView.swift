//
//  ContentView.swift
//  Hydrangea Info Gatherer
//
//  Created by Acan on 2023/10/8.
//

//
//  ContentView.swift
//  Hydrangea Info Gatherer
//
//  Created by Acan on 2023/9/26.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationView {
            VStack {
                BaiduNews()
            }
        }
    }
}

struct SecondView: View {
    var body: some View {
        NavigationView {
            VStack {
                About()
            }
        }
    }
}

struct ContentView: View {
    

    var body: some View {
        
        TabView {
            FirstView().tabItem {
                Image(systemName: "globe.asia.australia")
                Text("Baidu News")
            }
            SecondView().tabItem {
                Image(systemName: "person")
                Text("About")
            }
            
        }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  About.swift
//  Hydrangea Info Gatherer
//
//  Created by Acan on 2023/10/9.
//

import SwiftUI

struct About: View {
    var body: some View {
        ScrollView(showsIndicators: false)
        {
            VStack {
            VStack(alignment: .leading, spacing: 16) {
                
                Divider()
                
                Text("Welcome to Hydrangea Info Gatherer, your go-to source for the latest updates and insights from Baidu Hot Searches. Created by Acan on September 26, 2023, this SwiftUI app provides a streamlined and informative way to stay updated on the trending topics.")
                    .font(.body)
            }.padding(.bottom)
            
            VStack(alignment: .leading, spacing: 16) {
                
                Divider()
                
                Text("Features:")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("- Baidu Hot Searches: Hydrangea Info Gatherer fetches real-time data from Baidu's Hot Searches, ensuring you're always in the loop about what's capturing the online world's attention.")
                    .font(.body)
                
                Text("- Structured Presentation: The app organizes the information into distinct categories, including news number, title, index, content, and URL. This structured presentation makes it easy for you to grasp the key details at a glance.")
                    .font(.body)
                
                Text("- Dynamic Content: As the app dynamically retrieves the latest news, you can trust that the content remains fresh and relevant. The information is presented in a scrollable format for a seamless reading experience.")
                    .font(.body)
            }.padding(.bottom)
            
            VStack(alignment: .leading, spacing: 16) {
                
                Divider()
                
                Text("How to Use:")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("1. Launch the app to access the latest Baidu Hot Searches.")
                    .font(.body)
                
                Text("2. Scroll through the content to explore various topics.")
                    .font(.body)
                
                Text("3. Click on the provided links to delve deeper into articles that pique your interest.")
                    .font(.body)
            }.padding(.bottom)
            
            VStack(alignment: .leading, spacing: 16) {
                
                Divider()
                
                Text("Technical Details:")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("- Source URL: The app pulls data from the source URL: https://zeyu-xie.github.io/Hydrangea-Info-Gatherer/data/Baidu_Hot_Search/latest.txt")
                    .font(.body)
                
                Text("- Regex Pattern Matching: The app utilizes regular expressions (regex) to extract specific information from the source data, ensuring accurate and structured content presentation.")
                    .font(.body)
            }.padding(.bottom)
            
                VStack(alignment: .leading, spacing: 16) {
                    
                    Divider()
                    
                    Text("Developer:")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("- Creator: Acan")
                        .font(.body)
                    
                    Text("- Creation Date: October 9, 2023")
                        .font(.body)
                }
            }.padding()
        }
        .navigationBarTitle("About")
    }
}

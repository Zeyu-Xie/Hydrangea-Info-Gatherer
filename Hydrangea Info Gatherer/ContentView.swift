//
//  ContentView.swift
//  Hydrangea Info Gatherer
//
//  Created by Acan on 2023/9/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var content = ""
    @State private var source = "https://zeyu-xie.github.io/Hydrangea-Info-Gatherer/data/Baidu_Hot_Search/latest.txt"
    
    let pattern = "http.*?sa=fyb_news&rsv_dl=fyb_news"
    
    var body: some View {
        VStack {
            ScrollView {
                Text(content)
            }
        }
        .padding()
        .onAppear {
            getLatestNews()
        }
    }
    
    func getLatestNews() {
        if let url = URL(string: source) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("ERROR：\(error)")
                } else if let data = data {
                    if let responseString = String(data: data, encoding: .utf8) {
                        DispatchQueue.main.async {
                            
                            do {
                                content=responseString
                                
                                let regex = try NSRegularExpression(pattern: pattern, options: [])
                                let range = NSRange(content.startIndex..<content.endIndex, in: content)
                                
                                let matches = regex.matches(in: content, options: [], range: range)
                                
                                for match in matches {
                                    let matchedRange = Range(match.range, in: content)!
                                    let matchedSubstring = content[matchedRange]
                                    print("找到的子字符串是：\(matchedSubstring)")
                                }
                                
                                
                                
                            } catch {
                                print("ERROR：\(error)")
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

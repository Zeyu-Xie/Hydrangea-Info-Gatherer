//
//  ContentView.swift
//  Hydrangea Info Gatherer
//
//  Created by Acan on 2023/9/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var source = "https://zeyu-xie.github.io/Hydrangea-Info-Gatherer/data/Baidu_Hot_Search/latest.txt"
    
    let num_pattern="- No.*? -"
    let title_pattern="- Title.*? -"
    let index_pattern="- Index.*? -"
    let content_pattern="- Content.*? -"
    let url_pattern = "- URL.*? -"
    
    @State private var num_contents: Array<String> = []
    @State private var title_contents: Array<String> = []
    @State private var index_contents: Array<String> = []
    @State private var content_contents: Array<String> = []
    @State private var url_contents: Array<String> = []
    @State private var count:Int = 0
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hydrangea Info Gatherer").font(.title)
                            Text("")
                            Link("- Made by Acan", destination: URL(string: "https://zeyu-xie.github.io/Acan")!)
                            Text("")
                            Button("Resresh") {
                                getLatestNews()
                            }
                            Text("")
                        }
                        Spacer()
                        VStack {
                            Image("Baidu").resizable().aspectRatio(contentMode: .fit).frame(height: 60)
                            
                            Link("Source: Baidu", destination: URL(string: "https://baidu.com")!)
                            Spacer()
                        }.padding()
                        Spacer()
                    }
                    Divider()
                }.padding()
                
                VStack(alignment: .leading) {
                    ForEach(0..<count, id: \.self) { num in
                        
                        let _num = num_contents[num].dropFirst(6).dropLast(2)
                        
                        let _title = title_contents[num].dropFirst(9).dropLast(2)
                        
                        let _index = index_contents[num].dropFirst(9).dropLast(2)
                        
                        let _content = content_contents[num].dropFirst(11).dropLast(2)
                        
                        let _url = url_contents[num].dropFirst(7).dropLast(2)
                        
                        Link(_num+". "+_title, destination: URL(string: String(_url))!)
                        Text(_content)
                        Text("")
                        Divider()
                    }
                }.padding()
            }
        }.padding()
            .onAppear {
                getLatestNews()
            }.frame(width: 784)
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
                            num_contents = fitPattern(res: responseString, pattern: num_pattern)
                            title_contents=fitPattern(res: responseString, pattern: title_pattern)
                            index_contents=fitPattern(res: responseString, pattern: index_pattern)
                            content_contents=fitPattern(res: responseString, pattern: content_pattern)
                            url_contents=fitPattern(res: responseString, pattern: url_pattern)
                            count=num_contents.count
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func fitPattern (res: String, pattern: String) -> [String] {
        do {
            let content=res
            
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(content.startIndex..<content.endIndex, in: content)
            
            let matches = regex.matches(in: content, options: [], range: range)
            
            var result: [String] = []
            
            for match in matches {
                let matchedRange = Range(match.range, in: content)!
                let matchedSubstring = content[matchedRange]
                result.append(String(matchedSubstring))
            }
            
            return result
            
        } catch {
            print("ERROR：\(error)")
            return []
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

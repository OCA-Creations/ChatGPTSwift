//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

open class ChatGPT: Model, Codable {
    
    public var maxTokens: UInt = 4096
    
    public var trainingData: Date = Date(timeIntervalSince1970: 1630454400)
    
    public var endpoint: URL = URL(string: "https://api.openai.com/v1/chat/completions")!
    
    public var apiName: String = "gpt-3.5-turbo"
    
  
    
    public required init(_ apiKey: String) {
        self.apiKey = apiKey
    }
    
    public var apiKey: String
    
    
    
}

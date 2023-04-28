//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

///The ChatGPT ``Model``.
open class ChatGPT: Model, Codable {
    
    public static var maxTokens: UInt = 4096
    
    public static var trainingCutoff: Date = Date(timeIntervalSince1970: 1630454400)
    
    public static var endpoint: URL = URL(string: "https://api.openai.com/v1/chat/completions")!
    public var apiName: String
    
  
    
    public required init(_ apiKey: String, temperature: Double = 0.7, apiName: String = "gpt-3.5-turbo") {
        self.apiKey = apiKey
        self.temperature = temperature
        self.apiName = apiName
    }
    
    public var apiKey: String
    
    ///The model's variability.
    public var temperature: Double
    
    
    
}

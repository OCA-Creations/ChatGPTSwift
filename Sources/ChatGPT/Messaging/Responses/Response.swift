//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

///A response from the OpenAI completions API.
public struct APIResponse: Codable {
    ///The identifier used to identify this response
    public var id: String
    ///The type this response concerns. Will likely be `"messages"`
    public var object: String
    ///When this response was created (timeIntervalSince1970
    public var created: Date
    
    ///The model usage.
    public var usage: Usage
    ///The choices made by the model.
    public var choices: [Choice]
    
    
    
    ///The model name used for the completion
    public var model: String
}

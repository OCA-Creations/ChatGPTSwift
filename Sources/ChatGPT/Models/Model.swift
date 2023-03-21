//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

///A type that can interface with the OpenAI API endpoints.
///- Note: For specific models, look under a specific category. The package currently only supports GPT-3.5 models, but more will be added in the future.
public protocol Model: Codable{
    ///The maximum number of tokens that the model will accept. A token is a part of a word.
    var maxTokens: UInt { get }
    
    ///When the model's training data cuts off in the real world.
    ///- Note: As of March 3rd, 2023, the latest model cuts off in September 2021.
    var trainingData: Date { get }
    
    ///The actual endpoint that should be used to access the model.
    var endpoint: URL { get }
    
    ///The model name, as it should be referred to in the API.
    ///- Note: For ChatGPT models, this is actually `gpt-3.5-turbo`, not ChatGPT.
    var apiName: String { get }
    
    ///Initialize the model with an API key.
    init(_ apiKey: String)
    
    ///The model's API key
    var apiKey: String { get set }
}

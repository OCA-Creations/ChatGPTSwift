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
    
    private enum CodingKeys: String, CodingKey {
           case id, object, created, model, usage, choices
       }
    
    public init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.object = try container.decode(String.self, forKey: .object)
        self.model = try container.decode(String.self, forKey: .model)
        self.usage = try container.decode(Usage.self, forKey: .usage)
        self.choices = try container.decode([Choice].self, forKey: .choices)

           let timestamp = try container.decode(Int.self, forKey: .created)
        self.created = Date(timeIntervalSince1970: TimeInterval(timestamp))
       }
}

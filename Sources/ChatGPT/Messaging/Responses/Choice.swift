//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

///The part of the API response that contains the actual returned text.
public struct Choice: Decodable {
    ///The index at which the rest of the choice is
    public var index: Int
    
    ///The reason the model stopped generating text.
    public var finish_reason: String
    
    ///The array of `Message`s that the choices contains
    public var messages: [Message]
    
    ///How to decode the object.
    public enum CodingKeys: String, CodingKey {
        case messages = "message", finish_reason, index
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.messages = try container.decode([Message].self, forKey: .messages)
        // print("Decoded messages")
        self.finish_reason = try container.decode(String.self, forKey: .finish_reason)
        self.index = try container.decode(Int.self, forKey: .index)
    }
    
    public init(messages: [Message], finishReason: String, index: Int) {
        self.messages = messages
        self.finish_reason = finishReason
        self.index = index
    }
    
   
}

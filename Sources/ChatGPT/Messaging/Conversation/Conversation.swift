//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

///A conversation with an AI model via the OpenAI API.
public struct Conversation: Encodable {
    ///The model to be used for the conversation
    ///- Note: Many of the properties for this conversation, such as `api-key` and `model`, are derived from this property.
    public var model: ChatGPT
    
    ///The messages that this conversation contains.
    public var messages: [Message]
    
    ///Initialize a conversation with the given model and messages.
    public init(model: ChatGPT, messages: [Message] = []) {
        self.model = model
        self.messages = messages
    }
    ///How to encode the conversation
    public enum CodingKeys: String, CodingKey {
        case model, messages
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ChatGPT.apiName, forKey: .model)
        try container.encode(self.messages, forKey: .messages)
    }
    
    ///Add a message to the conversation.
    public mutating func addMessage(_ message: Message, index: Int = -1) {
        self.messages.insert(message, at: index)
    }
    
    
    
}

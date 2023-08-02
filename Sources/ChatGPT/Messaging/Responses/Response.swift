//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

/// Represents a response from the OpenAI completions API.
public struct APIResponse: Decodable {
    /// The identifier used to identify this response.
    public var id: String
    /// The type this response concerns. Will likely be `"messages"`.
    public var object: String
    /// The date and time when this response was created, represented as the number of seconds since 1970-01-01 00:00:00 UTC.
    public var created: Date
    /// The usage details of the model for this response.
    public var usage: Usage
    /// The choices made by the model in this response.
    public var choices: [Choice]
    /// The name of the model used for the completion.
    public var model: String
    ///The model name used for the completion
    public var model: String
    
    private enum CodingKeys: String, CodingKey {
           case id, object, created, model, usage, choices
       }
    
    /// Initializes a new instance of the `APIResponse` struct.
    /// - Parameter decoder: The decoder to use to initialize the instance.
    /// - Throws: An error if decoding fails.
    public init(from decoder: Decoder) throws {
        // print("Starting to decode")
           let container = try decoder.container(keyedBy: CodingKeys.self)
        // print("Created container")
        self.id = try container.decode(String.self, forKey: .id)
        // print("Decoded id")
        self.object = try container.decode(String.self, forKey: .object)
        // print("Decoded object")
        self.model = try container.decode(String.self, forKey: .model)
        // print("Decoded model")
        self.usage = try container.decode(Usage.self, forKey: .usage)
        // print("Decoded usage")
        var choicesContainer = try container.nestedUnkeyedContainer(forKey: .choices)
                var choices: [Choice] = []
                while !choicesContainer.isAtEnd {
                    let choiceContainer = try choicesContainer.nestedContainer(keyedBy: Choice.CodingKeys.self)
                    let messageContainer = try choiceContainer.nestedContainer(keyedBy: Message.CodingKeys.self, forKey: Choice.CodingKeys.messages)
                    let role = try messageContainer.decode(String.self, forKey: Message.CodingKeys.role)
                    let content = try messageContainer.decode(String.self, forKey: Message.CodingKeys.content)
                    let message = Message(header: Header(role: Role(rawValue: role) ?? Role.system), content: content)
                    let finishReason = try choiceContainer.decode(String.self, forKey: .finish_reason)
                    let index = try choiceContainer.decode(Int.self, forKey: .index)
                    let choice = Choice(messages: [message], finishReason: finishReason, index: index)
                    choices.append(choice)
                }
                self.choices = choices
       
//        self.choices = try container.decode([Choice].self, forKey: .choices)
// print("Decoded mearly everything")
           let timestamp = try container.decode(Int.self, forKey: .created)
        self.created = Date(timeIntervalSince1970: TimeInterval(timestamp))
       }
}

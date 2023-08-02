//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

/// Represents a single message in a conversation with a chatbot.
public struct Message: Codable, Identifiable, Equatable{
    /// Asserts equality between two `Message` instances.
    public static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
    
    /// The header content of the message.
   public var header: Header
    
    /// The actual content of the message.
    public var content: String
    
    /// The unique identifier of the message.
    public var id: UUID
    
    ///How to encode a message.
    public enum CodingKeys: String, CodingKey {
        case role
        case content
    }
    
    /// Encodes this instance into the given encoder.
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: An error if any values are invalid.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.header.role, forKey: .role)
        try container.encode(self.content, forKey: .content)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // print("Created messaging container")
        self.content = try container.decode(String.self, forKey: .content)
        // print("Created content container")
        let miniRole = try container.decode(String.self, forKey: .role)
        // print("Created role container")
        if let role = Role(rawValue: miniRole) {
            self.header = Header(role: role)
        } else {
            self.header = Header(role: .system)
        }
        self.id = UUID()
    }
    
    /// Initializes a new instance of the `Message` struct.
    /// - Parameters:
    ///   - header: The header content of the message.
    ///   - content: The actual content of the message.
    public init(header: Header, content: String){
        self.header = header
        self.content = content
        self.id = UUID()
    }
    
    
}

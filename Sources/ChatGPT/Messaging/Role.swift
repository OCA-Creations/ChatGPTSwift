//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

///The `role` in a conversation that a given message was delivered by.
public enum Role: String, Codable {
    ///The system or app was the provider of this message.
    case system
    ///The user provided this message.
    case user
    ///The AI provided this message.
    case assistant
}

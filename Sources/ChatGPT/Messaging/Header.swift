//
//  Header.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

///The header for a single message.
///- Note: As of March 2023, this only contains the ``Role``, but the API will be updated in the future.
public struct Header: Codable {
    ///The ``Role`` of the message sender.
    public var role: Role
    
    ///Create a `Header` for a message.
    ///- Parameter role: The ``Role`` of the sender of the message.
    public init(role: Role) {
        self.role = role
    }
}

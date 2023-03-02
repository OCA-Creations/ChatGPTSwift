//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

///The header for a single message.
///- Note: As of March 2023, this only contains the ``Role``, but the API will be updated in the future.
public struct Header: Codable {
    ///The role of the message sender.
    var role: Role
}

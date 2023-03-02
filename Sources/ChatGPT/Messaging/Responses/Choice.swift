//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

///The part of the API response that contains the actual returned text.
public struct Choice: Codable {
    ///The index at which the rest of the choice is
    public var index: Int
    
    ///The reason the model stopped generating text.
    public var finish_reason: String
    
    ///The array of `Message`s that the choices contains
    public var messages: [Message]
}

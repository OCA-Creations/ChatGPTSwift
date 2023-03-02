//
//  File.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/1/23.
//

import Foundation

///The usage properties of an API response.
///You might want to store these on a server, or in some other form. They are integers.
public struct Usage: Codable {
    ///The number of tokens used by the user to prompt the model.
    public var prompt_tokens: Int
    
    ///The number of tokens used by the model to respond.
    public var completion_tokens: Int
    
    ///The total number of tokens used.
    public var total_tokens: Int
}

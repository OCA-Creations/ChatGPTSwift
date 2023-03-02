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
    
    ///Makes a request to the API for the conversation.
    ///- Warning:This method will automatically add the AI-generated text to the ``Conversation``.
    `public mutating func submit(completionHandler: @escaping(APIResponse?) -> Void) async{
        //Create the request and configure its values
        var request = URLRequest(url: ChatGPT.endpoint)
        request.httpMethod = "POST"
        request.addValue("Bearer \(model.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Create the request body
        do {
            let body = try JSONEncoder().encode(self)
            request.httpBody = body
        } catch {
            print("Could not set the request body due to \(error)")
            completionHandler(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
          guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "Unknown error")
              completionHandler(nil)
            return
          }
          
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                
                    completionHandler(response)
                
          } else {
            print("Invalid JSON response")
              completionHandler(nil)
          }
        }

        task.resume()
    }`
    
}

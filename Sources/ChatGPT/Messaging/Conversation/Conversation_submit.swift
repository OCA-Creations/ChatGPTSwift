//
//  Conversation.submit.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/2/23.
//

import Foundation

@available(iOS 15, macOS 12, *)
public extension Conversation {
    ///Makes a request to the API for the conversation.
    ///- Warning:This method will automatically add the AI-generated text to the ``Conversation``.
    mutating func submit(completionHandler: @escaping(APIResponse?) -> Void) async{
        //Create the request and configure its values
        // print("\n\n\n Hello World!!!")
        var request = URLRequest(url: ChatGPT.endpoint)
        self.checkConversationLength()
        request.httpMethod = "POST"
        request.addValue("Bearer \(model.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // print(request)
        //Create the request body
        do {
            let body = try JSONEncoder().encode(self)
            // print("\n\n\n \(body)")
            request.httpBody = body
        } catch {
            // print("Could not set the request body due to \(error)")
            completionHandler(nil)
            return
        }
        // print("Starting URLSession")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // print("URLSession was just called.")
          guard let data = data, error == nil else {
            // print(error?.localizedDescription ?? "Unknown error")
              completionHandler(nil)
            return
          }
            // print(String(data: data, encoding: .utf8))
            if let newResp = try? JSONDecoder().decode(APIResponse.self, from: data) {
                
                    completionHandler(newResp)
                
          } else {
            // print("Invalid JSON response")
              completionHandler(nil)
          }
        }
        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
        
    }
    ///Check the maximum number of tokens allowed by the API, and remove topmost system ones if it is more
    ///- Parameter maxLengthInCharacters: The maximum number of characters allowed
    mutating func checkConversationLength(maxLengthInCharacters: Int = 4096) {
        //First check the overall length of all of the messages
        var totalCount = 0
        for i in self.messages {
            totalCount += i.content.count
        }
        //Remove non system messages that are over the limit
        while totalCount > maxLengthInCharacters {
            if let item = self.messages.firstIndex (where:  { message in
                message.header.role != .system
            }) {
                totalCount -= messages[item].content.count
                messages.remove(at: item)
            }
        }
    }
    
    ///Clear the conversation of all non-system messages
    ///- Note: A system message is identified by a ``Role.system`` role in its ``Header``.
    ///- Warning: This will clear all conversation content except for system messages! Use very carefully, as this will remove even the first user message as well.
    ///- Warning: If you want to keep the first user-generated message, pass in `keepFirstUser: Bool` as `true`.
    ///- Parameter keepSystem: Whether or not to keep system messages. Defaults to `true`.
    ///- Parameter keepFirstUser: Whether or not to keep the first user-sent message.
    mutating func clear(keepSystem: Bool = true, keepFirstUser: Bool = false) {
        
            if keepFirstUser {
                var miniChange = self.messages
                miniChange.removeAll(where: { mes in
                    if !keepSystem{
                        return mes.header.role == .assistant || mes.header.role == .system
                    } else {
                        return mes.header.role == .assistant
                    }
                })
                let first = miniChange.firstIndex { mes in
                    mes.header.role == .user
                } ?? 0
                var toRemove: [Message] = []
                for (index, i) in miniChange.enumerated() {
                    if !(index == first) {
                        toRemove.append(i)
                    }
                }
                self.messages = miniChange.filter { mes in
                    toRemove.contains { new in
                        new == mes
                    } != true
                }
            } else {
                if keepSystem{
                    self.messages.removeAll(where:  { x in
                        x.header.role != .system
                    })
                } else {
                    self.messages.removeAll()
                }
            }
        
        
    }
}

//
//  Conversation.submit.swift
//  
//
//  Created by Owen Cruz-Abrams on 3/2/23.
//

import Foundation

public extension Conversation {
    ///Makes a request to the API for the conversation.
    ///- Warning:This method will automatically add the AI-generated text to the ``Conversation``.
    public mutating func submit(completionHandler: @escaping(APIResponse?) -> Void) async{
        //Create the request and configure its values
        // print("\n\n\n Hello World!!!")
        var request = URLRequest(url: ChatGPT.endpoint)
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
}

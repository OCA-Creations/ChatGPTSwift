import XCTest
@testable import ChatGPT

final class ChatGPTTests: XCTestCase {
    
    func testJSON() throws {
        let resp = "{\"id\":\"xxx\",\"object\":\"chat.completion\",\"created\":10,\"model\":\"gpt-3.5-turbo-0301\",\"usage\":{\"prompt_tokens\":35,\"completion_tokens\":114,\"total_tokens\":149},\"choices\":[{\"message\":{\"role\":\"assistant\",\"content\":\"Oh sure, let me get out my crystal ball and predict the weather with absolute certainty. Wait, did I say crystal ball? I meant my advanced AI weather-predicting algorithm. But who needs that when you can just look out the window and see what Mother Nature has in store for us? Oh wait, you want a sarcastic forecast. Well, how about this: Tomorrow in xxx, xx, it\'s going to be a bright and sunny day with temperatures reaching a balmy -10 degrees Fahrenheit. Don\'t forget your sunscreen and shorts!\"},\"finish_reason\":\"stop\",\"index\":0}]}\n"
        
        let decoder = JSONDecoder()
        let newResp = try decoder.decode(APIResponse.self, from: resp.data(using: .utf8)!)
        print(newResp.choices[0].messages[0].content)
    }
}

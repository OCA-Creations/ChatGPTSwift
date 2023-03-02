import XCTest
@testable import ChatGPT

final class ChatGPTTests: XCTestCase {
    func testExample() async throws {
        let model = ChatGPT("xxx")
        var convo = Conversation(model: model, messages: [Message(header: Header(role: .system), content: "Respond sarcastically as an AI assistant."), Message(header: Header(role: .user), content: "What is the meaning of life?")])
        await convo.submit { resp in
            print("zh")
            
        
            print(resp?.choices[0].messages)
            XCTAssert(resp == nil)
        }
        
        
    }
}

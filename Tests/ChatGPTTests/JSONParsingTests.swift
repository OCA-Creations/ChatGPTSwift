import XCTest
@testable import ChatGPT

final class JSONParsingTests: XCTestCase {
    func testJSONParsing() {
        // Define a mock JSON response string
        let mockJSONResponse = """
        {
            "id": "test_id",
            "object": "test_object",
            "created": 1648770123,
            "model": "test_model",
            "usage": {
                "prompt_tokens": 10,
                "completion_tokens": 20,
                "total_tokens": 30
            },
            "choices": [
                {
                    "message": {
                        "role": "system",
                        "content": "test_content"
                    },
                    "finish_reason": "stop",
                    "index": 0
                }
            ]
        }
        """

        // Convert the mock JSON response string into Data
        let data = mockJSONResponse.data(using: .utf8)!

        // Decode the Data into an APIResponse object
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let response = try? decoder.decode(APIResponse.self, from: data)

        // Verify that the decoding was successful and that the APIResponse object contains the expected data
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.id, "test_id")
        XCTAssertEqual(response?.object, "test_object")
        XCTAssertEqual(response?.model, "test_model")
        XCTAssertEqual(response?.usage.promptTokens, 10)
        XCTAssertEqual(response?.usage.completionTokens, 20)
        XCTAssertEqual(response?.usage.totalTokens, 30)
        XCTAssertEqual(response?.choices.first?.messages.first?.content, "test_content")
    }
}
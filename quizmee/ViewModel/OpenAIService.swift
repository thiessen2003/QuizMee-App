//
//  OpenAIService.swift
//  quizmee
//
//  Created by Gabriel Thiessen on 4/23/24.
//

import Foundation
import Alamofire

class OpenAIService {
    private let endpointUrl = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(messages: [Message], retryCount: Int = 0) async throws -> OpenAIChatResponse {
        let openAIMessages = messages.map({OpenAIChatMessage(role: $0.role, content: $0.content)})
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAIMessages)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIAPIKey)"
        ]

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(endpointUrl, method: .post, parameters: body, encoder: .json, headers: headers)
                .validate()
                .responseDecodable(of: OpenAIChatResponse.self) { response in
                    switch response.result {
                    case .success(let chatResponse):
                        continuation.resume(returning: chatResponse)
                    case .failure(let error as AFError):
                        if case .responseValidationFailed(let reason) = error,
                           case .unacceptableStatusCode(let code) = reason,
                           code == 400,
                           let data = response.data {
                            do {
                                let errorResponse = try JSONDecoder().decode(OpenAIErrorResponse.self, from: data)
                                let errorMessage = errorResponse.error.message
                                print("Error: Bad Request (400). Message: \(errorMessage)")
                                continuation.resume(throwing: NSError(domain: "OpenAIServiceErrorDomain", code: 400, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
                            } catch {
                                continuation.resume(throwing: error)
                            }
                        } else {
                            continuation.resume(throwing: error)
                        }
                    }
                }
        }
    }
    }
struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
}

struct OpenAIChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable {
    case system
    case user
    case assistant
}
struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
}
struct OpenAIChatChoice: Decodable {
    let message: OpenAIChatMessage
}
struct OpenAIErrorResponse: Decodable {
    let error: OpenAIError
}

struct OpenAIError: Decodable {
    let message: String
    let type: String?
    let param: String?
    let code: String?
}

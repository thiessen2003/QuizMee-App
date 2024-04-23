//
//  ChatViewModel.swift
//  quizmee
//
//  Created by Gabriel Thiessen on 4/23/24.
//

import Foundation

extension ChatView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = []
        @Published var currentInput: String = ""
        @Published var generatedQuestion: String = ""
        @Published var generatedAnswer: String = ""
        
        private let openAIService = OpenAIService()
        
        func sendMessage() {
            let newMessage = Message(id: UUID(), role: .user, content: currentInput, createAt: Date())
            messages.append(newMessage)
            currentInput = ""
            
            Task {
                do {
                    let response = try await openAIService.sendMessage(messages: messages)
                    guard let receivedOpenAIMessage = response.choices.first?.message else {
                        print("Had no received message")
                        return
                    }
                    let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
                    await MainActor.run {
                        messages.append(receivedMessage)
                    }
                } catch {
                    print("Error: \(error)")
                    // Handle the error appropriately (e.g., show an error message to the user)
                }
            }
        }
        func generateQuestionAndAnswer() {
                    let prompt = "Generate a college level question on \(currentInput) and the answer to it"
                    let newMessage = Message(id: UUID(), role: .user, content: prompt, createAt: Date())
                    messages.append(newMessage)
                    
                    Task {
                        do {
                            let response = try await openAIService.sendMessage(messages: messages)
                            guard let receivedOpenAIMessage = response.choices.first?.message else {
                                print("Had no received message")
                                return
                            }
                            
                            let receivedContent = receivedOpenAIMessage.content
                            let questionAnswerComponents = receivedContent.components(separatedBy: "\n\n")
                            
                            if questionAnswerComponents.count >= 2 {
                                let question = questionAnswerComponents[0].trimmingCharacters(in: .whitespacesAndNewlines)
                                let answer = questionAnswerComponents[1].trimmingCharacters(in: .whitespacesAndNewlines)
                                
                                await MainActor.run {
                                    generatedQuestion = question
                                    generatedAnswer = answer
                                }
                            }
                        } catch {
                            print("Error: \(error)")
                            // Handle the error appropriately (e.g., show an error message to the user)
                        }
                    }
                }
            }
        }
struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}

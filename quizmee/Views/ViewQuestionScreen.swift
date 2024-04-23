//
//  ViewQuestionScreen.swift
//  quizmee
//
//  Created by Gabriel Thiessen on 4/20/24.
//

import SwiftUI

struct ViewQuestionScreen: View {
    @EnvironmentObject var chatViewModel: ChatView.ViewModel
    @State private var showAnswerModal = false

    var body: some View {
        VStack {
            Text("Studying: ")
                .font(.custom("Inter Bold", size: 24))
                .tracking(0.36) +
            Text(chatViewModel.currentInput)
                .font(.custom("Inter Bold", size: 24))
                .foregroundColor(Color(red: 0, green: 0.59, blue: 0.7))
                .tracking(0.36)

            Button(action: {
                showAnswerModal = true
            }) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(red: 0, green: 0.5921568870544434, blue: 0.6980392336845398))
                    .frame(width: 336, height: 346)
                    .overlay(
                        Text(chatViewModel.generatedQuestion)
                            .font(.custom("Inter Bold", size: 18))
                            .foregroundColor(.white)
                            .tracking(0.36)
                    )
            }

            Text("Click on the question to view the answer")
                .font(.custom("Inter Bold", size: 14))
                .foregroundColor(Color(red: 0, green: 0.59, blue: 0.7))
                .tracking(0.36)
                .multilineTextAlignment(.center)

            Button(action: {
                chatViewModel.generateQuestionAndAnswer()
            }) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(red: 0, green: 0.5921568870544434, blue: 0.6980392336845398))
                    .frame(width: 336, height: 50)
                    .overlay(
                        Text("Next Question")
                            .font(.custom("Inter Bold", size: 18))
                            .foregroundColor(.white)
                            .tracking(0.36)
                    )
            }

            Button(action: {
                // Action to perform when the "Save Question" button is tapped
            }) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(red: 0, green: 0.5921568870544434, blue: 0.6980392336845398))
                    .frame(width: 336, height: 50)
                    .overlay(
                        Text("Save Question")
                            .font(.custom("Inter Bold", size: 18))
                            .foregroundColor(.white)
                            .tracking(0.36)
                    )
            }
        }
        .sheet(isPresented: $showAnswerModal) {
            AnswerModal(answer: chatViewModel.generatedAnswer)
        }
    }
}

struct AnswerModal: View {
    let answer: String
    
    var body: some View {
        VStack {
            Text("Answer")
                .font(.title)
                .padding()
            
            Text(answer)
                .font(.body)
                .padding()
            
            Spacer()
        }
    }
}

struct ViewQuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        ViewQuestionScreen().environmentObject(ChatView.ViewModel())
    }
}

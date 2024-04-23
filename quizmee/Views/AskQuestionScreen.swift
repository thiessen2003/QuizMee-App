import SwiftUI

struct AskQuestionScreen: View {
    @EnvironmentObject var chatViewModel: ChatView.ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingViewQuestionScreen = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Write down what you want to study!")
                    .font(.custom("Inter Bold", size: 32))
                    .tracking(0.36)
                    .multilineTextAlignment(.center)
                    .padding()

                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(red: 0, green: 0.5921568870544434, blue: 0.6980392336845398))
                        .frame(height: 50)

                    TextField("Type a subject here", text: $chatViewModel.currentInput)
                        .font(.custom("Inter Semi Bold", size: 16))
                        .foregroundColor(Color.white)
                        .tracking(0.36)
                        .padding(.horizontal)
                }
                .padding(.horizontal)

                Button(action: {
                    chatViewModel.generateQuestionAndAnswer()
                    isShowingViewQuestionScreen = true
                    print(chatViewModel.generatedQuestion)
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(red: 0, green: 0.5921568870544434, blue: 0.6980392336845398))
                            .frame(width: 141, height: 50)
                        Text("Study")
                            .font(.custom("Inter Bold", size: 16))
                            .foregroundColor(Color.white)
                            .tracking(0.36)
                    }
                }
                .padding(.top)
                .sheet(isPresented: $isShowingViewQuestionScreen) {
                    ViewQuestionScreen()
                        .environmentObject(self.chatViewModel)
                }

                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 147, height: 148)
                    .padding()
            }
            .navigationBarTitle("Ask Question", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct AskQuestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        AskQuestionScreen().environmentObject(ChatView.ViewModel())
    }
}

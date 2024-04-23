//
//  HomeScreen.swift
//  quizmee
//
//  Created by Gabriel Thiessen on 4/20/24.
//

import SwiftUI

struct HomeScreen: View {
    @State private var showAskQuestionScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                //Quiz time!
                HStack {
                    Text("Quiz time!")
                        .font(.custom("Inter Bold", size: 24))
                        .tracking(0.36)
                    
                    Image("1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
                
                //"Lorem ipsum dolor sit ame...
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .font(.custom("Inter Semi Bold", size: 12))
                    .tracking(0.36)
                    .padding()
                
                //Practice
                Text("Practice")
                    .font(.custom("Inter Bold", size: 24))
                    .tracking(0.36)
                
                Button(action: {
                    showAskQuestionScreen = true
                }) {
                    ZStack {
                        //Rectangle 1
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(red: 0, green: 0.5921568870544434, blue: 0.6980392336845398))
                            .frame(height: 170)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                //Click to practice
                                Text("Click to practice")
                                    .font(.custom("Inter Bold", size: 19))
                                    .foregroundColor(Color.white)
                                    .tracking(0.36)
                                
                                //"Lorem ipsum dolor sit ame...
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do")
                                    .font(.custom("Inter Semi Bold", size: 13))
                                    .foregroundColor(Color.white)
                                    .tracking(0.36)
                            }
                            .padding()
                            
                            Spacer()
                            
                            Image("3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .padding()
                        }
                    }
                    .navigationBarTitle("Home")
                                .sheet(isPresented: $showAskQuestionScreen) {
                                    AskQuestionScreen()
                                }
                }
                .padding()
                
                
                //Study
                Text("Study")
                    .font(.custom("Inter Bold", size: 24))
                    .tracking(0.36)
                
                Button(action: {
                    // Action to perform when the "Study" button is tapped
                }) {
                    ZStack {
                        //Rectangle 1
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(red: 0, green: 0.5921568870544434, blue: 0.6980392336845398))
                            .frame(height: 170)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                //Click to study
                                Text("Click to study")
                                    .font(.custom("Inter Bold", size: 19))
                                    .foregroundColor(Color.white)
                                    .tracking(0.36)
                                
                                //"Lorem ipsum dolor sit ame...
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do")
                                    .font(.custom("Inter Semi Bold", size: 13))
                                    .foregroundColor(Color.white)
                                    .tracking(0.36)
                            }
                            .padding()
                            
                            Spacer()
                            
                            Image("4")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .padding()
                        }
                    }
                }
                
                .padding()
            }
        }
    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().environmentObject(ChatView.ViewModel())
    }
}

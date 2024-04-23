//
//  LoadingScreen.swift
//  quizmee
//
//  Created by Gabriel Thiessen on 4/20/24.
//

import SwiftUI

struct LoadingScreen: View {
    @State private var isLoadingComplete = false

    var body: some View {
            ZStack {
                //Ellipse 8
                ZStack {
                    Ellipse()
                        .fill(LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color(red: 0.3607843220233917, green: 0.8823529481887817, blue: 0.9019607901573181), location: 0),
                                .init(color: Color(red: 1, green: 1, blue: 1), location: 0.33),
                                .init(color: Color(red: 0.883778989315033, green: 0.9786096215248108, blue: 0.9821746945381165), location: 0.66),
                                .init(color: Color(red: 0.3607843220233917, green: 0.8823529481887817, blue: 0.9019607901573181), location: 1)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                    
                    Ellipse()
                        .strokeBorder(Color.black, lineWidth: 1)
                }
                .frame(width: 636, height: 1164)
                .opacity(0.8)
                
                //StatusBar
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 390, height: 47)
                
                //Unlimited (3) 1
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 500, height: 500)
                    .offset(y: -100)
                
                //Unlimited (1) 1
                Image("2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 418, height: 417)
                    .offset(y: 100)
            }.onAppear {
                // Start a timer to simulate loading
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    isLoadingComplete = true
                }
            }
            .fullScreenCover(isPresented: $isLoadingComplete) {
                HomeScreen()
            }
        }
    }

#Preview {
    LoadingScreen()
}

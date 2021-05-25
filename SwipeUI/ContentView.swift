//
//  ContentView.swift
//  SwipeUI
//
//  Created by Jorge Giannotta on 20/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var goToHome = false
    
    var body: some View {
        ZStack {
            if goToHome {
                ComplexHomeView()
            }else {
                OnBoardScreenView()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("Success")), perform: { _ in
            withAnimation{ self.goToHome = true }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

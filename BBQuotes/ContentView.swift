//
//  ContentView.swift
//  BBQuotes
//
//  Created by Pallavi Joshi on 17/09/2024.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView {
            QuoteView(show: Constants.bbName, quoteType: QuoteType.breakingbad)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bbName, systemImage: "tortoise")
                }
            
            QuoteView(show:Constants.betterCallSaul, quoteType: QuoteType.bettercallsaul)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.betterCallSaul, systemImage: "briefcase")
                }
            
            QuoteView(show:Constants.elCamino, quoteType: QuoteType.elcamino)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.elCamino, systemImage: "car")
                }
        }
}
}

#Preview {
    ContentView()
}

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
            QuoteView(quoteType: QuoteType.breakingbad)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            QuoteView(quoteType: QuoteType.bettercallsaul)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Better Call Saul", systemImage: "briefcase")
                }
        }
}
}

#Preview {
    ContentView()
}

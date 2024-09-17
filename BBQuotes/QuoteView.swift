//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Pallavi Joshi on 17/09/2024.
//

import SwiftUI

struct QuoteView: View {
    let quoteType: QuoteType
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(quoteType.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

enum QuoteType {
    case breakingbad
    case bettercallsaul
    
    var image: String {
        switch(self) {
        case .breakingbad: "breakingbad"
        case .bettercallsaul: "bettercallsaul"
        }
    }
}

#Preview {
    QuoteView(quoteType: QuoteType.breakingbad)
}

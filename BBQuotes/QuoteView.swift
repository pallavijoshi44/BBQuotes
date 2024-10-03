//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Pallavi Joshi on 29/09/2024.
//

import SwiftUI

struct QuoteView: View {
    let show: String
    let quote : Quote
    let character: Character

    var body: some View {
            VStack {
                Text("\"\(quote.quote)\"")
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 25))
                    .padding(.horizontal)
                
                ZStack(alignment:.bottom){
                    AsyncImage(url: character.images[0]) {
                        image in
                        image
                            .resizable()
                            .scaledToFill()
                        
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(quote.character)
                        .foregroundStyle(.white)
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                    
                }
            }
        
    }
}

#Preview {
    QuoteView(show: "Breaking Bad", quote: ViewModel().quote, character: ViewModel().character)
}

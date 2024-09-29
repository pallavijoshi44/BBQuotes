//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Pallavi Joshi on 17/09/2024.
//

import SwiftUI

struct QuoteView: View {
    var vm = ViewModel()
    let quoteType: QuoteType
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(quoteType.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                VStack{
                    Text("\"\(vm.quote.quote)\"")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.5))
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.horizontal)
                    
                    ZStack(alignment:.bottom){
                        AsyncImage(url: vm.character.images[0]) {
                            image in
                            image
                                .resizable()
                                .scaledToFill()
                            
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text(vm.quote.character)
                            .foregroundStyle(.white)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                        
                    }
                    .frame(width: geo.size.width/1.1, height: geo.size.height/1.5)
                    .clipShape(.rect(cornerRadius: 50))
                }
                .frame(width: geo.size.width)
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

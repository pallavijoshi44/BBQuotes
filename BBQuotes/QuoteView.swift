//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Pallavi Joshi on 17/09/2024.
//

import SwiftUI

let vm = ViewModel()

struct QuoteView: View {
    let show: String
    let quoteType: QuoteType

    @State var showCharacterInfo: Bool = false
    
    var body: some View {
        let showWithoutSpace: String =  show.replacingOccurrences(of: " ", with:"")
      
        GeometryReader { geo in
            ZStack
            {
                Image(showWithoutSpace.lowercased())
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack{
                    VStack{
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted: EmptyView()
                        case .fetching: ProgressView()
                        case .error(let error): Text(error.localizedDescription)
                        case .success:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
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
                            .onTapGesture {
                                showCharacterInfo.toggle()
                            }
                        }
                        
                        Spacer()
                    }
                    
                    Button(
                        action: {
                            Task {
                               await vm.getData(for: show)
                            }
                        },
                        label: {
                            Text("Get A Random Quote")
                                .font(.title)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(showWithoutSpace)Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color: Color("\(showWithoutSpace)Shadow"), radius:2)
                        })
                    
                    Spacer(minLength: 95)
                    
                }
                .frame(width: geo.size.width, height: geo.size.height)
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
            
            
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterInfo, content: {
            CharacterView(show: show, character: vm.character)
        })
    }
}

enum QuoteType {
    case breakingbad
    case bettercallsaul
    case elcamino
    
    var image: String {
        switch(self) {
        case .breakingbad: "breakingbad"
        case .bettercallsaul: "bettercallsaul"
        case .elcamino: "elcamino"
        }
    }
}

#Preview {
    QuoteView(show: "Better Call Saul", quoteType: QuoteType.breakingbad)
}

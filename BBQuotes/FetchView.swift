//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Pallavi Joshi on 17/09/2024.
//

import SwiftUI

let vm = ViewModel()

struct FetchView: View {
    let show: String
    let quoteType: QuoteType
    @State var showCharacterInfo: Bool = false
    
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                Image(show.removeSpaceAndCase())
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack {
                    VStack{
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted: EmptyView()
                        case .fetching: ProgressView()
                        case .error(let error): Text(error.localizedDescription)
                        case .quoteSuccess:
                            QuoteView(show: show, quote: vm.quote, character: vm.character)
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.5)
                                .clipShape(.rect(cornerRadius: 50))
                                .onTapGesture {
                                    showCharacterInfo.toggle()
                                }
                            Spacer()
                            
                        case .episodeSuccess: 
                            EpisodeView(episode: vm.episode)
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.5)
                                .clipShape(.rect(cornerRadius: 30))
        
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Button(
                            action: {
                                Task {
                                    await vm.getData(for: show)
                                }
                            },
                            label: {
                                Text("Get Random Quote")
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(Color("\(show.removeSpaces())Button"))
                                    .clipShape(.rect(cornerRadius: 7))
                                    .shadow(color: Color("\(show.removeSpaces())Shadow"), radius:2)
                            }
                        )
                        Spacer()
                        
                        Button(
                            action: {
                                Task {
                                    await vm.getEpisode(for: show)
                                }
                            },
                            label: {
                                Text("Get Random Episode")
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(Color("\(show.removeSpaces())Button"))
                                    .clipShape(.rect(cornerRadius: 7))
                                    .shadow(color: Color("\(show.removeSpaces())Shadow"), radius:2)
                            }
                        )
                    }
                    
                    Spacer(minLength: 95)
                
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .frame(width: geo.size.width, height: geo.size.height)
    }
        .sheet(isPresented: $showCharacterInfo, content: {
            CharacterView(show: show, character: vm.character)
        })
        .ignoresSafeArea()
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
    FetchView(show: "Better Call Saul", quoteType: QuoteType.breakingbad)
}

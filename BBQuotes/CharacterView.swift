//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Pallavi Joshi on 29/09/2024.
//

import SwiftUI

struct CharacterView: View {
    let show: String
    let character: Character
    
    var body: some View {
        ScrollViewReader { proxy in
            GeometryReader { geo in
                ZStack(alignment:.top) {
                    Image(show.lowercased().replacingOccurrences(of: " ", with:""))
                        .resizable()
                        .scaledToFit()
                    
                    ScrollView {
                        TabView {
                            ForEach(character.images, id: \.self) { characterImg in
                                AsyncImage(url: characterImg) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                        .clipShape(.rect(cornerRadius: 50))
                        .padding(.top, 60)
                        
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .padding(.top, 5)
                                .font(.title)
                            
                            Text("Portrayed by: \(character.portrayedBy)")
                            
                            
                            Text("\(character.name) Character Info:")
                                .padding(.top, 5)
                                .font(.title3)
                            
                            Text("Born on: \(character.birthday)")
                            
                            Divider()
                            
                            Text("Occupations:")
                                .padding(.top, 5)
                                .font(.subheadline)
                            
                            ForEach(character.occupations, id: \.self) { occupation in
                                Text("\u{2022} \(occupation)")
                                    .font(.subheadline)
                            }
                            Divider()
                            
                            Text("NickNames:")
                                .padding(.top, 5)
                                .font(.subheadline)
                            
                            if (character.aliases.count > 0) {
                                ForEach(character.aliases, id: \.self) { alias in
                                    Text("\u{2022} \(alias)")
                                        .font(.subheadline)
                                }
                            } else {
                                Text("None") .font(.subheadline)
                            }
                            
                            DisclosureGroup("Status (Spoiler Alert!)") {
                                VStack(alignment: .leading) {
                                    Text(character.status).font(.title2)
                                    
                                    if let death = character.death {
                                        AsyncImage(url: death.image) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 15))
                                                .onAppear {
                                                    withAnimation{
                                                        proxy.scrollTo(1, anchor: .bottom)
                                                    }
                                                }
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        Text("How: \(death.details):").padding(.bottom, 7)
                                        Text("Last words: \(death.lastWords)")
                                        
                                        
                                    }  
                                    
                                }.frame(width: .infinity, alignment: .leading)
                            }
                            .id(1)
                            .tint(.primary)
                            
                        }
                        .frame(width: geo.size.width/1.25)
                        .padding(.bottom, 50)
                    }.scrollIndicators(.hidden)
                }
            }
            
        }.ignoresSafeArea()
    }
}

#Preview {
    CharacterView(show: "Breaking Bad", character: ViewModel().character)
}

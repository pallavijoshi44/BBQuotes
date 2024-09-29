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
        GeometryReader { geo in
            ZStack(alignment:.top) {
                Image(show.lowercased().replacingOccurrences(of: " ", with:""))
                    .resizable()
                    .scaledToFit()
                
                ScrollView {
                    AsyncImage(url: character.images[0]) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
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
                        
                        
                    }
                    .frame(width: geo.size.width/1.25)
                }
            }
            
        }.ignoresSafeArea()
    }
}

#Preview {
    CharacterView(show: "Breaking Bad", character: ViewModel().character)
}

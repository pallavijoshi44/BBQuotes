//
//  EpisodeView.swift
//  BBQuotes
//
//  Created by Pallavi Joshi on 29/09/2024.
//

import SwiftUI

struct EpisodeView: View {
    let episode: Episode
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(episode.title)
                    .font(.largeTitle)
                
                Text("Episodes: \(episode.seasonEpisode)")
                    .font(.title2)
                
                AsyncImage(url: episode.image) {
                    image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                }
                Text("\(episode.synopsis)")
                    .font(.title3)
                    .minimumScaleFactor(0.5)
                
                Text("Written by: \(episode.writtenBy)")
                    .font(.title3)
                    .padding(.top, 5)
                
                Text("Directed by: \(episode.directedBy)")
                    .font(.title3)
                
                Text("Aired On: \(episode.airDate)")
                    .font(.title3)
            } 
            .padding()
            .foregroundStyle(.white)
            .background(.black.opacity(0.5))    }
}

#Preview {
    EpisodeView(episode: ViewModel().episode).preferredColorScheme(.dark)
}

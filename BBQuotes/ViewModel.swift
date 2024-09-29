//
//  BBQuotesViewModel.swift
//  BBQuotes
//
//  Created by Pallavi Joshi on 23/09/2024.
//

import Foundation

@Observable
class ViewModel  {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case error(error: Error)
    }
    
    
    private(set) var status: FetchStatus = .notStarted
    private let service = QuotesService()
    
    var quote : Quote
    var character: Character
    
    init() {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Character.self, from: characterData)
        
        let deathData = try! Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)
        character.death = try! decoder.decode(Death.self, from: deathData)
    }
    
    func getData (for show: String) async {
        status = .fetching
        do {
            quote = try await service.fetchQuote(from: show)
            character = try await service.fetchCharacter(from: quote.character)
            character.death = try await service.fetchDeath(for: character.name)
            status = .success
        } catch  {
            status = .error(error: error)
        }
    }
}

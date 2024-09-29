//
//  QuotesService.swift
//  BBQuotes
//
//  Created by Pallavi Joshi on 23/09/2024.
//

import Foundation
import SwiftUI

class QuotesService {
    enum FetchError: Error {
        case badResponse
    }
    
    var baseUrl =  URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote  {
        let quoteUrl = baseUrl.appending(path: "quotes/random")
        let fetchURL = quoteUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: fetchURL))
        
        guard let response = response as? HTTPURLResponse?, response?.statusCode == 200  else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quote =  try decoder.decode(Quote.self, from: data)
        return quote
    }
    
    func fetchCharacter(from name: String) async throws -> Character  {
        let characterUrl = baseUrl.appending(path: "characters")
        let fetchURL = characterUrl.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: fetchURL))
        
        guard let response = response as? HTTPURLResponse?, response?.statusCode == 200  else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters =  try decoder.decode([Character].self, from: data)
        return characters[0]
    }
    
    
    func fetchDeath(for character: String) async throws -> Death?  {
        let deathUrl = baseUrl.appending(path: "deaths")
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: deathUrl))
        
        guard let response = response as? HTTPURLResponse?, response?.statusCode == 200  else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths =  try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if (death.character == character) {
                return death
            }
        }
        
        return nil
    }
}

struct Quote: Decodable {
    let quoteId : Int
    let quote: String
    let character: String
    let production: String
    let episode: Int
}

struct Character: Decodable {
    let characterId : Int
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let fullName: String
    let aliases: [String]
    let status: String
    let portrayedBy: String
    let productions: [String]
    var death: Death?
    
    
    enum CodingKeys: CodingKey {
        case characterId
        case name
        case birthday
        case occupations
        case images
        case fullName
        case aliases
        case status
        case portrayedBy
        case productions
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.characterId = try container.decode(Int.self, forKey: .characterId)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupations = try container.decode([String].self, forKey: .occupations)
        self.images = try container.decode([URL].self, forKey: .images)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.status = try container.decode(String.self, forKey: .status)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        self.productions = try container.decode([String].self, forKey: .productions)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let deathData = try Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)
        self.death = try decoder.decode(Death.self, from: deathData)
    }
}

struct Death: Decodable {
    let deathId : Int
    let character: String
    let image: URL
    let cause: String
    let details: String
    let responsible: [String]
    let connected: [String]
    let lastWords: String
    let episode: Int
    let production: String
}

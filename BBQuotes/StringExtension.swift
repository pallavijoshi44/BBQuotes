//
//  StringKT.swift
//  BBQuotes
//
//  Created by Pallavi Joshi on 29/09/2024.
//

import Foundation

extension String {
    
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with:"")
    }
    
    func removeSpaceAndCase() -> String {
        self.removeSpaces().lowercased()
    }
}

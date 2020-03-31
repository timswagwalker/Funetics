//
//  Word.swift
//  Funetics
//
//  Created by Tanay Nistala on 3/26/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
 
struct Words: View {
    let words: [Word] = load("Words.json")
    
    var body: some View {
        VStack {
            List(words) { word in
                Text(word.word)
            }
        }
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

struct Word: Decodable, Identifiable {
    public var id: Int
    public var word: String
    public var option_a: String
    public var option_b: String
    public var option_c: String
    public var option_d: String
    public var correct: String
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case word = "word"
            case option_a = "option_a"
            case option_b = "option_b"
            case option_c = "option_c"
            case option_d = "option_d"
            case correct = "correct_option"
        }
}

struct Word_Previews: PreviewProvider {
    static var previews: some View {
        Words()
    }
}

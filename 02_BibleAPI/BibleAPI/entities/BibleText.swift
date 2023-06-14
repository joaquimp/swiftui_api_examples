// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(BibleText.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct BibleText: Codable {
    let reference: String
    let verses: [Verse]
    let text, translationID, translationName, translationNote: String
    
    enum CodingKeys: String, CodingKey {
        case reference, verses, text
        case translationID = "translation_id"
        case translationName = "translation_name"
        case translationNote = "translation_note"
    }
}

// MARK: - Verse
struct Verse: Codable {
    let bookID, bookName: String
    let chapter, verse: Int
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case bookID = "book_id"
        case bookName = "book_name"
        case chapter, verse, text
    }
}

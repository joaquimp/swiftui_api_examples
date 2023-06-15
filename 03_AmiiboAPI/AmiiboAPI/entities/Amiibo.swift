//
//  User.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AmiiboAPI: Codable {
    let amiibo: [Amiibo]
}

// MARK: - Amiibo
struct Amiibo: Codable {
    let amiiboSeries, character, gameSeries: String
    let image: String
    let name: String
}

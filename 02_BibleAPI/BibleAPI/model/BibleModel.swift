//
//  UserModel.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//

import Foundation

class BibleModel: ObservableObject {
    @Published var bibleText: BibleText?
    @Published var loading: Bool = false
    @Published var error: BibleError?
    
    @MainActor func getVerse(reference: String) async {
        let ref = reference.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        guard let url = URL(string: "https://bible-api.com/\(ref)") else {
            self.error = .invalidURL
            return
        }
        self.error = nil
        self.loading = true
        self.bibleText = nil
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            self.loading = false
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.error = .invalidResponse
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(BibleText.self, from: data)
                self.bibleText = decoded
            } catch let error {
                print("Error decoding: ", error)
                self.error = .requestError
            }
        } catch {
            print("Request error: ", error)
            self.error = .requestError
        }
    }
}

enum BibleError {
    case requestError
    case invalidData
    case invalidURL
    case invalidResponse
}

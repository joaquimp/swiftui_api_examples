//
//  UserModel.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//

import Foundation

class AmiiboModel: ObservableObject {
    @Published var amiibos: [Amiibo] = []
    @Published var loading: Bool = false
    @Published var error: AmiiboError?
    
    @MainActor func getAmiibo(name: String) async {
        guard let url = URL(string: "https://www.amiiboapi.com/api/amiibo/?name=\(name)") else {
            self.error = .invalidURL
            return
        }
        self.error = nil
        self.loading = true
        self.amiibos = []
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            self.loading = false
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.error = .invalidResponse
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(AmiiboAPI.self, from: data)
                self.amiibos = decoded.amiibo
            } catch let error {
                print("Error decoding: ", error)
                self.error = .invalidData
            }
        } catch {
            self.loading = false
            print("Request error: ", error)
            self.error = .requestError
        }
    }
}

enum AmiiboError {
    case requestError
    case invalidData
    case invalidURL
    case invalidResponse
}


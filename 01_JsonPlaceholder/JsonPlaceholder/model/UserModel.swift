//
//  UserModel.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//
//  https://designcode.io/swiftui-advanced-handbook-http-request

import Foundation

class UserModel: ObservableObject {
    @Published var users: [User] = []
    @Published var loading: Bool = false
    @Published var error: UserError?
    
    @MainActor func getUsers() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            self.error = .invalidURL
            return
        }
        self.error = nil
        self.loading = true
        self.users = []
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            self.loading = false
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.error = .invalidResponse
                return
            }
            
            
            do {
                let decodedUsers = try JSONDecoder().decode([User].self, from: data)
                self.users = decodedUsers
            } catch let error {
                print("Error decoding: ", error)
                self.error = .invalidData
            }
        } catch {
            print("Request error: ", error)
            self.error = .requestError
        }
    }
}

enum UserError: Error {
    case requestError
    case invalidURL
    case invalidResponse
    case invalidData
}

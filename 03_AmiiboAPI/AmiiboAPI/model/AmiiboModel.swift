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
    
    func getAmiibo(name: String) {
        guard let url = URL(string: "https://www.amiiboapi.com/api/amiibo/?name=\(name)") else { fatalError("Missing URL") }
        loading = true
        amiibos = []
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                self.loading = false
            }
            
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decoded = try JSONDecoder().decode(AmiiboAPI.self, from: data)
                        self.amiibos = decoded.amiibo
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}

//
//  UserModel.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//
//  https://designcode.io/swiftui-advanced-handbook-http-request

import Foundation

class BibleModel: ObservableObject {
    @Published var bibleText: BibleText?
    @Published var loading: Bool = false
    
    func getVerse(reference: String) {
        let ref = reference.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        guard let url = URL(string: "https://bible-api.com/\(ref)") else { fatalError("Missing URL") }
        loading = true
        bibleText = nil
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // por ser uma acao assincrona o codigo nao sera executado
            // na thread principal (thread que executa os codigos de atualizacao
            // de tela)
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
                        let decoded = try JSONDecoder().decode(BibleText.self, from: data)
                        self.bibleText = decoded
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}

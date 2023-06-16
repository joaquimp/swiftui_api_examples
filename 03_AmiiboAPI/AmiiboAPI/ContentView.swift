//
//  ContentView.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var amiiboModel = AmiiboModel()
    @State var character = "mario"
    
    private func getAmiibo() {
        Task {
            await amiiboModel.getAmiibo(name: character)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Character")
                        TextField("mario", text: $character)
                        Button {
                            getAmiibo()
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                    List {
                        ForEach(0..<amiiboModel.amiibos.count, id: \.self) { index in
                            AmiiboView(amiibo: amiiboModel.amiibos[index])
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listStyle(.plain)
                }
                
                if amiiboModel.loading {
                    LoadingView()
                } else {
                    if amiiboModel.amiibos.count == 0 {
                        EmptyView()
                    }
                }
            }.padding()
            .navigationTitle("AmiiboAPI")
        }.task {
            getAmiibo()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

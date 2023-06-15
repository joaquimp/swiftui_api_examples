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
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("Character")
                        TextField("mario", text: $character)
                        Button {
                            amiiboModel.getAmiibo(name: character)
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }

                    }
                    List {
                        ForEach(0..<amiiboModel.amiibos.count, id: \.self) { index in
                            AmiiboView(amiibo: amiiboModel.amiibos[index])
                        }
                    }
                }
                
                if amiiboModel.loading {
                    LoadingView()
                } else {
                    if amiiboModel.amiibos.count == 0 {
                        EmptyView()
                    }
                }
            }
        }
        .padding([.leading, .trailing])
        .onAppear {
            amiiboModel.getAmiibo(name: character)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

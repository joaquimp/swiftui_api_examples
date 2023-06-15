//
//  ContentView.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bibleModel = BibleModel()
    @State var reference = "john 3:17"
    
    private func getVerse() {
        Task {
            await bibleModel.getVerse(reference: reference)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    HStack {
                        Text("Reference:")
                        TextField("john 3:17", text: $reference)
                        Button {
                            getVerse()
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                    .padding()
                    
                    if let bibleText = bibleModel.bibleText {
                        ReferenceView(bibleText: bibleText)
                            .padding()
                    }
                    
                    Spacer()
                }
                
                if bibleModel.loading {
                    LoadingView()
                } else {
                    if bibleModel.bibleText == nil {
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Bible Search")
        }
        .task {
            getVerse()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

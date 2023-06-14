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
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("Reference:")
                        TextField("john 3:17", text: $reference)
                        Button {
                            bibleModel.getVerse(reference: reference)
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
        .padding([.leading, .trailing])
        .onAppear {
            // descomentar para fazer loading no início
            bibleModel.getVerse(reference: reference)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

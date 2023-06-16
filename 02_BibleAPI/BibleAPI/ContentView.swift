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
    @State var translation = "almeida"
    
    private func getVerse() {
        Task {
            await bibleModel.getVerse(reference: reference, translation: translation)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    HStack {
                        Text("Translation: ")
                        Picker("Translation", selection: $translation) {
                            Text("Cherokee (Cherokee New Testament)").tag("cherokee")
                            Text("English (Bible in Basic English)").tag("bbe")
                            Text("English (King James Version)").tag("kjv")
                            Text("English (World English Bible)").tag("web")
                            Text("English - UK (Open English Bible, Commonwealth Edition)").tag("oeb-cw")
                            Text("English - UK (World English Bible, British Edition)").tag("webbe")
                            Text("English - US (Open English Bible, US Edition)").tag("oeb-us")
                            Text("Latin (Clementine Latin Vulgate)").tag("clementine")
                            Text("Portuguese (João Ferreira de Almeida)").tag("almeida")
                            Text("Romanian (Protestant Romanian Corrected Cornilescu Version)").tag("rccv")
                        }
                    }.padding()
                    HStack {
                        Text("Reference:")
                        TextField("john 3:17", text: $reference)
                        Button {
                            getVerse()
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }.padding()
                    
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
            .onChange(of: translation) { _ in
                getVerse()
            }
        }
        .navigationViewStyle(.stack)
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

//
//  UserRow.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//

import SwiftUI

struct AmiiboView: View {
    var amiibo: Amiibo
    
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: URL(string: amiibo.image)) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                                
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure:
                            Image("boo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        @unknown default:
                            // Since the AsyncImagePhase enum isn't frozen,
                            // we need to add this currently unused fallback
                            // to handle any new cases that might be added
                            // in the future:
                            EmptyView()
                    }
                }.frame(maxWidth: 140, maxHeight: 140)
                Text(amiibo.name)
                    .foregroundColor(Color("cardText"))
                    .font(.title)
                Text(amiibo.gameSeries)
                    .foregroundColor(Color("cardText"))
            }
            .frame(maxWidth: .infinity)
        }
        .frame(width: 240, height: 240, alignment: .center)
        .background(Color("card"))
        .cornerRadius(42)
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            AmiiboView(amiibo: Amiibo(
                amiiboSeries: "Super Smash Bros.",
                character: "Mario",
                gameSeries: "Super Mario",
                image: "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_00000000-00000002.png",
                name: "Mario"))
            
            AmiiboView(amiibo: Amiibo(
                amiiboSeries: "Super Smash Bros.",
                character: "Mario",
                gameSeries: "Super Mario",
                image: "abc",
                name: "Mario"))
        }
    }
}

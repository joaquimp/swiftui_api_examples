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
            Color("card")
            VStack() {
                AsyncImage(url: URL(string: amiibo.image)) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: 200, maxHeight: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 200, maxHeight: 200)
                        case .failure:
                            Image("boo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 200, maxHeight: 200)
                        @unknown default:
                            // Since the AsyncImagePhase enum isn't frozen,
                            // we need to add this currently unused fallback
                            // to handle any new cases that might be added
                            // in the future:
                            EmptyView()
                    }
                }
                Text(amiibo.name)
                    .foregroundColor(Color.white)
                    .font(.title)
                Text(amiibo.gameSeries)
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(width: 300, height: 300, alignment: .center)
        .cornerRadius(64)
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

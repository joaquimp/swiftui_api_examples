//
//  UserRow.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//

import SwiftUI

struct UserRowView: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .bold()
            Text(user.email.lowercased())
            Text(user.phone)
        }
        .frame(maxWidth: .infinity ,alignment: .leading)
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            UserRowView(user: User(
                id: 10,
                name: "Joca Filho",
                username: "Flanctun",
                email: "joaquim@email.com",
                address: Address(
                    street: "Rua da Consoloção 930",
                    suite: "",
                    city: "São Paulo",
                    zipcode: "00000-000",
                    geo: Geo(
                        lat: "-14.3990",
                        lng: "-120.7677")),
                phone: "+55 (11) 1234-5678",
                website: "www.mackenzie.br/joca",
                company: Company(
                    name: "Universidade Presbiteriana Mackenzie",
                    catchPhrase: "Isso é Mackenzie",
                    bs: "educação")))
            UserRowView(user: User(
                id: 10,
                name: "Juuuuu",
                username: "juflorzinha123",
                email: "ju@email.com",
                address: Address(
                    street: "Rua da Consoloção 930",
                    suite: "",
                    city: "São Paulo",
                    zipcode: "00000-000",
                    geo: Geo(
                        lat: "-14.3990",
                        lng: "-120.7677")),
                phone: "+55 (11) 1234-5678",
                website: "www.mackenzie.br/joca",
                company: Company(
                    name: "Universidade Presbiteriana Mackenzie",
                    catchPhrase: "Isso é Mackenzie",
                    bs: "educação")))
        }
        
    }
}

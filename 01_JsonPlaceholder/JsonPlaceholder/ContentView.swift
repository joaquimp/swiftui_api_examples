//
//  ContentView.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userModel = UserModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List(userModel.users) { user in
                    //                UserRow(user: user)
                    Text(user.name)
                }
                .refreshable {
                    userModel.getUsers()
                }
                .navigationTitle("Users")
                .toolbar {
                    Button {
                        userModel.getUsers()
                    } label: {
                        Image(systemName: "arrow.clockwise.icloud")
                    }

                }
                
                if userModel.loading {
                    LoadingView()
                } else {
                    if userModel.users.count == 0 {
                        EmptyView()
                    }
                }
            }
        }
        .padding([.leading, .trailing])
        .onAppear {
            // descomentar para fazer loading no início
//            userModel.getUsers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

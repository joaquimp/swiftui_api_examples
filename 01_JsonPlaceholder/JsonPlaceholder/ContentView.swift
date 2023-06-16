//
//  ContentView.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userModel = UserModel()
    
    private func getUsers() {
        Task {
            await userModel.getUsers()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                List(userModel.users) { user in
                    //UserRowView(user: user)
                    Text(user.name)
                }
                .refreshable {
                    getUsers()
                }
                
                if userModel.loading {
                    LoadingView()
                } else {
                    if userModel.users.count == 0 {
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Users")
            .toolbar {
                Button {
                    getUsers()
                } label: {
                    Image(systemName: "arrow.clockwise.icloud")
                }
            }
        }
        .navigationViewStyle(.stack)
        .task {
            // descomentar para fazer loading no início
//            await userModel.getUsers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

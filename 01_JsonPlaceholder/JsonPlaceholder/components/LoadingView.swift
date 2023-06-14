//
//  LoadingView.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("loading")
                .padding()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

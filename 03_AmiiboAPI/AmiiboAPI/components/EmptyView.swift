//
//  EmptyView.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack {
            Text("👀")
                .font(.largeTitle)
            Text("Nobody is herer")
                .foregroundColor(Color.gray)
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}

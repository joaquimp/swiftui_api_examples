//
//  UserRow.swift
//  JsonPlaceholder
//
//  Created by Joaquim Pessoa Filho on 14/06/23.
//

import SwiftUI

struct ReferenceView: View {
    var bibleText: BibleText
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(bibleText.reference)
                    .bold()
                Text("(\(bibleText.translationName))")
            }
            Text(bibleText.text.replacingOccurrences(of: "\n", with: ""))
                .padding([.leading])
        }
        .frame(maxWidth: .infinity ,alignment: .leading)
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceView(bibleText: BibleText(
            reference: "John 3:16",
            verses: [
                Verse(
                    bookID: "JHN",
                    bookName: "John",
                    chapter: 3,
                    verse: 16,
                    text: "For God so loved the world, that he gave his one and only Son, that whoever believes in him should not perish, but have eternal life.")
            ],
            text: "\nFor God so loved the world, that he gave his one and only Son, that whoever believes in him should not perish, but have eternal life.\n\n",
            translationID: "web",
            translationName: "World English Bible",
            translationNote: "Public Domain"))
    }
}

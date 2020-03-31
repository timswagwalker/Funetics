//
//  Syllables.swift
//  Funetics
//
//  Created by Tanay Nistala on 3/26/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct Syllable: Identifiable {
    var id = UUID()
    var name: String
}

struct SyllableRow: View {
    var syllable: Syllable

    var body: some View {
        HStack {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text(syllable.name)
            }
            Spacer()
        }
        .padding()
    }
}

struct Syllables_Previews: PreviewProvider {
    static var previews: some View {
        SyllableRow(syllable: Syllable(name: "hello"))
    }
}

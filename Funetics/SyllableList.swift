//
//  SyllableList.swift
//  Funetics
//
//  Created by Tanay Nistala on 3/26/20.
//  Copyright © 2020 Tanay Nistala. All rights reserved.
//

import SwiftUI

struct SyllableList: View {
    var syllables = [Syllable(name: "short a"),
                     Syllable(name: "short e"),
                     Syllable(name: "short i"),
                     Syllable(name: "short o"),
                     Syllable(name: "short u"),
                     Syllable(name: "short oo"),
                     Syllable(name: "long a"),
                     Syllable(name: "long e"),
                     Syllable(name: "long i"),
                     Syllable(name: "long o"),
                     Syllable(name: "long u"),
                     Syllable(name: "long oo"),
                     Syllable(name: "ar"),
                     Syllable(name: "er"),
                     Syllable(name: "or"),
                     Syllable(name: "b"),
                     Syllable(name: "k"),
                     Syllable(name: "d"),
                     Syllable(name: "f"),
                     Syllable(name: "g"),
                     Syllable(name: "h"),
                     Syllable(name: "j"),
                     Syllable(name: "l"),
                     Syllable(name: "m"),
                     Syllable(name: "n"),
                     Syllable(name: "p"),
                     Syllable(name: "r"),
                     Syllable(name: "s"),
                     Syllable(name: "t"),
                     Syllable(name: "v"),
                     Syllable(name: "w"),
                     Syllable(name: "y"),
                     Syllable(name: "z"),
                     Syllable(name: "bl"),
                     Syllable(name: "cl"),
                     Syllable(name: "fl"),
                     Syllable(name: "gl"),
                     Syllable(name: "pl"),
                     Syllable(name: "br"),
                     Syllable(name: "cr"),
                     Syllable(name: "dr"),
                     Syllable(name: "fr"),
                     Syllable(name: "gr"),
                     Syllable(name: "pr"),
                     Syllable(name: "tr"),
                     Syllable(name: "sk"),
                     Syllable(name: "sl"),
                     Syllable(name: "sp"),
                     Syllable(name: "st"),
                     Syllable(name: "sw"),
                     Syllable(name: "spr"),
                     Syllable(name: "str"),
                     Syllable(name: "ch"),
                     Syllable(name: "sh"),
                     Syllable(name: "gr"),
                     Syllable(name: "th (thing)"),
                     Syllable(name: "th (this)"),
                     Syllable(name: "wh"),
                     Syllable(name: "ng"),
                     Syllable(name: "nk"),
                     Syllable(name: "oi"),
                     Syllable(name: "ow"),
                     Syllable(name: "ey"),
                     Syllable(name: "aw"),
                     Syllable(name: "zh")]

    var body: some View {
        List {
            ForEach (syllables) { syllable in
                SyllableRow(syllable: syllable)
            }
        }
    }
}

struct SyllableList_Previews: PreviewProvider {
    static var previews: some View {
        SyllableList()
    }
}

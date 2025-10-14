//
//  CurrencyTip.swift
//  LOTRConverter
//
//  Created by Juan Martinez on 12/10/25.
//

import TipKit

struct CurrencyTip: Tip{
    var title = Text("Change Currency")
    var message: Text? = Text("You can tap left or right side to bring up the Select Currency screen")
    var image: Image? = Image(systemName: "hand.tap.fill")
}

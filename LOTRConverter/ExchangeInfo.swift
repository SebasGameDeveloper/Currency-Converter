//
//  ExchangeInfo.swift
//  LOTRConverter
//
//  Created by Juan Martinez on 30/09/25.
//

import SwiftUI

struct ExchangeInfo: View {
    
    @Environment(\.dismiss)var dismiss //Dismiss es una propiedad que cierra la hoja actual solo llamandola en la funcion, por esos e usa en button.
    
    var body: some View {
        ZStack{
            //Backgorund
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack{
                //Tittle
                Text("Exchange Rates")
                    .font(.largeTitle)
                    .tracking(2) //Espacio entre letras
                
                //Description
                Text("Here at the Prancing Pony, we are happy to offer you a place where you can exchange all the known currencies in the entire world except one. We used to take Brandy Bucks, but after finding out that it was a person instead of a piece of paper, we realized it had no value to us. Below is a simple guide to our currency exchange rates:")
                    .font(.title3)
                    .padding()
                
                //Exchange rates
                ExchangeRate(leftImage: .goldpiece, text: "1 Golden Piece = 4 Gold Pennies", rightImage: .goldpenny)
                ExchangeRate(leftImage: .goldpenny, text: "1 Golden Pennie = 4 Silver Pieces", rightImage: .silverpiece)
                ExchangeRate(leftImage: .silverpiece, text: "1 Silver Piece = 4 Silver Pennies", rightImage: .silverpenny)
                ExchangeRate(leftImage: .silverpenny, text: "1 Silver Penny = 4 Silver Pieces", rightImage: .silverpiece)
                
                //Done button
                Button("Done"){
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    ExchangeInfo()
}


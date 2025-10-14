//
//  Currency.swift
//  LOTRConverter
//
//  Created by Juan Martinez on 9/10/25.
//

import SwiftUI

enum Currency: Int, CaseIterable, Identifiable{ //Cambiamos Double por int para usar el AppStorage
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    var id: Currency {self}
    
    var exchangeRate: Double{ //convercion de moneda con esta nueva variable
        switch self{
        case .copperPenny: return 6400
        case .silverPenny: return 64
        case .silverPiece: return 16
        case .goldPenny: return 4
        case .goldPiece: return 1
        }
    }
    
    var image: ImageResource{
        switch self{
        case .copperPenny:
                .copperpenny
        case .silverPenny:
                .silverpenny
        case .silverPiece:
                .silverpiece
        case .goldPenny:
                .goldpenny
        case .goldPiece:
                .goldpiece
        }
    }
    
    var name: String{
        switch self{
        case .copperPenny:
            return "Copper Penny"
        case .silverPenny:
            return "Silver Penny"
        case .silverPiece:
            return "Silver Piece"
        case .goldPenny:
            return "Gold Penny"
        case .goldPiece:
            return "Gold Piece"
        }
    }
    
    func convert (_ amountString: String, to currency: Currency) -> String{
        guard let doubleAmount = Double(amountString)else{
            return ""
        }
        let convertedAmount = (doubleAmount / self.exchangeRate) * currency.exchangeRate
        return String (format: "%.2f", convertedAmount)
    }
}


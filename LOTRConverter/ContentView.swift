//
//  ContentView.swift
//  LOTRConverter
//
//  Created by Juan Martinez on 26/09/25.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @AppStorage("leftAmount") private var leftAmount: String = ""
    @AppStorage("rightAmount") private var rightAmount: String = ""
    
    @FocusState var lefTyping
    @FocusState var rightTyping
    
    //@State var leftCurrency: Currency = .silverPiece
    //@State var rightCurrency: Currency = .goldPiece
    
    @AppStorage("leftCurrency") private var leftCurrencyRaw: Int = Currency.silverPenny.rawValue
    @AppStorage("rightCurrency") private var rightCurrencyRaw: Int = Currency.goldPenny.rawValue
    
    //Computed Properties
    private var leftCurrency: Currency {
        get { Currency(rawValue: leftCurrencyRaw) ?? .silverPiece}
        set { leftCurrencyRaw = newValue.rawValue}
    }
    
    private var rightCurrency: Currency {
        get { Currency(rawValue: rightCurrencyRaw) ?? .goldPiece}
        set { rightCurrencyRaw = newValue.rawValue}
    }
    
    let currencyTip = CurrencyTip()
    
    var body: some View {
        ZStack{
            //Background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                //Pony image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()//esta ajusta el ancho por eso abajo solo esta height
                    .frame(height: 200)
                //Currency exchange text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                //Conversion section
                ConversionRow(
                    leftCurrency: leftCurrency,
                    rightCurrency: rightCurrency,
                    leftAmount: $leftAmount,
                    rightAmount: $rightAmount,
                    lefTyping: $lefTyping,
                    rightTyping: $rightTyping,
                    showSelectCurrency: $showSelectCurrency,
                    currencyTip: currencyTip
                )
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                
                Spacer()
                //Info button
                HStack {
                    Spacer()
                    
                    Button{
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing) //trailing es para no dejarlo exactamente en el borde
                    
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture{
            lefTyping = false
            rightTyping = false
        }
        
        /*.toolbar {
            ToolbarItemGroup(placement: .keyboard){
                Spacer()
                Button("Done"){
                    lefTyping = false
                    rightTyping = false
                }
            }
        }*/
        
        .task {
            try? Tips.configure()
        }
        
        .onChange(of: leftAmount) {
            if lefTyping {
                rightAmount = leftCurrency
                    .convert(leftAmount, to: rightCurrency)
            }
        }
        
        .onChange(of: rightAmount){
            if rightTyping{
                leftAmount = rightCurrency
                    .convert(rightAmount, to: leftCurrency)
            }
        }
        
        //convert
        .onChange(of: leftCurrency){
            leftAmount = rightCurrency
                .convert(rightAmount, to: leftCurrency)
        }
        
        .onChange(of: rightCurrency){
            rightAmount = leftCurrency
                .convert(leftAmount, to: rightCurrency)
        }
        
        //.border(.blue)
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo() //ACA se abre el sheet view, que posteriormente se cierra con el boton ya que tiene la funcion DISMISS
        }
        
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(
                topCurrency: Binding<Currency>(
                    get: { Currency(rawValue: leftCurrencyRaw) ?? .silverPiece },
                    set: { newValue in leftCurrencyRaw = newValue.rawValue }
                ),
                bottomCurrency: Binding<Currency>(
                    get: { Currency(rawValue: rightCurrencyRaw) ?? .goldPiece },
                    set: { newValue in rightCurrencyRaw = newValue.rawValue }
                )
            )
        }
    }
}

private struct ConversionRow: View {
    let leftCurrency: Currency
    let rightCurrency: Currency
    @Binding var leftAmount: String
    @Binding var rightAmount: String
    @FocusState.Binding var lefTyping: Bool
    @FocusState.Binding var rightTyping: Bool
    @Binding var showSelectCurrency: Bool
    let currencyTip: CurrencyTip

    var body: some View {
        HStack{
            //Left conversion section
            VStack{
                //Currency
                HStack{
                    //currency image
                    Image(leftCurrency.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 33)

                    //currency text
                    Text(leftCurrency.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                .padding(.bottom, -5)
                .onTapGesture {
                    showSelectCurrency.toggle()
                    currencyTip.invalidate(reason: .actionPerformed)
                }
                .popoverTip(currencyTip, arrowEdge: .bottom)

                //Text field
                TextField("Amount", text: $leftAmount)
                    .textFieldStyle(.roundedBorder)
                    .focused($lefTyping)
                    .keyboardType(.decimalPad)
            }
            //Equal sing
            Image(systemName: "equal")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .symbolEffect(.pulse)

            //Right conversion section
            VStack{
                //Currency
                HStack{
                    //currency text
                    Text(rightCurrency.name)
                        .font(.headline)
                        .foregroundStyle(.white)

                    //currency image
                    Image(rightCurrency.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 33)
                }
                .padding(.bottom, -5)
                .onTapGesture {
                    showSelectCurrency.toggle()
                    currencyTip.invalidate(reason: .actionPerformed)
                }

                //Text field
                TextField("Amount", text: $rightAmount)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .focused($rightTyping)
                    .keyboardType(.decimalPad)
            }
        }
    }
}

#Preview {
    ContentView()
}

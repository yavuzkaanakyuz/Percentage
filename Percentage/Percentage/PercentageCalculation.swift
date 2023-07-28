//
//  PercentageCalculation.swift
//  Percentage
//
//  Created by Yavuz Kaan Akyüz on 14.07.2023.
//

import SwiftUI


struct PercentageCalculation: View {
    @State private var number1 = ""
    @State private var number2 = ""
    @State private var result = 0.0
    @State private var showInfoPage = false
    @State private var showCalculatorPage = false
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .top) {
                    Text("Yüzde Hesaplama")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        showInfoPage.toggle()
                    }) {
                        Image(systemName: "questionmark.circle")
                            .font(.title)
                            .foregroundColor(.pink)
                    }
                    .padding(.trailing, 10)
                    .sheet(isPresented: $showInfoPage) {
                        InfoView()
                    }
                    
                    Button(action: {
                        showCalculatorPage.toggle()
                    }) {
                        Image(systemName: "plusminus.circle")
                            .font(.title)
                            .foregroundColor(.pink)
                    }
                    .padding(.trailing, 10)
                    .sheet(isPresented: $showCalculatorPage) {
                        CalculatorView()
                    }
                }
                
                TextField("Sayı", text: $number1)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                TextField("Yüzde", text: $number2)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                HStack {
                    Button(action: {
                        guard let num1 = Double(number1), let num2 = Double(number2) else {
                            return
                        }
                        result = (num1 * num2) / 100
                        hideKeyboard()
                    }) {
                        Text("Hesapla")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        number1 = ""
                        number2 = ""
                        result = 0
                        hideKeyboard()
                    }) {
                        Text("Sıfırla")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 20)
            }
            
            Text("Sonuç: \(formatNumber(result))")
                .font(.title)
                .fontWeight(.bold)
                .padding()
        }
        .padding()
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func formatNumber(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: number)) ?? ""
    }
}

struct InfoView: View {
    var body: some View {
        VStack {
            Text("Yüzdelik Hesaplama")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            Text("Yüzdelik hesaplama, bir sayının belirli bir yüzdesini hesaplamak için kullanılır. İlk sayıyı girin ve yüzde değerini girin, ardından 'Hesapla' düğmesine tıklayın. Sonuç, ilk sayının yüzde değerini temsil eder.")
                .font(.body)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding()
    }
}

struct PercentageCalculation_Previews: PreviewProvider {
    static var previews: some View {
        PercentageCalculation()
    }
}

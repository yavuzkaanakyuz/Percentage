//
//  CalculatorView.swift
//  Percentage
//
//  Created by Yavuz Kaan Akyüz on 14.07.2023.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"

    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct CalculatorView: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var value: Double?
    @State private var runningNumber: Double = 0
    @State private var currentOperation: Operation = .none

    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]

    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                HStack {
                    Spacer()
                    Text(value != nil ? formatNumber(value!) : "")
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }
                .padding()

                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }

    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = self.value ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = self.value ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = self.value ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = self.value ?? 0
            }
            else if button == .equal {
                let currentValue = self.value ?? 0
                switch self.currentOperation {
                case .add: self.value = runningNumber + currentValue
                case .subtract: self.value = runningNumber - currentValue
                case .multiply: self.value = runningNumber * currentValue
                case .divide: self.value = runningNumber / currentValue
                case .none:
                    break
                }
            }

            if button != .equal {
                self.value = nil
            }
        case .clear:
            self.value = nil
        case .decimal, .negative, .percent:
            break
        default:
            if self.value == nil {
                self.value = Double(button.rawValue) ?? 0
            }
            else {
                let number = Double(button.rawValue) ?? 0
                self.value = (self.value! * 10) + number
            }
        }
    }

    func formatNumber(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: number)) ?? ""
    }

    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

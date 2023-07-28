//
//  ContentView.swift
//  Percentage
//
//  Created by Yavuz Kaan Akyüz on 14.07.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PercentageCalculation()
                .font(.system(size: 30, weight: .bold, design: .rounded)) .tabItem {
                    Image(systemName: "equal.circle.fill")
                    Text("Yüzde")
                }
            IncreasePercentage()
                .font(.system(size: 30, weight: .bold, design: .rounded)) .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Artırma")
                }
            DecreasePercentage()
                .font(.system(size: 30, weight: .bold, design: .rounded)) .tabItem {
                    Image(systemName: "minus.circle.fill")
                    Text("Azaltma")
                }
            
            
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

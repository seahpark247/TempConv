//
//  ContentView.swift
//  TempConv
//
//  Created by Seah Park on 4/13/25.
//

import SwiftUI

enum TempType: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    
    var symbol: String {
        self == .celsius ? "°C" : "°F"
    }
    
    var opposite: TempType {
        self == .celsius ? .fahrenheit : .celsius
    }
    
    func convert(_ value: Double) -> Double {
        switch self {
        case .celsius:
            return (value * 9 / 5) + 32
        case .fahrenheit:
            return (value - 32) * 5 / 9
        }
    }
    
    func color(_ value: Double) -> Color {
        switch self {
        case .celsius:
            switch value {
            case 34...: return .red
            case 28..<34: return .orange
            case 25..<28: return .yellow
            case 20..<25: return .green
            case 10..<20: return .blue
            default: return .gray
            }
        case .fahrenheit:
            switch value {
            case 93.2...: return .red
            case 82.4..<93.2: return .orange
            case 77..<82.4: return .yellow
            case 68..<77: return .green
            case 50..<68: return .blue
            default: return .gray
            }
        }
    }
}

struct ContentView: View {
    @State private var myTemp: TempType = .celsius
    @State private var input: Double = 0.0
    var convertedOutput: Double {
        myTemp.convert(input)
    }
    
    var tempColor: Color {
        myTemp.color(input)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(tempColor.gradient.opacity(0.3))
                    .ignoresSafeArea()
                
                Form {
                    Section {
                        Picker("Select your temperature", selection: $myTemp) {
                            ForEach(TempType.allCases, id: \.self) { Text($0.rawValue) }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.top)
                    .listRowBackground(Color.clear)
                    
                    Section(myTemp.symbol) {
                        TextField(myTemp.rawValue, value: $input, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                    }
                    
                    Section {
                        HStack {
                            Spacer()
                            Image(systemName: "arrow.triangle.2.circlepath")
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.clear)
                    
                    Section(myTemp.opposite.symbol) {
                        Text(String(format: "%.2f", convertedOutput))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .navigationTitle("TempConv")
                .scrollContentBackground(.hidden)
            }
        }
    }

}


#Preview {
    ContentView()
}

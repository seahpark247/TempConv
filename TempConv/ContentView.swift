//
//  ContentView.swift
//  TempConv
//
//  Created by Seah Park on 4/13/25.
//

import SwiftUI


enum TempType {
    case celsius, fahrenheit
}

struct ContentView: View {
    @State private var myTemp = "Celsius"
    @State private var input = 0.0
    @State private var output = 0.0
    var tempColor: Color {
        if myTemp == "Celsius" {
            if input >= 34 {
                return .red
            } else if input >= 28 {
                return .orange
            } else if input >= 25 {
                return .yellow
            } else if input >= 20 {
                return .green
            } else if input >= 10 {
                return .blue
            } else {
                return .gray
            }
        } else {
            if input >= 93.20 {
                return .red
            } else if input >= 82.40 {
                return .orange
            } else if input >= 77 {
                return .yellow
            } else if input >= 68 {
                return .green
            } else if input >= 50 {
                return .blue
            } else {
                return .gray
            }
        }
    }
    
    let tempTypes = ["Celsius", "Fahrenheit"]
    
    var body: some View {
        NavigationStack{
            ZStack {
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(tempColor.gradient.opacity(0.3)).ignoresSafeArea()
                
                Form {
                    Section {
                        Picker("Select my temprature", selection: $myTemp) {
                            ForEach(tempTypes, id: \.self) { Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: myTemp) {
                            tempConvert()
                        }
                    }
                    .padding(.top)
                    .listRowBackground(Color.clear)
                    
                    Section(myTemp == "Celsius" ? "°C" : "°F") {
                        TextField("Celsius", value: $input, format: .number)
                            .onChange(of: input) {
                                tempConvert()
                            }
                    }.multilineTextAlignment(.center)
                    
                    Section {
                        HStack {
                            Spacer()
                            Image(systemName: "arrow.triangle.2.circlepath")
                            Spacer()
                        }
                    }.listRowBackground(Color.clear)
                    
                    Section(myTemp == "Celsius" ? "°F" : "°C") {
                        Text(String(format: "%.2f", output)).frame(maxWidth: .infinity, alignment: .center)
                    }
                }.navigationTitle("TempConv")
            }
        }.scrollContentBackground(.hidden)
    }
    
    func tempConvert() {
        if myTemp == "Celsius" {
            output = celsiusToFahrenheit()
        } else {
            output = fahrenheitToCelsius()
        }
    }
    
    func celsiusToFahrenheit() -> Double {
        return (input * 9.0 / 5.0) + 32.0
    }
    
    func fahrenheitToCelsius() -> Double {
        return (input - 32.0) * 5.0 / 9.0
    }
    
}

#Preview {
    ContentView()
}

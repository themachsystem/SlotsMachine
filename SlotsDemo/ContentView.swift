//
//  ContentView.swift
//  SlotsDemo
//
//  Created by Alvis Mach on 30/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var symbols = ["apple", "star", "cherry"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var credits = 1000
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    private var betAmount = 5
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 200/255.0, green: 143/255.0, blue: 32/255.0, opacity: 1.0))
                .ignoresSafeArea()
            Rectangle()
                .foregroundColor(Color(red: 228/255.0, green: 195/255.0, blue: 76/255.0, opacity: 1.0))
                .rotationEffect(Angle(degrees: 45))
                .ignoresSafeArea()
            VStack {
                HStack {
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text("SwiftUI Slots").foregroundColor(.white).bold()
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }.scaleEffect(2)
                Spacer()
                Text("Credits: \(credits)")
                    .padding(10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                Spacer()
                VStack {
                    HStack {
                        Slot(imageName: $symbols[numbers[0]], background: $backgrounds[0])
                        Slot(imageName: $symbols[numbers[1]], background: $backgrounds[1])
                        Slot(imageName: $symbols[numbers[2]], background: $backgrounds[2])
                    }
                    HStack {
                        Slot(imageName: $symbols[numbers[3]], background: $backgrounds[3])
                        Slot(imageName: $symbols[numbers[4]], background: $backgrounds[4])
                        Slot(imageName: $symbols[numbers[5]], background: $backgrounds[5])
                    }
                    HStack {
                        Slot(imageName: $symbols[numbers[6]], background: $backgrounds[6])
                        Slot(imageName: $symbols[numbers[7]], background: $backgrounds[7])
                        Slot(imageName: $symbols[numbers[8]], background: $backgrounds[8])
                    }
                }.padding(.horizontal, 10)
                Spacer()
                Button(action: {
                    self.processResults(true)
                }, label: {
                    Text("Spin")
                        .bold()
                        .padding(10)
                        .padding(.horizontal, 30)
                        .foregroundColor(.white)
                        .background(Color.pink)
                        .cornerRadius(20)
                })
                Spacer()
            }
        }
    }
    
    func processResults(_ isMax: Bool = false) {
        if !isMax {
            credits -= betAmount
        }
        else {
            credits -= betAmount * 5
        }
        backgrounds = backgrounds.map {_ in Color.white }

        if isMax {
            numbers = numbers.map {_ in Int.random(in: 0...symbols.count - 1) }
        }
        else {
            self.numbers[3] = Int.random(in: 0...symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...symbols.count - 1)
            print(numbers)
        }
        processWin(isMax)
    }
    
    func processWin(_ isMax: Bool = false) {
        var matches = 0
        if !isMax {
            if numbers[3] == numbers[4] && numbers[4] == numbers[5] {
                backgrounds[3] = Color.green
                backgrounds[4] = Color.green
                backgrounds[5] = Color.green
                matches += 1
            }
        }
        else {
            if numbers[0] == numbers[1] && numbers[1] == numbers[2] {
                backgrounds[0] = Color.green
                backgrounds[1] = Color.green
                backgrounds[2] = Color.green
                matches += 1
                print("match first row")
            }
            if numbers[3] == numbers[4] && numbers[4] == numbers[5] {
                backgrounds[3] = Color.green
                backgrounds[4] = Color.green
                backgrounds[5] = Color.green
                matches += 1
                print("match second row")
            }
            if numbers[6] == numbers[7] && numbers[7] == numbers[8] {
                backgrounds[6] = Color.green
                backgrounds[7] = Color.green
                backgrounds[8] = Color.green
                matches += 1
                print("match third row")
            }
            if numbers[0] == numbers[4] && numbers[4] == numbers[8] {
                backgrounds[0] = Color.green
                backgrounds[4] = Color.green
                backgrounds[8] = Color.green
                matches += 1
                print("match first diano")
            }
            if numbers[2] == numbers[4] && numbers[4] == numbers[6] {
                backgrounds[2] = Color.green
                backgrounds[4] = Color.green
                backgrounds[6] = Color.green
                print("match second diano")
                matches += 1
            }
        }

        if matches > 0 {
            credits += matches * betAmount
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro")
    }
}

struct Slot: View {
    @Binding var imageName: String
    @Binding var background: Color
    var body: some View {
        Image(imageName)
            .resizable()
            .background(background.opacity(0.5))
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(20)
    }
}

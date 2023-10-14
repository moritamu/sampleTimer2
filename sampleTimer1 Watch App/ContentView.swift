//
//  ContentView.swift
//  sampleTimer1 Watch App
//
//  Created by MsMacM on 2023/10/14.
//

import SwiftUI

struct ContentView: View {
    @State var timeVal = 1
    @State var timerScreenShow: Bool = false
    
    var body: some View {
        VStack {
            Text("Timer \(self.timeVal) 秒").font(.body)
            Picker(selection: self.$timeVal, label: Text("000").font(.subheadline)) {
                Text("1").tag(1).font(.title2)
                Text("5").tag(5).font(.title2)
                Text("10").tag(10).font(.title2)
                Text("30").tag(30).font(.title2)
                Text("60").tag(60).font(.title2)
            }
            NavigationStack{
                NavigationLink{
                    TimerView(timerScreenShow: $timerScreenShow, timeVal: timeVal)
                } label: {
                    Label("timer", systemImage: "figure.walk")
                        .font(.title3)
                }
            }
        }
        .padding()
    }
}
struct TimerView: View {
    @Binding var timerScreenShow: Bool
    @State var timeVal: Int
    
    var body: some View {
        Text("\(self.timeVal)")
    }
}

#Preview {
    ContentView()
}

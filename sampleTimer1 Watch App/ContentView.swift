//
//  ContentView.swift
//  sampleTimer1 Watch App
//
//  Created by MsMacM on 2023/10/14.
//  https://zenn.dev/ryo_kawamata/articles/timer-app-with-swift-ui

import SwiftUI

struct ContentView: View {
    @State var timeVal = 1
    @State var timerScreenShow: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Timer \(timeVal) 秒").font(.body)
                Picker(selection: self.$timeVal, label: Text("000").font(.subheadline)) {
                    Text("1").tag(1).font(.title2)
                    Text("5").tag(5).font(.title2)
                    Text("10").tag(10).font(.title2)
                    Text("30").tag(30).font(.title2)
                    Text("60").tag(60).font(.title2)
                }
            }
            
            NavigationLink{
                TimerView(timerScreenShow: $timerScreenShow, timeVal: timeVal, initialTime: timeVal)
            } label: {
                Label("Timer Start", systemImage: "timer")
                    .font(.headline)
//                    .frame(width: 100, height: 100)
//                    .foregroundColor(.red)
            }
//            .frame(width: 200, height:10)
//            .background(.blue)
        }
    }
}

struct TimerView: View {
    @Binding var timerScreenShow: Bool
    @State var timeVal: Int
    let initialTime: Int
    
    var body: some View {
//        Text("\(self.timeVal)")
        if timeVal > -1 {
            VStack {
                ZStack {
                    Text("\(timeVal)").font(.system(size: 40))
                        .onAppear() {
                            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in 
                                if timeVal > -1 {
                                    timeVal -= 1
                                }
                            }
                    }
                    ProgressBar(progress: timeVal, initial: initialTime)
                        .frame(width: 90.0, height: 90.0)
                }
                
                Button(action: {
                    timerScreenShow = false
                    timeVal = 0//ここを付け足してみた。
//                    ０になるのでタイマーは止まるがDONEが表示されてしまう
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                })
                .padding(.top)
            }
        } else {
            Button(action: {
                timerScreenShow = false
            }, label: {
                Text("Done!")
                    .font(.title)
                    .foregroundColor(.green)
            }).onAppear() {
                WKInterfaceDevice.current().play(.notification)
            }
        }
    }
}
//これを多分別ファイルにしていい
struct ProgressBar: View {
    let progress: Int
    let initial: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.3)
                .foregroundColor(.red)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(Float(progress) / Float(initial), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeIn, value: 1.0)//?????
        }
    }
}

#Preview {
    ContentView()
}

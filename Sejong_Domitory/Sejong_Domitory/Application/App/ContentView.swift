//
//  ContentView.swift
//  Sejong_Domitory
//
//  Created by 박근경 on 2024/07/11.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Image("Image")
        }
        .padding()
        .background(Color.black)
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  ObjectRecognition
//
//  Created by dennis savchenko on 30/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CameraView()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}

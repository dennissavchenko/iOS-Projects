//
//  ContentView.swift
//  AIImageGenerator
//
//  Created by dennis savchenko on 27/08/2024.
//

import OpenAIKit
import SwiftUI

final class ViewModel: ObservableObject {
    
    private var openai: OpenAI?
    
    func setup() {
        openai = OpenAI(Configuration(organizationId: "", apiKey: ""))
    }
    
    func generateImage(prompt: String) async -> UIImage? {
        guard let openai = openai else { return nil }
        do {
            let params = ImageParameters(
                prompt: prompt,
                resolution: .large,
                responseFormat: .base64Json
            )
            let result = try await openai.createImage(parameters: params)
            let data = result.data[0].image
            let image = try openai.decodeBase64Image(data)
            return image
        } catch {
            print(String(describing: error))
            return nil
        }
    }
    
}

struct ContentView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    @State private var image: UIImage?
    @State private var prompt: String = ""
    
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Text("No image!")
            }
            Spacer()
            TextField("Enter...", text: $prompt)
            Button("Generate!") {
                if !prompt.trimmingCharacters(in: .whitespaces).isEmpty {
                    Task {
                        let result = await viewModel.generateImage(prompt: prompt)
                        if result == nil {
                            print("Image was nor found!")
                        }
                        self.image = result
                    }
                }
            }
        }
        .onAppear {
            viewModel.setup()
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}

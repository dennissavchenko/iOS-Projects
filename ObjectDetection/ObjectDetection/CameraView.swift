//
//  CameraView.swift
//  ObjectRecognition
//
//  Created by dennis savchenko on 30/08/2024.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // No updates needed for now.
    }
}

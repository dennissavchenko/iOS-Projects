//
//  FindLyrics.swift
//  Bible
//
//  Created by Денис Савченко on 15/02/2023.
//

import Foundation
func readFileContents(song: String) -> String? {
    guard let filePath = Bundle.main.path(forResource: song, ofType: "txt") else {
        return nil
    }
    do {
        let fileHandle = try FileHandle(forReadingFrom: URL(fileURLWithPath: filePath))
        let fileData = fileHandle.readDataToEndOfFile()
        fileHandle.closeFile()
        let fileContents = String(data: fileData, encoding: .utf8)
        return fileContents
    } catch {
        print("Error reading file: \(error)")
        return nil
    }
}

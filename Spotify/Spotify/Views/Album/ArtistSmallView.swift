//
//  SingerSmallView.swift
//  Spotify
//
//  Created by dennis savchenko on 11/11/2024.
//

import SwiftUI

struct ArtistSmallView: View {
    
    var artist: Artist
    
    var body: some View {
        HStack {
            Image(artist.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
                .clipShape(Circle())
            Text(artist.name)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ArtistSmallView(artist: lana_del_rey)
}

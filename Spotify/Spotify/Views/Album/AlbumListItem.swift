//
//  AlbumListItem.swift
//  Bible
//
//  Created by Денис Савченко on 16/02/2023.
//

import SwiftUI

struct AlbumListItem: View {
    
    var album: Album
    
    var body: some View {
        
        HStack(spacing: 16) {
            Image(album.imageName)
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading, spacing: 4) {
                Text(album.name)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text((String)(album.releaseYear))
                    .foregroundColor(Color(.systemGray2))
                    .font(.footnote)
            }
            Spacer()
            Image(systemName: "ellipsis")
                .foregroundColor(Color("Singer"))
        }
        .frame(height: 80)
        
    }
}

#Preview {
    AlbumListItem(album: Album(name: "Born To Die", imageName: "album_1", releaseYear: 2012, artist: lana_del_rey))
}


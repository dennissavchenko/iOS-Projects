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
        HStack {
            Image(album.picture)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 5)
            VStack(alignment: .leading, spacing: 1.5) {
                Text(album.name)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text((String)(album.releaseYear))
                    .foregroundColor(Color("Singer"))
                    .font(.footnote)
            }
            Spacer()
            Image(systemName: "ellipsis")
                .foregroundColor(Color("Singer"))
        }.frame(height: 100)
            .padding()
            .background(.black.opacity(0.5))
    }
}


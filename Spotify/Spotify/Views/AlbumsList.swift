//
//  AlbumsList.swift
//  Bible
//
//  Created by Денис Савченко on 16/02/2023.
//

import SwiftUI

struct AlbumsList: View {
    @State var show = false
    @State var selectedAlbum: Int!
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    VStack {
                        Spacer()
                        Text("Lana Del Rey")
                            .foregroundColor(.white)
                            .fontWeight(.black)
                            .font(.system(size: 40))
                            .padding(.horizontal)
                            .padding(.bottom, 7)
                        
                    }
                    Spacer()
                }
                .background(Image("singer")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipped())
                .frame(height: 300)
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(0..<4) { i in
                            AlbumListItem(album: albums[i]).onTapGesture {
                                selectedAlbum = i
                                show.toggle()
                            }
                        }
                    }.padding(.top, 10)
                }.background(.black.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }.background(.black)
                .ignoresSafeArea()
            if selectedAlbum != nil && show {
                Player(album_index: $selectedAlbum, show: $show)
            }
        }
    }
}

struct AlbumsList_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsList()
    }
}

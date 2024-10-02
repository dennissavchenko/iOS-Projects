//
//  Player.swift
//  Bible
//
//  Created by Денис Савченко on 16/02/2023.
//

import SwiftUI

struct Player: View {
    
    @Binding var album_index: Int!
    @Binding var show: Bool
    
    @StateObject private var viewModel = ViewModel()
    
    @State var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors:[Color(songs[viewModel.album_index][viewModel.index].album.color_set.topColor), Color(songs[viewModel.album_index][viewModel.index].album.color_set.bottomColor)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Button {
                            show.toggle()
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        Text(songs[viewModel.album_index][viewModel.index].album.name)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.top, 8)
                        Spacer()
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    Image(songs[viewModel.album_index][viewModel.index].album.picture)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .shadow(color: .black, radius: 5)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(songs[viewModel.album_index][viewModel.index].song)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .tracking(-1)
                        Text(viewModel.getSingers(artists: songs[viewModel.album_index][viewModel.index].artists))
                            .font(.callout)
                            .foregroundColor(Color("Singer"))
                            .tracking(-0.5)
                    }.onAppear {
                        viewModel.setAlbumIndex(ind: album_index)
                        viewModel.onAppear()
                    }
                    VStack {
                        Slider(value: $viewModel.timeSec10, in: 0...(Double)(songs[viewModel.album_index][viewModel.index].time), step: 0.01, onEditingChanged: { editing in viewModel.onEditing(editing: editing) })
                            .accentColor(.white)
                            .cornerRadius(4)
                            .onChange(of: viewModel.timeSec10, perform: { _ in viewModel.onChange() })
                        HStack {
                            Text(viewModel.timer(time:viewModel.timeSec))
                                .font(.footnote)
                                .foregroundColor(Color("Singer"))
                                .onReceive(viewModel.countDownTimer) { _ in viewModel.timeOnReceive() }
                                .onReceive(viewModel.countDownTimer10) { _ in viewModel.timeOnReceive10() }
                            Spacer()
                            Text("-\(viewModel.timer(time:viewModel.timeLeftSec))")
                                .font(.footnote)
                                .foregroundColor(Color("Singer"))
                                .onReceive(viewModel.countDownTimer) { _ in viewModel.timeLeftOnReceive() }
                        }
                    }
                    HStack {
                        Button {
                            viewModel.shuffle()
                        } label: {
                            Image(systemName: "shuffle")
                                .font(.system(size: 20))
                                .foregroundColor(Color(viewModel.shuffleColor))
                        }
                        Spacer()
                        Button {
                            viewModel.left()
                        } label: {
                            Image("Left")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        Spacer()
                        Button {
                            viewModel.play()
                        } label: {
                            Image(viewModel.buttonImage)
                                .resizable()
                                .frame(width: 64, height: 64)
                        }
                        Spacer()
                        Button {
                            viewModel.right()
                        } label: {
                            Image("Right")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        Spacer()
                        Button {
                            viewModel.repeatSong()
                        } label: {
                            Image(systemName: "repeat")
                                .font(.system(size: 20))
                                .foregroundColor(Color(viewModel.repeatColor))
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Lyrics")
                            .padding(.all)
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.bottom, -6)
                        ZStack {
                            ScrollView(showsIndicators: false) {
                                Text(viewModel.getLyrics())
                                    .padding(.all)
                                    .padding(.top, -5)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .lineSpacing(10)
                            }
                            VStack(spacing: 0) {
                                LinearGradient(colors:[Color(viewModel.getTextBackground()), Color(red: 0, green: 0, blue: 0, opacity: 0)], startPoint: .top, endPoint: .bottom).frame(height: 22)
                                Spacer()
                                LinearGradient(colors:[Color(red: 0, green: 0, blue: 0, opacity: 0),Color(viewModel.getTextBackground())], startPoint: .top, endPoint: .bottom).frame(height: 22)
                                Rectangle()
                                    .frame(height: 15)
                                    .foregroundColor(Color(viewModel.getTextBackground()))
                            }
                        }
                    }.background(Color(viewModel.getTextBackground()))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .frame(height: 455)
                }.padding(.horizontal, 24)
                    .offset(y: offset)
                        .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
            }
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.height > 0 {
            offset = value.translation.height
        }
        
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
                if value.translation.height > UIScreen.main.bounds.height / 2 {
                    show.toggle()
                } else {
                    offset = 100
                }
        }
    }
    
}

/*struct Player_Previews: PreviewProvider {
    static var previews: some View {
        Player(albumData: $album_5, show: $true)
    }
}*/

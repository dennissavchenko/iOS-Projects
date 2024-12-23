//
//  GenresView.swift
//  Books
//
//  Created by dennis savchenko on 22/08/2024.
//

import SwiftUI

struct GenresView: View {
    
    @EnvironmentObject private var genresViewModel: GenresViewModel
    
    @Binding var genres: [Genre]

    var body: some View {
        AnyLayout(FlowLayout(spacing: 10)) {
            ForEach(genresViewModel.genres) { genre in
                Text(genre.name)
                    .onTapGesture {
                        if genres.contains(genre) {
                            genres.remove(at: genres.firstIndex { $0.id == genre.id }!)
                        } else {
                            genres.append(genre)
                        }
                    }
                    .padding(10)
                    .padding(.horizontal, 4)
                    .foregroundStyle(.black)
                    .fontDesign(genres.contains(genre) ? .serif : nil)
                    .fontWeight(genres.contains(genre) ? .semibold : nil)
                    .background {
                        if !genres.contains(genre) {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray2), lineWidth: 1)
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.black, lineWidth: 2)
                        }
                    }
            }
        }
    }
}

struct FlowLayout: Layout {
    
    var spacing: CGFloat = 8
    
    func layout(sizes: [CGSize], spacing: CGFloat = 8, containerWidth: CGFloat) -> (offsets: [CGPoint], size: CGSize) {
        
        var result: [CGPoint] = []

        var currentPosition: CGPoint = .zero

        var lineHeight: CGFloat = 0

        var maxX: CGFloat = 0
        
        for size in sizes {
            if currentPosition.x + size.width > containerWidth {
                 currentPosition.x = 0
                 currentPosition.y += lineHeight + spacing
                 lineHeight = 0
             }
             
             result.append(currentPosition)
             currentPosition.x += size.width

             maxX = max(maxX, currentPosition.x)
             currentPosition.x += spacing
             lineHeight = max(lineHeight, size.height)
        }
        
        return (result, .init(width: maxX, height: currentPosition.y + lineHeight))
        
     }
 
     func sizeThatFits(proposal: ProposedViewSize,
                       subviews: Subviews,
                       cache: inout ()) -> CGSize {

        let containerWidth = proposal.width ?? .infinity
         let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
         return layout(sizes: sizes,
                       spacing: spacing,
                       containerWidth: containerWidth).size
     }
     
     func placeSubviews(in bounds: CGRect,
                        proposal: ProposedViewSize,
                        subviews: Subviews,
                        cache: inout ()) {
         let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
         let offsets =
             layout(sizes: sizes,
                    spacing: spacing,
                    containerWidth: bounds.width).offsets
         for (offset, subview) in zip(offsets, subviews) {
             subview.place(at: .init(x: offset.x + bounds.minX,
                                     y: offset.y + bounds.minY),
                           proposal: .unspecified)
         }
     }
 }

#Preview {
    GenresView(genres: .constant([]))
        .environmentObject(GenresViewModel())
}

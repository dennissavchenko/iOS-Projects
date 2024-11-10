//
//  DayRangeIndicatorView.swift
//  Airbnb
//
//  Created by dennis savchenko on 12/08/2024.
//

import UIKit
import SwiftUI

final class DayRangeIndicatorView: UIView {

  private let indicatorColor: UIColor

  init(indicatorColor: UIColor) {
    self.indicatorColor = indicatorColor
    super.init(frame: .zero)
    backgroundColor = .clear
  }

  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

  var framesOfDaysToHighlight = [CGRect]() {
    didSet {
      guard framesOfDaysToHighlight != oldValue else { return }
      setNeedsDisplay()
    }
  }

  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(indicatorColor.cgColor)

    // Get frames of day rows in the range
    var dayRowFrames = [CGRect]()
    var currentDayRowMinY: CGFloat?
    for dayFrame in framesOfDaysToHighlight {
      if dayFrame.minY != currentDayRowMinY {
        currentDayRowMinY = dayFrame.minY
        dayRowFrames.append(dayFrame)
      } else {
        let lastIndex = dayRowFrames.count - 1
        dayRowFrames[lastIndex] = dayRowFrames[lastIndex].union(dayFrame)
      }
    }

    // Draw rounded rectangles for each day row
    for dayRowFrame in dayRowFrames {
      let roundedRectanglePath = UIBezierPath(roundedRect: dayRowFrame, cornerRadius: 20)
      context?.addPath(roundedRectanglePath.cgPath)
      context?.fillPath()
    }
  }

}

struct DayRangeIndicatorViewRepresentable: UIViewRepresentable {

  let framesOfDaysToHighlight: [CGRect]

  func makeUIView(context: Context) -> DayRangeIndicatorView {
      DayRangeIndicatorView(indicatorColor: UIColor.pale.withAlphaComponent(0.2))
  }

  func updateUIView(_ uiView: DayRangeIndicatorView, context: Context) {
      if framesOfDaysToHighlight.count > 1 {
              uiView.framesOfDaysToHighlight = framesOfDaysToHighlight
          } else {
              uiView.framesOfDaysToHighlight = [] // Clear the highlight if only one day is selected
    }
  }

}


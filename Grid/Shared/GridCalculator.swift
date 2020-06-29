//
//  GridCalculator.swift
//
//  Created by Mauricio Meirelles on 29/06/2020.
//

import SwiftUI

struct GridCalculator {
    func calculate(
        availableWidth: CGFloat,
        items: [Int],
        sizeItems: [CGSize],
        cellSpacing: CGFloat
    ) -> [[Int]] {
        if sizeItems.count >= items.count {
            var rows:[[Int]] = [[]]
            var currentIndex = 0
            var remainingWidth = availableWidth
            
            for (idx, itemSize) in sizeItems[0..<items.count].enumerated() {
                if remainingWidth - (itemSize.width + cellSpacing) >= 0 {
                    rows[currentIndex].append(idx)
                } else {
                    currentIndex = currentIndex + 1
                    rows.append([idx])
                    remainingWidth = availableWidth
                }
                remainingWidth = remainingWidth - (itemSize.width + cellSpacing)
            }
            
            return rows
        } else {
            return items.map { [$0] }
        }
    }
}

//
//  GridView.swift
//
//  Created by Mauricio Meirelles on 29/06/2020.
//

import SwiftUI

public struct GridView<Content>: View where Content: View {
    private let gridWidth: CGFloat
    private let spacing: CGFloat
    private let numItems: Int
    private let alignment: HorizontalAlignment
    private let content: (Int) -> Content
    
    public init(
        gridWidth: CGFloat,
        spacing: CGFloat,
        numItems: Int,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder content: @escaping (Int) -> Content
    ) {
        self.gridWidth = gridWidth
        self.spacing = spacing
        self.numItems = numItems
        self.alignment = alignment
        self.content = content
    }
    
    var items: [Int] {
        Array(0..<numItems).map { $0 }
    }
    
    public var body: some View {
        InnerGrid(
            width: gridWidth,
            spacing: self.spacing,
            items: self.items,
            alignment: self.alignment,
            content: self.content
        )
    }
}

private struct InnerGrid<Content>: View where Content: View {
    
    private let width: CGFloat
    private let spacing: CGFloat
    private let items: [Int]
    private let alignment: HorizontalAlignment
    private let content: (Int) -> Content
    private let gridCalculator = GridCalculator()
    @State var itemSizes: [CGSize] = []
    
    init(
        width: CGFloat,
        spacing: CGFloat,
        items: [Int],
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder content: @escaping (Int) -> Content
    ) {
        self.width = width
        self.items = items
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
    }
    
    var body : some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(gridCalculator.calculate(availableWidth: width, items: items, sizeItems: itemSizes, cellSpacing: spacing), id: \.self) { row in
                HStack(spacing: self.spacing) {
                    ForEach(row, id: \.self) { item in
                        ChildSizeReader(size: self.$itemSizes) {
                            self.content(item)
                        }
                    }
                }.padding(.horizontal, self.spacing)
            }
        }
        .padding(.top, spacing)
        .frame(width: width)
    }
}

struct ChildSizeReader<Content: View>: View {
    @Binding var size: [CGSize]
    let content: () -> Content
    var body: some View {
        ZStack {
            content()
            .fixedSize()
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            )
        }
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            self.size.append(preferences)
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        _ = nextValue()
    }
}

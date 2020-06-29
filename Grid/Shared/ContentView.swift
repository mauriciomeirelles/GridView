//
//  ContentView.swift
//  Shared
//
//  Created by Mauricio Meirelles on 29/06/2020.
//

import SwiftUI

struct ContentView: View {
    
    let spacing: CGFloat = 8
    let items = ["This", "is", "the", "grid", "autoresizing", "to", "fit", "the", "views"]
    
    var body: some View {
        VStack(spacing: spacing*4) {
            gridView(title: "Leading", alignment: .leading, color: .blue)
            gridView(title: "Center", alignment: .center, color: .red)
        }
    }
    
    func gridView(title: String, alignment: HorizontalAlignment, color: Color) -> some View {
        VStack(spacing: spacing*2) {
            Text(title)
            GridView(gridWidth: UIScreen.main.bounds.size.width - spacing*4,
                      spacing: spacing,
                      numItems: items.count,
                      alignment: alignment) { index in
                    Text(items[index])
                    .padding()
                    .background(color.opacity(0.3))
            }
            .padding(.horizontal, spacing*4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

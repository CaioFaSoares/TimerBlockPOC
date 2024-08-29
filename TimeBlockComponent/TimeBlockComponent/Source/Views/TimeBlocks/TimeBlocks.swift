//
//  TimeBlocks.swift
//  TimeBlockComponent
//
//  Created by Caio Soares on 29/08/24.
//

import SwiftUI

struct TimeBlocks: View {
    var body: some View {
        TimeBlockComponentView (
            numberOfColumns: 7,
            numberOsRows: 24,
            header: { day in
                HeaderComponent(day: day as! Day)
        }, emptyCard: {
            EmptyComponent()
        }, card: {
            Text("AAAA")
        })
    }
}

#Preview {
    TimeBlocks()
}

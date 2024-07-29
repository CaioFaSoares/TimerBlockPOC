//
//  TimeBlockComponentApp.swift
//  TimeBlockComponent
//
//  Created by Gilberto Magno on 24/07/24.
//

import SwiftUI

@main
struct TimeBlockComponentApp: App {
    var body: some Scene {
        WindowGroup {
            TimeBlockComponentView(numberOfColumns: 7, numberOsRows: 24, header: { day in
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .frame(width: 100, height: 60)
                    .overlay {
                        VStack {
                            Text("\(day.name.small)")
                            Text("Dia \(day.monthDay)")
                        }
                    }
            }, emptyCard: {
                EmptyComponent()
            }, card: {
                Text("AAAA")
            })
        }
    }
}

//
//  HeaderComponent.swift
//  TimeBlockComponent
//
//  Created by Caio Soares on 29/08/24.
//

import SwiftUI

struct HeaderComponent: View {
    
    var day: Day
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .frame(width: 100, height: 60)
            .overlay {
                VStack {
                    Text("\(day.name.small)")
                    Text("Dia \(day.monthDay)")
                }
            }
    }
}

//
//  TimerBlockCard.swift
//  TimeBlockComponent
//
//  Created by Gilberto Magno on 29/07/24.
//

import Foundation
import SwiftUI

// Card com propriedades de drag e colisoes temporais simples, basta utiliza-lo e definir o conteudo você mesmo
struct TimerBlockCard<Content: View>: View {
    
    var viewmodel: TimerBlockCardViewModel
    var card: () -> Content
    
    var body: some View {
        card()
            .opacity(viewmodel.allowMerge ? 0.72 : 0.95)
            .frame(width: viewmodel.dragHelper.cardWidth,
                   height: viewmodel.event.dateInterval.getHeight(hourHeight: viewmodel.dragHelper.cardHeight))
            .offset(x: viewmodel.xOffset,
                    y: viewmodel.yOffset)
            .gesture(
                DragGesture()
                    .onChanged(viewmodel.dragDidChange)
                    .onEnded(viewmodel.dragDidEnd)
            )
            .onTapGesture(count: 2, perform: {
                withAnimation {
                    self.viewmodel.allowMerge.toggle()
                    if !self.viewmodel.allowMerge {
                        viewmodel.correctUnallowMerge()
                    }
                }
            })
    }
}

#Preview {
    
    TimeBlockComponentView(numberOfColumns: 7, numberOsRows: 24, header: { day in
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .overlay {
                VStack {
                    Text("\(day.name.small)")
                    Text("Dia \(day.monthDay)")
                }
            }
    }, emptyCard: {
        EmptyComponent()
    }, card: {
        Text("OIE")
    })
    
}

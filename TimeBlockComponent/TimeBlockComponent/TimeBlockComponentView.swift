//
//  TimeBlockComponentView.swift
//  TimeBlockComponent
//
//  Created by Gilberto Magno on 28/07/24.
//

import Foundation
import SwiftUI

struct TimeBlockComponentView<Header: View,
                              EmptyCard: View,
                              Card: View>: View {
    
    @State var viewmodel: TimeBlockComponentViewModel
    var header: ((DayInterface) -> Header)?
    var emptyCard: () -> EmptyCard
    var card: () -> Card

    var body: some View {
        ScrollView([.horizontal,.vertical]) {
            HStack(spacing: 0) {
                ForEach(viewmodel.days, id: \.id) { day in
                    VStack(spacing: 0) {
                        header?(day)
                            .frame(width: viewmodel.width, height: viewmodel.height)
                        hourBody
                    }
                }
            }
            .overlay {
                    GeometryReader { reader in
                        ForEach(viewmodel.events, id: \.day) { event in
                            var event = event
                            event.delegate = self.viewmodel
                            return TimerBlockCard(viewmodel: .init(event: event)) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.black.opacity(0.25))
                                    .overlay {
                                        card()
                                    }
                                    .frame(width: viewmodel.width, height: event.dateInterval.getHeight(hourHeight: viewmodel.height))
                            }
                        }
                    }
                }
        }
    }
    
    var hourBody: some View {
        VStack(spacing: 0) {
            ForEach((0..<viewmodel.numberOfHours).map { $0 }, id: \.self) { hour in
                emptyCard()
                    .frame(width: viewmodel.width, height: viewmodel.height)
                }
            }
    }
}

extension TimeBlockComponentView {
    init(numberOfColumns: Int,
         numberOsRows: Int,
         header: ((DayInterface) -> Header)? = nil,
         emptyCard: @escaping () -> EmptyCard,
         card: @escaping () -> Card) {
        self.header = header
        self.emptyCard = emptyCard
        self.card = card
        self.viewmodel = .init(numberOfDays: numberOfColumns,
                               numberOfHours: numberOsRows,
                               height: 60,
                               width: 100)
    }
}


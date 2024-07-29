//
//  TimerBlockCardViewModel.swift
//  TimeBlockComponent
//
//  Created by Gilberto Magno on 29/07/24.
//

import Foundation
import SwiftUI

@Observable
class TimerBlockCardViewModel {
    var event: EventInterface
    var allowMerge: Bool = false
    
    var dragHelper: DragHelper = .init()
    
    init(event: EventInterface) {
        self.event = event
    }
    
    // AQUI É RESPONSAVEL POR JOGAR O CARD PARA OUTRA POSICAO SE TIVER EM CIMA NA HORA QUE DESABILITAR TRANSPARENCIA
    func setNextDateInterval(_ dateInterval: inout DateInterval, otherInterval: DateInterval) {
        if !(abs(dateInterval.start.timeIntervalSince(otherInterval.end)) >
            abs(dateInterval.end.timeIntervalSince(otherInterval.start))) {
            dateInterval.start = otherInterval.end
        } else {
            dateInterval.start = otherInterval.start
            dateInterval.start.addTimeInterval(-dateInterval.duration)
        }
    }
    
    // CHECAGEM APOS DESABILITACAO DA TRANSPARENCIA MAIS COMPLEXA PARA EVITAR ULTRAPASSAR DIAS
    func correctUnallowMerge() {
        guard let delegate = event.delegate else { return }
        let eventsNoRepeat = delegate.filteredEvents(event: self.event)
        var newDateInterval = self.event.dateInterval
        eventsNoRepeat.forEach {
            if $0.dateInterval.contains(newDateInterval.start)
            ||
                $0.dateInterval.contains(newDateInterval.end) {
                
                setNextDateInterval(&newDateInterval, otherInterval: $0.dateInterval)
                if isNotPassingTheDay(newDateInterval) {
                    self.event.dateInterval = newDateInterval
                } else {
                    newDateInterval.start.addTimeInterval(2*newDateInterval.duration)
                    if Calendar.current.startOfDay(for: newDateInterval.start) == event.day.date && Calendar.current.startOfDay(for: newDateInterval.end) == event.day.date {
                        self.event.dateInterval = newDateInterval
                    }
                }
            }
        }
    }
    
    // TODO: Transformar variaveis de Offset fora de variaveis computadas para evitar comportamentos inesperadas e bugs de acoes complexas do usuarios, TALVEZ COLOCAR NO DRAG HELPER E DESSA MANEIRA TER MELHOR CONTROLE POR LA SEM O OBSERVABLE DIRETO
    var xOffset: CGFloat {
        CGFloat(event.day.name.n - 1)*dragHelper.cardWidth
    }
    
    var yOffset: CGFloat {
        dragHelper.offSetToBeginLeftTop - event.dateInterval.getOffSetHeight(hourHeight: dragHelper.cardHeight)
    }
    
    // FUNÇÃO RESPONSAVEL PELO DRAG
    func dragDidChange(_ gesture: DragGesture.Value) {
        if dragHelper.dragInitialState == .zero {
            dragHelper.dragInitialState = gesture.location
            dragHelper.initialDateInterval = event.dateInterval
        }
        dragHelper.dragActualState = gesture.location
        dragHelper.cardAngle = Angle(degrees: gesture.translation.width * 0.05)
        changeTimeInterval()
    }
    
    // Fim do drag, reseta e atualiza o necessario
    func dragDidEnd(_ gesture: DragGesture.Value) {
        withAnimation(.linear(duration: dragHelper.duration)) {
            dragHelper.dragInitialState = .zero
            dragHelper.dragActualState = .zero
            dragHelper.initialDateInterval = event.dateInterval
            dragHelper.cardAngle = .zero
        }
    }
    
    // Cria um novo intervalo de tempo para cada diferença de  drag vertical , TODO: Receber como parametro o valor do drag para evitar comportamentos inesperados e ajudar em testes
    func getNewDateInterval() -> DateInterval {
        .init(
            start: dragHelper.initialDateInterval
                .start
                .addingTimeInterval(
                    dragHelper.heightDragDifference()
                ),
            duration: dragHelper.initialDateInterval.duration
        )
    }
    
    // Checa se ainda está no mesmo dia do intervalo para evitar de passar das 24 horas
    func isNotPassingTheDay(_ newDateInterval: DateInterval) -> Bool {
        Calendar.current.startOfDay(for: newDateInterval.start) == event.day.date && Calendar.current.startOfDay(for: newDateInterval.end) == event.day.date
    }
    
    
    // logica de colisão temporal basica, é possivel tornar muito melhor com variaveis de controles como uma isColliding e alguma variavel que identifique direção da colisao, para evitar bugs como o usuário continuar draggeando até pular o card.
    // TODO: Refatorar para lidar com lógicas mais complexas
    func isCollinding(date: DateInterval) -> Bool {
        guard let delegate = event.delegate else { return false }
        let eventsNoRepeat = delegate.filteredEvents(event: self.event)
        let result = !eventsNoRepeat.contains {
            $0.dateInterval.contains(date.start)
            ||
             $0.dateInterval.contains(date.end)
        }
        if result {
            if let newDate = eventsNoRepeat.first(where: {
                $0.dateInterval.contains(date.start)
            }) {
                self.event.dateInterval = newDate.dateInterval
            }
            if let date = eventsNoRepeat.first(where: {
                $0.dateInterval.contains(date.end)
            }) {
                self.event.dateInterval = date.dateInterval
            }
        }
        return !result
    }
    
    func changeTimeInterval() {
        let newDateInterval: DateInterval = getNewDateInterval()
        if isNotPassingTheDay(newDateInterval) {
            if allowMerge {
                self.event.dateInterval = newDateInterval
            } else {
                if !isCollinding(date: newDateInterval) {
                    self.event.dateInterval
                    = newDateInterval
                }
            }
        }
    }
}


// TODO: ARRUMAR ESSAS DESGRAMAS DE NUMEROS MAGICOS Q EU ME ENROLEI MT E DEU PREGUICA CONSERTAR
struct DragHelper {
    var cardWidth: CGFloat = 100
    var cardHeight: CGFloat = 60
    var offSetToBeginLeftTop: CGFloat = 60
    
    // Drag States
    var dragInitialState: CGPoint = .zero
    var dragActualState: CGPoint = .zero
    var initialDateInterval: DateInterval = .init()
    var cardAngle: Angle = .zero
    
    let duration: CGFloat = 0.18
    
    // TODO: Trocar numero magico pelo valor do tamanho que uma hora equivale em pontos/pixeis no card ( Numero de Rows * Card Height / 24 )
    func heightDragDifference() -> CGFloat {
         (dragActualState.y - dragInitialState.y)*60
    }
    
    
}

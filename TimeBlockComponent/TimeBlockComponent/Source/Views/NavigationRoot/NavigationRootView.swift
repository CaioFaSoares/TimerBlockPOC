//
//  NavigationRoot.swift
//  TimeBlockComponent
//
//  Created by Caio Soares on 29/08/24.
//

import SwiftUI

struct NavigationRootView: View {
    var body: some View {
        NavigationStack {
            TabView {
                TimeBlocks()
                .tabItem {
                    Label("Blocks", systemImage: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationRootView()
}

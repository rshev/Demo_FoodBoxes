//
//  ContentView.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ProductsViewModel

    var body: some View {
        NavigationView {
            ProductListView()
        }
        .onAppear {
            self.viewModel.attach()
        }
    }
}

//
//  ProductListView.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var viewModel: ProductListViewModel

    var body: some View {
        List {
            ForEach(viewModel.products, id: \.self) { product in
                ProductRowView(product: product)
            }
        }
        .navigationBarTitle("Product List")
    }
}

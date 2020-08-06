//
//  ProductListView.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var viewModel: ProductsViewModel
    @State var searchText: String = ""

    var body: some View {
        List {
            SearchBarView(text: $searchText)
            ForEach(
                viewModel.products
                    .filter {
                        if searchText == "" { return true }
                        return $0.title.localizedLowercase.contains(searchText.localizedLowercase)
                    },
                id: \.self
            ) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    ProductRowView(product: product)
                }
            }
        }
        .navigationBarTitle("Product List")
    }
}

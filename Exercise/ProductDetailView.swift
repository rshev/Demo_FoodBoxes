//
//  ProductDetailView.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack {
                if product.imageURL != nil {
                    AsyncImage(url: product.imageURL!, placeholder: Color.gray)
                        .aspectRatio(contentMode: .fit)
                        .accessibility(identifier: "image")
                }
                VStack(spacing: 16) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(product.title)
                            .font(.title)
                            .accessibility(identifier: "title")
                        Spacer()
                        Text("£\(product.price)")
                            .accessibility(identifier: "price")
                    }
                    Text(product.description)
                        .accessibility(identifier: "description")
                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarTitle(Text(product.title), displayMode: .inline)
        .accessibility(identifier: "product detail")
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: .dummy)
    }
}

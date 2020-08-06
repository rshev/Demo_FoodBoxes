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
                }
                VStack(spacing: 16) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(product.title)
                            .font(.title)
                        Spacer()
                        Text("£\(product.price)")
                    }
                    Text(product.description)
                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarTitle(Text(product.title), displayMode: .inline)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: .dummy)
    }
}

//
//  ProductRowView.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import SwiftUI

struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack {
            if product.imageURL != nil {
                AsyncImage(url: product.imageURL!, placeholder: Color.gray)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75, alignment: .center)
                    .accessibility(identifier: "image")
            }
            Text(product.title)
                .accessibility(identifier: "title")
            Spacer()
            Text("£\(product.price)")
                .accessibility(identifier: "price")
        }
    }
}

struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product: .dummy)
    }
}

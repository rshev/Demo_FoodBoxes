//
//  AsyncImage.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import SwiftUI
import Combine

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder

    init(
        url: URL,
        placeholder: Placeholder
    ) {
        loader = ImageLoader(url: url)
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
        .onAppear(perform: {
            loader.load()
        })
        .onDisappear(perform: {
            loader.cancel()
        })
    }
}

final class ImageLoader: ObservableObject {
    private let url: URL

    init(url: URL) {
        self.url = url
    }

    @Published private(set) var image: UIImage?

    private var cancellable: AnyCancellable?

    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .utility))
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func cancel() {
        cancellable?.cancel()
    }
}

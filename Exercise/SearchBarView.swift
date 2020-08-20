//
//  SearchBarView.swift
//  Exercise
//
//  Created by Roman Shevtsov on 05/08/2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import SwiftUI
import Combine

struct SearchBarView: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        var cancellables = Set<AnyCancellable>()

        @Binding var text: String
        let textSubject = CurrentValueSubject<String, Never>("")

        init(text: Binding<String>) {
            _text = text
        }

        lazy var _setup: Void = {
            textSubject
                .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
                .sink { [weak self] in
                    self?.text = $0
                }
                .store(in: &cancellables)
        }()

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            _ = _setup
            textSubject.send(searchText)
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            textSubject.send("")
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.resignFirstResponder()
        }

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBarView>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBarView>) {
        uiView.text = text
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}

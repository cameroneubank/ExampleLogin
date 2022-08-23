//
//  SearchViewController.swift
//  Navigation
//
//  Created by Cameron Eubank on 8/23/22.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        [label].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            label.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            label.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor)
        ])
    }
}

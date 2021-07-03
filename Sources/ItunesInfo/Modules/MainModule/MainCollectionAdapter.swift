//
//  MainTableAdapter.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 30.05.2021.
//

import UIKit

protocol MainCollectionAdapterProtocol: class {
    func didSelect(_ result: SearchResults.Result)
}

final class MainCollectionAdapter: NSObject {

    var collectionView: UICollectionView
    weak var delegate: MainCollectionAdapterProtocol?

    private var viewModel: SearchResults?
    private let reuseIdentifier: String

    override init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 25
        layout.scrollDirection = .vertical
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.reuseIdentifier = "mainCell"
        super.init()
        configure()
    }

    func update(viewModel: SearchResults) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }

    private func configure() {
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension MainCollectionAdapter: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ResultCell {
            guard let model = viewModel?.results[indexPath.item] else { return UICollectionViewCell() }
            cell.update(model: model.trackName, imagePreview: model.artwork, previewURL: model.previewUrl)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let result = viewModel?.results[indexPath.item] else { return }
        delegate?.didSelect(result)
    }
}

extension MainCollectionAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2.5, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
    }

}

//
//  ResultCell.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 30.05.2021.
//

import UIKit
import Kingfisher
import SnapKit
import AVFoundation

extension ResultCell {
    fileprivate struct Appearance {
        let artworkImageOffet: CGFloat = 16
        let artworkImageHeight: CGFloat = 100
        let titleOffset: CGFloat = 16
        let cornerRadius: CGFloat = 10
        let font: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}

class ResultCell: UICollectionViewCell {
    private let artworkImage = UIImageView()
    private let title = UILabel()
    private let appearance: Appearance
    private var previewURL: String?
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    private var played: Bool

    override init(frame: CGRect) {
        self.appearance = Appearance()
        self.played = false
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        addSubview(title)
        addSubview(artworkImage)
    }

    func makeConstraints() {
        artworkImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(appearance.artworkImageOffet)
            make.height.equalTo(appearance.artworkImageHeight)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(artworkImage.snp.bottom).offset(appearance.titleOffset)
            make.left.right.equalToSuperview().inset(appearance.titleOffset)
            make.bottom.equalToSuperview()
        }
    }

    func configure() {
        self.backgroundColor = .white
        self.layer.cornerRadius = appearance.cornerRadius
        self.layer.borderWidth = 0.5

        artworkImage.translatesAutoresizingMaskIntoConstraints = false
        artworkImage.contentMode = .scaleAspectFit

        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = appearance.font
        title.numberOfLines = 0
        title.textAlignment = .left
        title.adjustsFontSizeToFitWidth = true
    }

    func update(model: String, imagePreview: String? = nil, previewURL: String?) {
        self.title.text = model
        self.previewURL = previewURL
        guard let urlString = imagePreview,
              let url = URL(string: urlString) else { return }
        self.artworkImage.kf.setImage(with: url)
    }}

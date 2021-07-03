//
//  Created by Aleksey Ermolaev on 03/06/2021.
//

import UIKit
import Kingfisher
import SnapKit
import AVFoundation

extension DetailResultView {
    struct Appearance {
        let imageTopOffset: CGFloat = 20
        let imageHeight: CGFloat = 120

        let cornerRadius: CGFloat = 15

        let stackViewTopOffset = 30
        let stackViewHorizontalOffset = 16
        let stackViewSpacing: CGFloat = 10

        let artistLabelFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let artistLabelColor = UIColor.black

        let trackLabelFont = UIFont.systemFont(ofSize: 18, weight: .regular)
        let trackLabelColor = UIColor.black

        let buttonTopOffset = 20
        let buttonHorizontalOffset = 16
        let buttonHeight = 50
        let buttonCornerRadius: CGFloat = 10

        let indicatorTopOffset = 20
    }
}

protocol DetailResultViewDelegate: AnyObject {
    func didPlayPreview()
}

class DetailResultView: UIView {

    private enum PlayerState {
        case prepareToDownload
        case play
        case pause
    }

    weak var delegate: DetailResultViewDelegate?

    private let appearance = Appearance()
    private let imageView = UIImageView()
    private let stackView = UIStackView()
    private let artistLabel = UILabel()
    private let trackLabel = UILabel()
    private let button = UIButton()
    private let indicator = UIActivityIndicatorView(style: .large)
    private var player: AVAudioPlayer?
    private var state: PlayerState = .prepareToDownload

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        addSubview(imageView)
        addSubview(stackView)
        addSubview(button)
        addSubview(indicator)
    }

    func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(appearance.imageTopOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(appearance.imageHeight)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(appearance.stackViewTopOffset)
            make.left.right.equalToSuperview().inset(appearance.stackViewHorizontalOffset)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(appearance.buttonTopOffset)
            make.left.right.equalToSuperview().inset(appearance.buttonHorizontalOffset)
            make.height.equalTo(appearance.buttonHeight)
        }
        indicator.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(appearance.indicatorTopOffset)
            make.centerX.equalToSuperview()
        }
    }

    func configure() {
        backgroundColor = .white
        imageView.layer.cornerRadius = appearance.cornerRadius
        imageView.contentMode = .scaleAspectFit

        artistLabel.font = appearance.artistLabelFont
        artistLabel.textAlignment = .left
        artistLabel.numberOfLines = 0
        artistLabel.textColor = appearance.artistLabelColor

        trackLabel.font = appearance.trackLabelFont
        trackLabel.textAlignment = .left
        trackLabel.numberOfLines = 0
        trackLabel.textColor = appearance.trackLabelColor

        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = appearance.stackViewSpacing
        stackView.addArrangedSubview(artistLabel)
        stackView.addArrangedSubview(trackLabel)

        button.addTarget(self, action: #selector(didPlayPreview), for: .touchUpInside)
        button.backgroundColor = .link
        button.layer.cornerRadius = appearance.buttonCornerRadius
        button.setTitleColor(.white, for: .normal)

        indicator.color = .link
    }

    func update(_ result: SearchResults.Result) {
        artistLabel.text = result.artistName
        trackLabel.text = result.trackName
        button.setTitle("Play 30 seconds", for: .normal)
        guard let urlString = result.artwork,
              let imageURL = URL(string: urlString) else { return }
        imageView.kf.setImage(with: imageURL)
    }

    @objc private func didPlayPreview() {
        switch state {
        case .prepareToDownload:
            delegate?.didPlayPreview()
        case .play:
            player?.pause()
            state = .pause
        case .pause:
            player?.play()
            state = .play
        }
    }

    func loading(isStart: Bool) {
        if isStart {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }

    func startPlay(data: Data) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            player = try AVAudioPlayer(data: data)
            player?.prepareToPlay()
            player?.volume = 1.0
            player?.play()
            state = .play
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
}

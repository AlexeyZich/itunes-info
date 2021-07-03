//
//  Created by Aleksey Ermolaev on 20/05/2021.
//

import UIKit
import SnapKit

extension MainModuleView {
    struct Appearance {
        let horizontalOffset: CGFloat = 20
        let heightButton: CGFloat = 50
        let cornerRadius: CGFloat = 10
    }
}

class MainModuleView: UIView {
    enum State {
        case loading
        case stopLoading
    }

    private var collectionView: UICollectionView
    private let appearance = Appearance()
    private let button = UIButton()
    private let indicator = UIActivityIndicatorView(style: .large)

    init(frame: CGRect = CGRect.zero, collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        addSubview(collectionView)
        addSubview(indicator)
    }

    func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.centerX.width.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
        }
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    func loading(state: State) {
        switch state {
        case .loading:
            indicator.startAnimating()
        case .stopLoading:
            indicator.stopAnimating()
        }
    }

    func configure() {
        self.backgroundColor = .white

        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .red
    }
}

//
//  ErrorConnectionView.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 04.07.2021.
//

import UIKit
import SnapKit

private extension ErrorConnectionView {
    private struct Appearance {
        let titleOffset = 20
        let titleFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        let titleColor = UIColor.black

        let buttonOffset = 20
        let buttonHeight = 60
        let buttonTitleFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
        let buttonColor = UIColor.white
    }
}

protocol ErrorConnectionViewDelegate: AnyObject {
    func didTryAgain()
}

final class ErrorConnectionView: UIView {
    
    weak var delegate: ErrorConnectionViewDelegate?
    
    private let appearance = Appearance()
    private let title = UILabel()
    private let button = UIButton()

    override init(frame: CGRect) {
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
        addSubview(button)
    }

    func makeConstraints() {
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalTo(appearance.titleOffset)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(appearance.buttonOffset)
            make.left.right.equalToSuperview().inset(appearance.buttonOffset)
            make.height.equalTo(appearance.buttonHeight)
        }
    }

    func configure() {
        backgroundColor = .white

        title.text = "Нет подключения к сети"
        title.font = appearance.titleFont
        title.numberOfLines = 0
        title.textColor = .black
        title.textAlignment = .center

        button.setTitle("Повторить", for: .normal)
        button.setTitleColor(appearance.buttonColor, for: .normal)
        button.backgroundColor = .link
        button.addTarget(self, action: #selector(didTryAgain), for: .touchUpInside)
    }

    @objc func didTryAgain() {
        delegate?.didTryAgain()
    }
}

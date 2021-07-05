//
//  BaseErrorView.swift
//  ItunesInfo
//
//  Created by aleksejermolaev on 05.07.2021.
//

import UIKit
import SnapKit

private extension BaseErrorView {
    private struct Appearance {
        let titleOffset = 20
        let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let titleColor = UIColor.black

        let messageOffset = 20
        let messageFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        let messageColor = UIColor.black

        let buttonTopOffset = 40
        let buttonOffset = 20
        let buttonHeight = 60
        let buttonTitleColor = UIColor.white
        let buttonColor = UIColor.link
        let buttonCornerRadius: CGFloat = 10
    }
}

final class BaseErrorView: UIView {

    private let appearance = Appearance()
    /// Добавить изображение для красоты
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
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
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(button)
    }

    func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(appearance.titleOffset)
        }
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(appearance.messageOffset)
            make.left.right.equalToSuperview().inset(appearance.messageOffset)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(appearance.buttonTopOffset)
            make.left.right.equalToSuperview().inset(appearance.buttonOffset)
            make.height.equalTo(appearance.buttonHeight)
        }
    }

    func configure() {
        backgroundColor = .white

        titleLabel.font = appearance.titleFont
        titleLabel.numberOfLines = 0
        titleLabel.textColor = appearance.titleColor
        titleLabel.textAlignment = .center

        messageLabel.font = appearance.messageFont
        messageLabel.numberOfLines = 0
        messageLabel.textColor = appearance.messageColor
        messageLabel.textAlignment = .center

        button.setTitleColor(appearance.buttonTitleColor, for: .normal)
        button.backgroundColor = appearance.buttonColor
        button.layer.cornerRadius = appearance.buttonCornerRadius
    }

    func set(model: BaseErrorProtocol) {
        titleLabel.text = model.title
        messageLabel.text = model.message
        button.setTitle("Повторить", for: .normal)
    }
}

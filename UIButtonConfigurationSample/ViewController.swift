//
//  ViewController.swift
//  UIButtonConfigurationSample
//
//  Created by kyulee on 2024/12/08.
//

import UIKit

private enum Const {
    static let normalCheckImage = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemGray3)
    static let selectedCheckImage = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemGreen.withAlphaComponent(0.7))
    static let playButtonImage = UIImage(systemName: "play.circle")?.withTintColor(.systemBlue.withAlphaComponent(0.7))
    static let normalCheckButtonTitle = "チェックボタン"
    static let selectedCheckButtonTitle = "選択済み"
    static let normalPlayButtonTitle = "再生する"
    static let imageSize = CGSize(width: 20, height: 20)
}

class ViewController: UIViewController {

    private lazy var firstCheckButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Const.normalCheckButtonTitle, for: .normal)
        button.setTitle(Const.selectedCheckButtonTitle, for: .selected)
        button.setTitleColor(UIColor.systemGray2, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.setImage(Const.normalCheckImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setImage(Const.selectedCheckImage?.withRenderingMode(.alwaysOriginal), for: .selected)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets.left = 10
        button.imageEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 0)
        button.imageView?.contentMode = .scaleAspectFit

        button.addAction(.init { _ in
            self.firstCheckButton.isSelected.toggle()
        }, for: .touchUpInside)

        return button
    }()

    /// firstCheckButtonで設定したedgeInsets系の数値をそのまま利用してConfigurationに適用したボタン
    private lazy var secondCheckButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.plain()
        config.title = Const.normalCheckButtonTitle
        config.image = Const.normalCheckImage?.withRenderingMode(.alwaysOriginal)
        config.imagePlacement = .leading
        config.imagePadding = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 0)
        config.baseBackgroundColor = .clear
        // ButtonのStateが変わってもfont と titleColorを設定の通りにする
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.systemGray2
            outgoing.font = .systemFont(ofSize: 12, weight: .semibold)
            return outgoing
        }

        button.contentHorizontalAlignment = .leading
        button.configuration = config
        button.addAction(.init { [weak self] _ in
            guard let self else { return }
            self.secondCheckButtonTapped()
        }, for: .touchUpInside)

        return button
    }()

    /// firstCheckButtonで設定したedgeInsets系の数値を少し変えてConfigurationに適用したボタン
    private lazy var thirdCheckButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.plain()
        config.title = Const.normalCheckButtonTitle
        config.baseBackgroundColor = .clear
        // UIButton.Configurationに書き換えた際、元のimageをそのまま使用すると修正前の画像サイズと一致しないため、画像サイズの再調整を行う
        config.image = resizeImage(with: Const.normalCheckImage, to: Const.imageSize)?.withRenderingMode(.alwaysOriginal)
        config.imagePlacement = .leading
        config.imagePadding = 5
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 0)

        // ButtonのStateが変わってもfont と titleColorを設定の通りにする
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.systemGray2
            outgoing.font = .systemFont(ofSize: 12, weight: .semibold)
            return outgoing
        }

        button.contentHorizontalAlignment = .leading
        button.configuration = config
        button.addAction(.init { [weak self] _ in
            guard let self else { return }
            self.thirdCheckButtonTapped()
        }, for: .touchUpInside)

        return button
    }()

    private lazy var firstPlayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Const.normalPlayButtonTitle, for: .normal)
        button.setTitleColor(UIColor.systemBlue.withAlphaComponent(0.7), for: .normal)
        button.setImage(Const.playButtonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = .systemBlue.withAlphaComponent(0.7)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        button.titleEdgeInsets.right = 10
        button.semanticContentAttribute = .forceRightToLeft
        button.sizeToFit()
        button.addAction(.init { [weak self] _ in
            guard let self else { return }
            self.firstPlayButtonTapped()
        }, for: .touchUpInside)

        return button
    }()

    // firstPlayButtonで設定したimagePaddingをそのままConfigurationに適用したButton
    private lazy var secondPlayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .systemBlue.withAlphaComponent(0.7)
        config.baseBackgroundColor = .clear
        config.title = Const.normalPlayButtonTitle
        // UIButton.Configurationに書き換えた際、元のimageをそのまま使用すると修正前の画像サイズと一致しないため、画像サイズの再調整を行う
        config.image = resizeImage(with: Const.playButtonImage, to: Const.imageSize)?.withRenderingMode(.alwaysOriginal)
        config.imagePlacement = .trailing
        config.imagePadding = 10
        config.contentInsets = .zero
        // ButtonのStateが変わってもfontとtitleColorを設定値で保持
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = .systemBlue.withAlphaComponent(0.7)
            outgoing.font = .systemFont(ofSize: 14, weight: .semibold)
            return outgoing
        }

        button.configuration = config
        button.sizeToFit()

        button.addAction(.init { [weak self] _ in
            guard let self else { return }
            self.secondPlayButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    // firstPlayButtonで設定したimagePaddingを少し変更してConfigurationに適用したButton
    private lazy var thirdPlayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .systemBlue.withAlphaComponent(0.7)
        config.baseBackgroundColor = .clear
        config.title = Const.normalPlayButtonTitle
        // UIButton.Configurationに書き換えた際、元のimageをそのまま使用すると修正前の画像サイズと一致しないため、画像サイズの再調整を行う
        config.image = resizeImage(with: Const.playButtonImage, to: Const.imageSize)?.withRenderingMode(.alwaysOriginal)
        config.imagePlacement = .trailing
        config.imagePadding = 5
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
        // ButtonのStateが変わってもfontとtitleColorを設定値で保持
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = .systemBlue.withAlphaComponent(0.7)
            outgoing.font = .systemFont(ofSize: 14, weight: .semibold)
            return outgoing
        }

        button.configuration = config
        button.sizeToFit()

        button.addAction(.init { [weak self] _ in
            guard let self else { return }
            self.thirdPlayButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(firstCheckButton)
        view.addSubview(secondCheckButton)
        view.addSubview(thirdCheckButton)
        view.addSubview(firstPlayButton)
        view.addSubview(secondPlayButton)
        view.addSubview(thirdPlayButton)

        // Configurationの更新
        secondCheckButton.configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            var updatedConfig = button.configuration
            switch button.state {
            case .highlighted:
                updatedConfig?.image = resizeImage(with: Const.normalCheckImage, to: Const.imageSize)?.withTintColor(.systemGray).withRenderingMode(.alwaysOriginal)
            case .selected:
                updatedConfig?.image = resizeImage(with: Const.selectedCheckImage, to: Const.imageSize)?.withRenderingMode(.alwaysOriginal)
                updatedConfig?.title = Const.selectedCheckButtonTitle
            default:
                updatedConfig?.image = resizeImage(with: Const.normalCheckImage, to: Const.imageSize)?.withRenderingMode(.alwaysOriginal)
                updatedConfig?.title = Const.normalCheckButtonTitle
            }
            button.configuration = updatedConfig
        }

        // Configurationの更新
        thirdCheckButton.configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            var updatedConfig = button.configuration
            switch button.state {
            case .highlighted:
                updatedConfig?.image = resizeImage(with: Const.normalCheckImage, to: Const.imageSize)?.withTintColor(.systemGray).withRenderingMode(.alwaysOriginal)
            case .selected:
                updatedConfig?.image = resizeImage(with: Const.selectedCheckImage, to: Const.imageSize)?.withRenderingMode(.alwaysOriginal)
                updatedConfig?.title = Const.selectedCheckButtonTitle
            default:
                updatedConfig?.image = resizeImage(with: Const.normalCheckImage, to: Const.imageSize)?.withRenderingMode(.alwaysOriginal)
                updatedConfig?.title = Const.normalCheckButtonTitle
            }
            button.configuration = updatedConfig
        }

        setupUI()
    }

    private func setupUI() {
        NSLayoutConstraint.activate([
            // firstCheckButton の制約
            firstCheckButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            firstCheckButton.heightAnchor.constraint(equalToConstant: 50),
            firstCheckButton.widthAnchor.constraint(equalToConstant: 150),
            firstCheckButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // secondCheckButton の制約
            secondCheckButton.topAnchor.constraint(equalTo: firstCheckButton.bottomAnchor, constant: 20),
            secondCheckButton.heightAnchor.constraint(equalToConstant: 50),
            secondCheckButton.widthAnchor.constraint(equalToConstant: 150),
            secondCheckButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // thirdCheckButton
            thirdCheckButton.topAnchor.constraint(equalTo: secondCheckButton.bottomAnchor, constant: 20),
            thirdCheckButton.heightAnchor.constraint(equalToConstant: 50),
            thirdCheckButton.widthAnchor.constraint(equalToConstant: 150),
            thirdCheckButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // firstPlayButton
            firstPlayButton.topAnchor.constraint(equalTo: thirdCheckButton.bottomAnchor, constant: 20),
            firstPlayButton.heightAnchor.constraint(equalToConstant: 30),
            firstPlayButton.widthAnchor.constraint(equalToConstant: 100),
            firstPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // secondPlayButton
            secondPlayButton.topAnchor.constraint(equalTo: firstPlayButton.bottomAnchor, constant: 20),
            secondPlayButton.heightAnchor.constraint(equalToConstant: 30),
            secondPlayButton.widthAnchor.constraint(equalToConstant: 100),
            secondPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // thirdPlayButton
            thirdPlayButton.topAnchor.constraint(equalTo: secondPlayButton.bottomAnchor, constant: 20),
            thirdPlayButton.heightAnchor.constraint(equalToConstant: 30),
            thirdPlayButton.widthAnchor.constraint(equalToConstant: 100),
            thirdPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])


    }

    private func resizeImage(with image: UIImage?, to size: CGSize) -> UIImage? {
        guard let image = image else { return nil }
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }

    func secondCheckButtonTapped() {
        secondCheckButton.isSelected.toggle()

        var updatedConfig = secondCheckButton.configuration
        updatedConfig?.baseBackgroundColor = .green.withAlphaComponent(0.3)
        secondCheckButton.configuration = updatedConfig
    }
    func thirdCheckButtonTapped() {
        thirdCheckButton.isSelected.toggle()

        thirdCheckButton.configurationUpdateHandler = { button in
            var updatedConfig = button.configuration
            updatedConfig?.baseBackgroundColor = .green.withAlphaComponent(0.3)
            button.configuration = updatedConfig
        }
    }

    func firstPlayButtonTapped() {}
    func secondPlayButtonTapped() {}
    func thirdPlayButtonTapped() {}
}


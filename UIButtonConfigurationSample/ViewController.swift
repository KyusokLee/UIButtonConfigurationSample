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
}

class ViewController: UIViewController {

    private lazy var firstCheckButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("チェックボタン", for: .normal)
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

    /// firstCheckButtonで設定した数値をそのまま利用してConfigurationに適用したボタン
    private lazy var secondCheckButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.plain()
        config.title = "チェックボタン"
        config.image = Const.normalCheckImage
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
        button.addAction(.init { _ in
            self.secondCheckButton.isSelected.toggle()
        }, for: .touchUpInside)

        return button
    }()

    /// firstCheckButtonで設定した数値をそのまま利用してConfigurationに適用したボタン
    private lazy var thirdCheckButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.plain()
        let imageSize = CGSize(width: 20, height: 20)
        config.title = "チェックボタン"
        config.baseBackgroundColor = .clear
        // UIButton.Configurationに書き換えた際、元のimageをそのまま使用すると修正前の画像サイズと一致しないため、画像サイズの再調整を行う
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let resizedImage = renderer.image { _ in
            Const.normalCheckImage?.draw(in: CGRect(origin: .zero, size: imageSize))
        }
        config.image = resizedImage
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
        button.addAction(.init { _ in
            self.secondCheckButton.isSelected.toggle()
        }, for: .touchUpInside)

        return button
    }()

    private lazy var firstPlayButton: UIButton = {
        let button = UIButton()
        button.setTitle("再生する", for: .normal)
        button.setTitleColor(UIColor.systemBlue.withAlphaComponent(0.7), for: .normal)
        button.setImage(Const.playButtonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = .systemBlue.withAlphaComponent(0.7)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        button.titleEdgeInsets.right = 10
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(firstPlayButtonTapped), for: .touchUpInside)

        return button
    }()

    // TODO: Configurationを導入して firstPlayButtonと全く同じUI・機能のボタンを作成する
    // imagePaddingだけで置き換えできるかなと思って試したが、全然ダメだった
    private lazy var secondPlayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        let imageSize = CGSize(width: 20, height: 20)
        // UIButton.Configurationに書き換えた際、元のimageをそのまま使用すると修正前の画像サイズと一致しないため、画像サイズの再調整を行う
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let resizedImage = renderer.image { _ in
            Const.playButtonImage?.draw(in: CGRect(origin: .zero, size: imageSize))
        }

        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .systemBlue.withAlphaComponent(0.7)
        config.baseBackgroundColor = .clear
        config.title = "再生する"
        config.image = resizedImage.withRenderingMode(.alwaysOriginal)
        config.imagePlacement = .trailing
        config.imagePadding = 10
        button.configuration = config
        // ButtonのStateが変わってもfont と titleColorを設定の通りにする
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = .systemBlue.withAlphaComponent(0.7)
            outgoing.font = .systemFont(ofSize: 14, weight: .semibold)
            return outgoing
        }

        button.addTarget(self, action: #selector(secondPlayButtonTapped), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(firstCheckButton)
        view.addSubview(secondCheckButton)
        view.addSubview(thirdCheckButton)
//        view.addSubview(firstPlayButton)
//        view.addSubview(secondPlayButton)

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
            thirdCheckButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            // firstPlayButton
//            firstPlayButton.topAnchor.constraint(equalTo: thirdCheckButton.bottomAnchor, constant: 20),
//            firstPlayButton.heightAnchor.constraint(equalToConstant: 30),
//            firstPlayButton.widthAnchor.constraint(equalToConstant: 80),
//            firstPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            // secondPlayButton
//            secondPlayButton.topAnchor.constraint(equalTo: firstPlayButton.bottomAnchor, constant: 20),
//            secondPlayButton.heightAnchor.constraint(equalToConstant: 30),
//            secondPlayButton.widthAnchor.constraint(equalToConstant: 80),
//            secondPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])


    }

    @objc func firstPlayButtonTapped() {

    }

    @objc func secondPlayButtonTapped() {

    }
}


//
//  WeatherCollectionViewCell.swift
//  
//
//  Created by Shunya Yamada on 2022/04/19.
//

import UIKit
import SharedModel

final class WeatherCollectionViewCell: UICollectionViewCell {

    // MARK: Subview

    private lazy var contentHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var iconBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .systemGray4
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func configure(with consolidatedWeather: WeatherResponse.ConsolidatedWeather) {
        let iconTintColor = makeIconColor(from: consolidatedWeather.weatherStateAbbr)
        titleLabel.text = dateFormatter.string(from: consolidatedWeather.applicableDate)
        iconImageView.image = makeIconImage(from: consolidatedWeather.weatherStateAbbr)
        iconImageView.tintColor = iconTintColor
        iconBackgroundView.backgroundColor = iconTintColor?.withAlphaComponent(0.2)
    }
}

// MARK: Configurations

private extension WeatherCollectionViewCell {

    func configure() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .systemGray.withAlphaComponent(0.2)

        configureSubview()
    }

    func configureSubview() {
        addSubview(contentHStackView)
        addSubview(dividerView)

        contentHStackView.addArrangedSubview(iconBackgroundView)
        contentHStackView.addArrangedSubview(titleLabel)
        contentHStackView.addArrangedSubview(accessoryImageView)

        iconBackgroundView.addSubview(iconImageView)

        NSLayoutConstraint.activate([
            contentHStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            contentHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentHStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            contentHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            iconBackgroundView.widthAnchor.constraint(equalToConstant: 56),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: 56),

            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),

            accessoryImageView.widthAnchor.constraint(equalToConstant: 12),

            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dividerView.heightAnchor.constraint(equalToConstant: 0.5),
        ])
    }
}

private extension WeatherCollectionViewCell {

    func makeIconImage(from weatherStateAbbr: WeatherResponse.ConsolidatedWeather.WeatherStateAbbr?) -> UIImage? {
        switch weatherStateAbbr {
        case .snow:
            return UIImage(systemName: "snow")
        case .sleet:
            return UIImage(systemName: "cloud.sleet.fill")
        case .hail:
            return UIImage(systemName: "cloud.hail.fill")
        case .thunderstorm:
            return UIImage(systemName: "cloud.bolt.fill")
        case .heavyRain:
            return UIImage(systemName: "cloud.heavyrain.fill")
        case .lightRain:
            return UIImage(systemName: "cloud.rain.fill")
        case .showers:
            return UIImage(systemName: "cloud.sun.rain.fill")
        case .heavyCloud:
            return UIImage(systemName: "smoke.fill")
        case .lightCloud:
            return UIImage(systemName: "cloud.fill")
        case .clear:
            return UIImage(systemName: "sun.max.fill")
        default:
            return UIImage(systemName: "questionmark.circle.fill")
        }
    }

    func makeIconColor(from weatherStateAbbr: WeatherResponse.ConsolidatedWeather.WeatherStateAbbr?) -> UIColor? {
        switch weatherStateAbbr {
        case .snow, .sleet, .hail:
            return .systemTeal
        case .thunderstorm:
            return .systemYellow
        case .heavyRain, .lightRain, .showers:
            return .systemBlue
        case .lightCloud, .heavyCloud:
            return .systemGray
        case .clear:
            return .systemOrange
        default:
            return .systemBlue
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.setLocalizedDateFormatFromTemplate("dMMM")
    return formatter
}()

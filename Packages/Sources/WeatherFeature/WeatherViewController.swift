//
//  WeatherViewController.swift
//  
//
//  Created by Shunya Yamada on 2022/04/19.
//

import Combine
import UIKit
import SharedModel

public final class WeatherViewController: UIViewController {

    // MARK: Subviews

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: WeatherCollectionViewCell.self))
        return collectionView
    }()

    // MARK: Property

    private let viewModel: WeatherViewModel
    private var cancellables = Set<AnyCancellable>()

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        return UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WeatherCollectionViewCell.self), for: indexPath) as! WeatherCollectionViewCell
            cell.configure(with: item.consolidatedWeather)
            return cell
        })
    }()

    // MARK: Lifecycle

    public init(viewModel: WeatherViewModel = WeatherViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureSubviews()
        bindViewModel()

        viewModel.onViewDidLoad()
    }
}

// MARK: - Configurations

private extension WeatherViewController {

    func configureNavigation() {
        navigationItem.title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureSubviews() {
        view.backgroundColor = .systemBackground

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    func bindViewModel() {
        viewModel.consolidatedWeathersPublisher
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] consolidatedWeathers in
                    self?.configureDataSource(with: consolidatedWeathers)
                }
            )
            .store(in: &cancellables)
    }

    func createCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { section, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }

    func configureDataSource(with consolidatedWeathers: [WeatherResponse.ConsolidatedWeather]) {
        let items = consolidatedWeathers.map { Item(consolidatedWeather: $0) }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.weather])
        snapshot.appendItems(items, toSection: .weather)
        dataSource.apply(snapshot)
    }
}

// MARK: - CollectionView Delegate

extension WeatherViewController: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - Section

private extension WeatherViewController {

    enum Section {
        case weather
    }

    struct Item: Hashable {
        let consolidatedWeather: WeatherResponse.ConsolidatedWeather

        func hash(into hasher: inout Hasher) {
            hasher.combine(consolidatedWeather.id)
        }

        static func ==(lhs: Item, rhs: Item) -> Bool {
            lhs.consolidatedWeather.id == rhs.consolidatedWeather.id
        }
    }
}

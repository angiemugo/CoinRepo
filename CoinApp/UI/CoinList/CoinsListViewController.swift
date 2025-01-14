//
//  CoinsListViewController.swift
//  CoinApp
//
//  Created by Angie Mugo on 09/01/2025.
//

import UIKit
import Combine

enum Section: CaseIterable {
    case coins
}

class CoinsListViewController: BaseViewController, UITableViewDelegate {
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel: CoinsListViewModel
    private let sort = PassthroughSubject<SortOptions, Never>()
    private let selection = PassthroughSubject<String, Never>()
    private let isFavorite = PassthroughSubject<Bool, Never>()
    private let loadMore = PassthroughSubject<Int, Never>()
    private let favoriteCoin = PassthroughSubject<UICoinModel, Never>()
    private lazy var dataSource = makeDataSource()
    private var loadingFooterView: UIView!
    private var isLoading = false

    init(viewModel: CoinsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @UsesAutoLayout
    private(set) var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.isFavorites {
            loadMore.send(0)
            isFavorite.send(true)
        } else {
            loadMore.send(0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        let coinID = snapshot.itemIdentifiers[indexPath.row].id
        selection.send(coinID)
    }

    private func configureUI() {
        title = "Coins List"
        setupNavigationItem()
        setupTableView()
    }

    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            style: .plain,
            target: self,
            action: #selector(showFilterOptions)
        )
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.rowHeight = 100
        tableView.register(CoinCell.self, forCellReuseIdentifier: "\(CoinCell.self)")
        applyTableViewConstraints()
    }

    private func applyTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        cancellables = []
        let input = CoinListVMInput(
            loadMore: loadMore.eraseToAnyPublisher(),
            sortOption: sort.eraseToAnyPublisher(),
            isFavorite: isFavorite.eraseToAnyPublisher(),
            selection: selection.eraseToAnyPublisher(),
            favoriteCoin: favoriteCoin.eraseToAnyPublisher()
        )

        viewModel.transform(input: input)
            .sink(receiveValue: { [unowned self] state in
                self.render(for: state)
            })
            .store(in: &cancellables)
    }

    private func render(for state: CoinListLoadingState) {
        hideLoading()
        isLoading = false

        switch state {
        case .idle:
            update(with: [], animate: true)
        case .loading:
            showLoadingView()
            update(with: [], animate: false)
        case .loaded(let coins):
            update(with: coins, animate: true)
        case .error(let error):
            showErrorView(error: error)
            update(with: [], animate: true)
        }
    }

    func update(with coins: [UICoinModel], animate: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UICoinModel>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(coins, toSection: .coins)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Section, UICoinModel> {
        return UITableViewDiffableDataSource<Section, UICoinModel>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, coinModel in
                guard let cell = tableView.dequeueReusableCell(withClass: CoinCell.self) else {
                            assertionFailure("Failed to dequeue \(CoinCell.self)!")
                            return UITableViewCell()
                        }
                cell.configure(coin: coinModel)
                return cell
            }
        )
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let coin = dataSource.itemIdentifier(for: indexPath) else { return nil }
        let action = createSwipeAction(for: coin)
        return UISwipeActionsConfiguration(actions: [action])
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height - 50 {
            guard !isLoading && !viewModel.isFavorites else { return }
            isLoading = true
            loadMore.send(viewModel.currentPage + 1)
            setupLoadingFooter()
        }
    }

    private func setupLoadingFooter() {
        loadingFooterView = UIView()
        loadingFooterView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)

        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = loadingFooterView.center
        loadingFooterView.addSubview(activityIndicator)

        activityIndicator.startAnimating()
        tableView.tableFooterView = loadingFooterView
    }

    private func createSwipeAction(for coin: UICoinModel) -> UIContextualAction {
        let isFavorited = coin.isFavorite
        let title = isFavorited ? "Remove" : "Favorite"
        let backgroundColor = isFavorited ? UIColor.systemGray : UIColor.systemPurple

        return UIContextualAction(style: .normal, title: title) { [weak self] _, _, completion in
            guard let self = self else { return }
            self.favoriteCoin.send(coin)
        }.withBackgroundColor(backgroundColor)
    }

    // MARK: - Filter Options

    @objc private func showFilterOptions() {
        let alertController = UIAlertController(title: "Filter Coins", message: "Choose a filter option", preferredStyle: .actionSheet)

        let actions: [(title: String, option: SortOptions)] = [
            ("By Price", .price),
            ("By 24-hour Performance", .performance)
        ]

        actions.forEach { action in
            alertController.addAction(UIAlertAction(title: action.title, style: .default) { [weak self] _ in
                self?.sort.send(action.option)
            })
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
}

// MARK: - Extensions
private extension UIContextualAction {
    func withBackgroundColor(_ color: UIColor) -> UIContextualAction {
        backgroundColor = color
        return self
    }
}

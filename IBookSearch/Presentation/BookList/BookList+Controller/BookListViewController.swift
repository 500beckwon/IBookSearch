//
//  BookListViewController.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import UIKit

final class BookListViewController: UIViewController {
    public private(set) var bookListView = BookListView()
    public private(set) var loadingIndicator = UIActivityIndicatorView()
    public private(set) lazy var searchController = UISearchController(searchResultsController: nil)
    
    let viewModel: BookListViewModel
    
    init(viewModel: BookListViewModel = BookListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setConfigurehandler()
        loadNewBookList()
    }
}

private extension BookListViewController {
    func setConfigurehandler() {
        viewModel.resultHandler = { [weak self] in
            self?.reload()
        }
    }
    
    func loadNewBookList() {
        viewModel
            .requestNewBookList()
    }
    
    func searchBook(isPaging: Bool = true) {
        viewModel
            .searchingRequest(isPaging: isPaging)
    }
    
    func resetList() {
        viewModel
            .requestSearchReset()
    }
    
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.bookListView.reloadData()
        }
    }
}

extension BookListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
    }
}

extension BookListViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = true
    }
}

extension BookListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.showsCancelButton = false
        resetList()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel
            .recodeSearchTest(text: searchBar.text ?? "")
        searchBook(isPaging: false)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        title = "검색"
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        title = "신간"
    }
}

extension BookListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfRowInSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInCell(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: BookTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configureCell(viewModel.getBook(index: indexPath.row))
            return cell
        default:
            let cell: SearchLoadingTableCell = tableView.dequeueReusableCell(for: indexPath)
            cell.startLoading()
            return cell
        }
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard
            indexPath.section == 0,
            indexPath.row - 2 == viewModel.listCount - 3 else {
            return
        }
        searchBook()
    }
}

private extension BookListViewController {
    func setupLayout() {
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func insertUI() {
        [
            bookListView,
            loadingIndicator
        ].forEach {
            view.addSubview($0)
        }
    }
    
    func basicSetUI() {
        title = "신간"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        bookListView.delegate = self
        bookListView.dataSource = self
        
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.automaticallyShowsCancelButton = true
        searchController.searchBar.showsCancelButton = false
        
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = "찾으실 책 제목을 입력해주세요."
        
        loadingIndicator.color = .systemGray
        loadingIndicator.hidesWhenStopped = true
    }
    
    func anchorUI() {
        bookListView
            .anchor(
                top: view.safeAreaLayoutGuide.topAnchor,
                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                leading: view.leadingAnchor,
                trailing: view.trailingAnchor
            )
        
        loadingIndicator
            .anchor(
                centerX: view.centerXAnchor,
                centerY: view.centerYAnchor
            )
    }
}

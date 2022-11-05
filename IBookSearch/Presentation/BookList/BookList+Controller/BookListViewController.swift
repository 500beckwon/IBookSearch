//
//  BookListViewController.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/10/31.
//

import UIKit

final class BookListViewController: UIViewController {
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    private lazy var emptyLabel = UILabel()
    public private(set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 1, left: 6, bottom: 5, right: 6)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var lastSelectedIndexPath: IndexPath?
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
        setConfigureHandler()
        loadNewBookList()
        setNotificationCenter()
    }
}

private extension BookListViewController {
    func setConfigureHandler() {
        viewModel
            .resultHandler = { [weak self] in
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
            guard let self = self else { return }
            self.emptyLabel.isHidden = self.viewModel.listCount != 0
            self.collectionView.reloadData()
        }
    }
    
    @objc
    func scrollNotification(_ notification: Notification) {
        if let index = notification.object as? Int {
            guard index < viewModel.listCount else { return }
            lastSelectedIndexPath = [0, index]
            collectionView.scrollToItem(at: [0, index], at: .top, animated: false)
            let cell: BookCollectionViewCell? = self.collectionView.cellForItem(for: [0, index])
            cell?.setHighlighted(true)
        }
    }
    
    func setNotificationCenter() {
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(scrollNotification),
                         name: .scrollCurrentCell,
                         object: nil)
    }
    
    func cellUnHighlight() {
        collectionView.visibleCells.forEach {
            if let cell = $0 as? BookCollectionViewCell {
                cell.setHighlighted(false)
            }
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
        collectionView.setContentOffset(.zero, animated: false)
        resetList()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        collectionView.setContentOffset(.zero, animated: false)
        viewModel
            .recodeSearchTest(text: searchBar.text ?? "")
        searchBook(isPaging: false)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        title = "신간"
    }
}

extension BookListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfRowInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowInCell(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: BookCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configureCell(viewModel.getBook(index: indexPath.row))
            return cell
        default:
            let cell: SearchLoadingCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.startLoading()
            return cell
        }
    }
}

extension BookListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.size
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 80)
        } else {
            return CGSize(width: size.width, height: 50)
        }
    }
}

extension BookListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lastSelectedIndexPath = indexPath
        cellUnHighlight()
        let vc = BookDetailViewController(bookList: viewModel.bookListInfo, selectIndex: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
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
            collectionView,
            emptyLabel,
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
        
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.automaticallyShowsCancelButton = true
        searchController.searchBar.showsCancelButton = false
        
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = "찾으실 책 제목을 입력해주세요."
        
        collectionView.registerCell(BookCollectionViewCell.self)
        collectionView.registerCell(SearchLoadingCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        emptyLabel.textAlignment = .center
        emptyLabel.text = "해당 도서가 존재하지 않습니다."
        emptyLabel.backgroundColor = .systemBackground
        emptyLabel.textColor = .systemBlue
        emptyLabel.font = .boldSystemFont(ofSize: 15)
        emptyLabel.numberOfLines = 2
        emptyLabel.isHidden = true
    }
    
    func anchorUI() {
        collectionView
            .anchor(
                top: view.safeAreaLayoutGuide.topAnchor,
                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                leading: view.leadingAnchor,
                trailing: view.trailingAnchor
            )
        
        emptyLabel.anchor(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor,
            centerYConstant: -30
        )
    }
}

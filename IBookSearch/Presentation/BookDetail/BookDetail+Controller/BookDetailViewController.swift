//
//  BookDetailViewController.swift
//  IBookSearch
//
//  Created by ByungHoon Ann on 2022/11/04.
//

import UIKit

final class BookDetailViewController: UIViewController {
    
    private var backButton = UIButton(type: .system)
    public private(set) lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = view.frame.size
        let collectionView = UICollectionView(frame: view.frame,
                                              collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    weak var transitionController: BookDetailInteractiveDismissTransition? = nil
    
    public private(set) var isInteractivelyDismissing = false
    public private(set) var displayCell: BookDetailCollectionCell?
    
    private let viewModel: BookDetailListViewModel
    
    init(bookList: [Book], selectIndex: Int) {
        viewModel = BookDetailListViewModel(bookList: bookList,
                                            selectedIndex: selectIndex)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.scrollToItem(at: [0, viewModel.selectedIndex],
                                    at: [], animated: false)
        title = viewModel.bookTitle
    }
    
    func sendCurrentCellIndex() {
        NotificationCenter.default.post(name: .scrollCurrentCell,
                                        object: viewModel.selectedIndex)
    }
}

private extension BookDetailViewController {
    @objc func backButtonTapped(_ sender: UIButton) {
        sendCurrentCellIndex()
        navigationController?.popViewController(animated: true)
    }
    
    func setupLayout() {
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    func insertUI() {
        view.addSubview(collectionView)
    }
    
    func basicSetUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        backButton.setImage(UIImage(systemName: "chevron.backward"),
                            for: .normal)
        backButton.addTarget(self,
                             action: #selector(backButtonTapped),
                             for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftBarButton
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerCell(BookDetailCollectionCell.self)
    }
    
    func anchorUI() {
        collectionView
            .anchor(
                top:view.safeAreaLayoutGuide.topAnchor,
                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                leading: view.leadingAnchor,
                trailing: view.trailingAnchor
            )
    }
}

extension BookDetailViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x/scrollView.frame.width
        viewModel.selectedIndex = Int(index)
        title = viewModel.bookTitle
        
    }
}

extension BookDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowInCell(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BookDetailCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.detailRequestBook(viewModel: viewModel.cellItem(index: indexPath.item))
        displayCell = cell
        return cell
    }
}

extension BookDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout: UICollectionViewLayout,
                        sizeForItemAt: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}

extension BookDetailViewController: UICollectionViewDelegate { }



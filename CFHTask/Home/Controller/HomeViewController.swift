//
//  HomeViewController.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

import UIKit

public class HomeViewController: UIViewController {
    // MARK: UIKit
    private var scrollNavigationView: ScrollNavigationView?
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.bounces = false
        // register Cell
        tableView.register(
            UINib(
                nibName: SimpleStackCell.cellIdentifier(),
                bundle: nil),
            forCellReuseIdentifier: SimpleStackCell.cellIdentifier()
        )
        return tableView
    }()
    
    // MARK: - ViewModel
    private let scrollViewModel = ScrollNavigationViewModel(
        mainTitle: "我是大Title",
        secondTitle: "我是小Title",
        height: 200
    )
    private var viewModel: HomeViewModel?
    
    // MARK: - NavigationViewLayoutSet
    private var scrollNavigationViewLayoutSet: NSLayoutConstraintSet?
    
    // MARK: - lifecycle methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        initViewAndLayoutConstraints()
        initViewModel()
    }
    
    // MARK: - init View and ViewModel
    private func initViewAndLayoutConstraints() {
        view.backgroundColor = .white
        initScrollNavigationView(viewModel: scrollViewModel)
        view.addSubview(tableView)
        setupLayoutConstraintSet()
    }
    
    private func initScrollNavigationView(
        viewModel : ScrollNavigationViewModel = ScrollNavigationViewModel()
    ) {
        scrollNavigationView = ScrollNavigationView(
            frame: .zero,
            viewModel: viewModel
        )
        guard let scrollNavigationView = scrollNavigationView else { return }
        view.addSubview(scrollNavigationView)
    }
    
    private func setupLayoutConstraintSet() {
        guard let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets else { return }
        guard let scrollNavigationView = scrollNavigationView else { return }
        
        scrollNavigationViewLayoutSet = NSLayoutConstraintSet(
            top: scrollNavigationView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: safeAreaInsets.top),
            left: scrollNavigationView.leftAnchor.constraint(
                equalTo: view.leftAnchor),
            right: scrollNavigationView.rightAnchor.constraint(
                equalTo: view.rightAnchor),
            height: scrollNavigationView.heightAnchor.constraint(
                equalToConstant: scrollViewModel.height)
        ).activate()
        scrollNavigationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraintSet(
            top: tableView.topAnchor.constraint(
                equalTo: scrollNavigationView.bottomAnchor),
            bottom: tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -(safeAreaInsets.bottom )),
            left: tableView.leftAnchor.constraint(
                equalTo: view.leftAnchor),
            right: tableView.rightAnchor.constraint(
                equalTo: view.rightAnchor)
        ).activate()
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initViewModel() {
        viewModel = HomeViewModel(
            tableView: tableView,
            scrollNavigationViewHeight: scrollViewModel.height
        )
        viewModel?.updateUIForScrollY = {
            [weak self] (values) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.scrollNavigationViewLayoutSet?.height?.constant = values.scrollNavigationViewHeight
                self.tableView.tableHeaderView = UIView(
                    frame: CGRect(
                        x: 0,
                        y: 0,
                        width: UIScreen.main.bounds.size.width,
                        height: values.tableHeaderViewHeight
                    )
                )
                self.scrollNavigationView?.topView?.alpha = values.scrollNavigationViewTopViewAlpha
                guard let secondLabel = self.scrollNavigationView?.bottomView?.subviews.first as? UILabel else { return }
                secondLabel.alpha = values.scrollNavigationViewBottomViewSecondLabelAlpha
            }
        }
        viewModel?.updateTableViewContentOffset = {
            [weak self] (point) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.tableView.setContentOffset(point, animated: true)
            }
        }
    }
}

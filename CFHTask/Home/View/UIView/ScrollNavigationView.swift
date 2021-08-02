//
//  ScrollNavigationView.swift
//  CFHTask
//
//  Created by fox on 2021/7/29.
//

import UIKit

/// ScrollNavigationViewModel
public class ScrollNavigationViewModel {
    // UI 顯示相關
    /// TitleText
    public var mainTitle: String
    /// SecondTitle
    public var secondTitle: String
    /// showSegmentedOrNot
    public var showSegmented: Bool
    /// segmantedTitles
    public var segmantedTitles: [String]
    /// TotalHeight
    public var height: CGFloat
    
    public init(
        mainTitle: String = "",
        secondTitle: String = "",
        showSegmented: Bool = true,
        segmantedTitles: [String] = ["植物帳戶", "動物帳戶"],
        height: CGFloat = 200
    ) {
        self.mainTitle = mainTitle
        self.secondTitle = secondTitle
        self.showSegmented = showSegmented
        self.segmantedTitles = segmantedTitles
        self.height = height
    }
}

public class ScrollNavigationView: UIView {
    public class CheckValues {
        /// 為傳入height的 1 / 3 Height
        var separate: CGFloat
        /// 為傳入height的 1 / 3 * 2 (topView高度) / 3 Height(分三塊)
        var topSeparate: CGFloat
        /// 為傳入height的 1 / 3 (bottomView高度) / 2 Height(我想要設置置中時用)
        var bottomSeparate: CGFloat
        /// 為螢幕的寬
        var screenWidth: CGFloat
        
        public init(height: CGFloat) {
            separate = height / 3
            topSeparate = (separate * 2) / 3
            bottomSeparate = separate / 2
            screenWidth = UIScreen.main.bounds.size.width
        }
    }
    
    private var viewModel: ScrollNavigationViewModel?
    public var topView: UIView?
    public var bottomView: UIView?
    private var checkValues: CheckValues {
        return CheckValues(height: viewModel?.height ?? 200)
    }
    
    public init(frame: CGRect,
         viewModel: ScrollNavigationViewModel)
    {
        super.init(frame: frame)
        self.viewModel = viewModel
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }
        // 我想說分成上下兩個View去顯示，因為透明度是一整塊上面一起變
        // topView
        topView = UIView(frame: .zero)
        // 然後再分成三小塊 1.影片的icon(這個我沒實作喔) 2.SegmentedController 3.title
        if viewModel.showSegmented {
            topView?.addSubview(creatSegmentedController())
        }
        // mainTitle
        topView?.addSubview(creatMainTitle())
        // BottomView
        bottomView = UIView(frame: .zero)
        bottomView?.addSubview(creatSecondTitle())
        guard let topView = topView else { return }
        guard let bottomView = bottomView else { return }
        addSubview(topView)
        addSubview(bottomView)
        
        // topViewLayoutConstraint Height: separate * 2
        NSLayoutConstraintSet(
            top: topView.topAnchor.constraint(
                equalTo: topAnchor),
            left: topView.leftAnchor.constraint(
                equalTo: leftAnchor),
            right: topView.rightAnchor.constraint(
                equalTo: rightAnchor),
            height: topView.heightAnchor.constraint(
                equalToConstant: checkValues.separate * 2)
        ).activate()
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        // bottomViewLayoutConstraint Height: separate
        NSLayoutConstraintSet(
            bottom: bottomView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            left: bottomView.leftAnchor.constraint(
                equalTo: leftAnchor),
            right: bottomView.rightAnchor.constraint(
                equalTo: rightAnchor),
            height: bottomView.heightAnchor.constraint(
                equalToConstant: checkValues.separate)
        ).activate()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        // 給個底色看起來比較知道動畫走向
        let backGroundColor = UIColor.green
        topView.backgroundColor = backGroundColor
        backgroundColor = backGroundColor
        bottomView.backgroundColor = .clear
    }
    
    private func creatSegmentedController() -> UISegmentedControl {
        guard let viewModel = viewModel,
              viewModel.showSegmented,
              viewModel.segmantedTitles.count > 0
        else { return UISegmentedControl() }
        
        let deleteWidth: CGFloat = 20
        let segmented = UISegmentedControl(
            frame: CGRect(
                x: deleteWidth,
                y: checkValues.topSeparate,
                width: checkValues.screenWidth - (deleteWidth * 2),
                height: checkValues.topSeparate
            )
        )
        segmented.replaceSegments(
            segments: viewModel.segmantedTitles.map({ return $0 }))
        segmented.selectedSegmentIndex = 0
        return segmented
    }
    
    private func creatMainTitle() -> UILabel {
        guard let viewModel = viewModel else { return UILabel() }
        let label = UILabel(
            frame: CGRect(
                x: 0,
                y: checkValues.topSeparate * 2,
                width: checkValues.screenWidth,
                height: checkValues.topSeparate
            )
        )
        label.text = viewModel.mainTitle
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
                        
        return label
    }
    
    private func creatSecondTitle() -> UILabel {
        guard let viewModel = viewModel else { return UILabel() }
        let label = UILabel(frame: .zero)
        label.text = viewModel.secondTitle
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.sizeToFit()
        label.center = CGPoint(
            x: checkValues.screenWidth / 2,
            y: checkValues.bottomSeparate
        )
        // 生成時是透明的
        label.alpha = 0
                        
        return label
    }
}

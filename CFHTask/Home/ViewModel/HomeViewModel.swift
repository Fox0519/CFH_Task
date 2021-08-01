//
//  HomeViewModel.swift
//  CFHTask
//
//  Created by fox on 2021/7/30.
//

import UIKit

public class HomeViewModel {
    public var adapter: HomeAdapter?
    private var scrollNavigationViewHeight: CGFloat = 0
    /// 記錄目前抓到第幾頁了 如為-1代表無下一頁或正在Loading，就不要抓了
    private var apiPage: Int = 1
    public struct UpdateUIForScrollValues {
        let scrollNavigationViewHeight: CGFloat
        let scrollNavigationViewTopViewAlpha: CGFloat
        let scrollNavigationViewBottomViewSecondLabelAlpha: CGFloat
        let tableHeaderViewHeight: CGFloat
    }
    public var updateUIForScrollY: ((_ updateUIValues: UpdateUIForScrollValues) -> Void)?
    public var updateTableViewContentOffset: ((_ point: CGPoint) -> Void)?
    
    public init(tableView: UITableView,
         scrollNavigationViewHeight: CGFloat
    ) {
        setupAdapter(tableView: tableView)
        self.scrollNavigationViewHeight = scrollNavigationViewHeight
        getAPIData(pageNum: apiPage)
    }
    
    private func setupAdapter(tableView: UITableView) {
        adapter = HomeAdapter(tableView)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        adapter?.delegateForScroll = self
        // 設置滑到倒數五筆左右會抓下一頁
        adapter?.reachedBottom = { [weak self] in
            guard let `self` = self else { return }
            self.getAPIData(pageNum: self.apiPage)
        }
    }
    
    /// 抓API
    private func getAPIData(pageNum: Int) {
        // 如為-1代表無下一頁或正在Loading，就不要抓了
        guard apiPage > 0 else { return }
        // 正要抓下一頁，把apiPage設成 -1 表示在Loading 防止同一頁重複抓取等問題
        apiPage = -1
        ApiServer.shared.fetchZooPlantList(
            parameters: ApiServer.shared.paramZooPlantList(page: pageNum)
        ) { [weak self] (jsonModel, error) in
            guard let `self` = self else { return }
            self.whenApiReportCheckApiPage(
                success: error == nil,
                pageNum: pageNum,
                newDataCount: jsonModel?.count
            )
            if error == nil,
               let models = jsonModel
            {
                self.adapter?.updateData(
                    models: [HomeSectionModel(
                                rowModels: self.getSimpleStackRowModel(
                                    models: models
                                )
                    )]
                )
            } else {
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    /// 判別Api抓取後有無下一頁
    private func whenApiReportCheckApiPage(
        success: Bool,
        pageNum:Int,
        newDataCount: Int?
    ) {
        if success {
            apiPage = pageNum + 1
            // 防止小單位重複Loading 造成UI Cell 跳來跳去
            if let checkCount = newDataCount, checkCount < 8 {
                apiPage = -1
            }
        } else {
            apiPage = -1
        }
    }
    
    private func getSimpleStackRowModel(
        models: [ZooPlantModel]
    ) -> [SimpleStackRowModel] {
        // 先給舊有的model再添加新的model(目前這頁只用到一個section所以用first，若有改這邊也要改)
        var rowModels = (adapter?.models?.first?.rowModels ?? []) as? [SimpleStackRowModel] ?? []
        let titles  = [
            "中文名稱",
            "所在位置",
            "型態象徵",
            "照片URL",
            "第幾Row",
        ]
        for model in models {
            var views: [UIView] = []
            let details = [
                model.name,
                model.location,
                model.feature,
                model.picUrl,
                "\(rowModels.count)",
            ]
            for index in 0...titles.count - 1 {
                // 無資料就不給
                if let detail = details[safe: index],
                   !detail.isEmpty
                {
                    views.append(
                        creatSimpleView(
                            data: SimpleTitleDataModel(
                                title: titles[safe: index] ?? "",
                                detail: detail
                            )
                        )
                    )
                }
            }
            rowModels.append(SimpleStackRowModel(stackViews: views))
        }
        return rowModels
    }
    
    private func creatSimpleView(data: SimpleTitleDataModel) -> UIView {
        let view = UINib(
            nibName: String(describing: SimpleTitleDataView.self),
            bundle: nil
        ).instantiate(
            withOwner: nil,
            options: nil
        ).first as? SimpleTitleDataView ?? SimpleTitleDataView()
        
        view.setup(title: data.title, detail: data.detail)
        return view
    }
}

extension HomeViewModel: ScrollTableViewDelegate {
    private class CheckHeights {
        /// 為傳入height的1/3
        public var min: CGFloat
        /// 為傳入height的1/3*2(= / 1.5)
        public var max: CGFloat
        /// 為傳入height的一半
        public var half: CGFloat
        /// 為傳入height扣除y之值
        public var final: CGFloat
        /// 為傳入的max的一半
        public var halfMax: CGFloat
        
        public init(
            height: CGFloat,
            y: CGFloat = 0
        ) {
            min = height / 3
            max = height / 1.5
            half = height / 2
            final = height - y
            halfMax = max / 2
        }
    }
    
    public func scrollTableViewWith(
        y: CGFloat,
        finish: Bool
    ) {
        guard y >= 0 else { return }
        // 把可能需要確認的數值封裝起來方便使用
        let checkHeights = CheckHeights(
            height: scrollNavigationViewHeight,
            y: y
        )
        if !finish {
            // update UIs
            updateUIForScrollY?(
                UpdateUIForScrollValues(
                    // 最小不得小於min的高度
                    scrollNavigationViewHeight:
                        checkHeights.final < checkHeights.min ? checkHeights.min : checkHeights.final,
                    // y越大越透明
                    scrollNavigationViewTopViewAlpha:
                        1 - (y / checkHeights.max),
                    // 先看y有無過半才開始顯示
                    scrollNavigationViewBottomViewSecondLabelAlpha:
                        y > checkHeights.halfMax ? ((y - checkHeights.halfMax) / checkHeights.halfMax) : 0,
                    // 跟著y成比例變高，直到高到max就不變了
                    tableHeaderViewHeight:
                        y > checkHeights.max ? checkHeights.max : y
                )
            )
        } else {
            // 先看還需不需要自動歸位
            guard !(y > checkHeights.max || y == 0) else { return }
            updateTableViewContentOffset?(
                // 以中間點來決定回到哪
                CGPoint(x: 0, y: checkHeights.halfMax > y ? 0 : checkHeights.max)
            )
        }
    }
}

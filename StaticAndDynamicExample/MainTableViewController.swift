//
//  MainTableViewController.swift
//  StaticAndDynamicExample
//
//  Created by Chakery on 16/9/5.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    fileprivate let identifier = String(describing: WiFiTableViewCell.self)
    fileprivate let NibName = String(describing: WiFiTableViewCell.self)
    fileprivate var datasource: [String] = []
    
    @IBOutlet weak var didSelectedWiFiLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        intiDatasource()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 初始化数据源（模拟请求网络，3秒后返回数据并刷新列表）
    func intiDatasource() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let wifiName = "Chakery-WiFi-"
            (1...30).forEach { [weak self] i in
                guard let `self` = self else { return }
                self.datasource.append(wifiName + "\(i)")
            }
            self.tableView.reloadSections(IndexSet(integer: 1), with: .bottom)
        }
    }
    
    /// 注册Cell
    func registerTableViewCell() {
        let nib = UINib(nibName: NibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
}

// MARK: - 静态Cell与动态cell混合使用时，需要实现以下方法
extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? WiFiTableViewCell
            cell?.dataBind(datasource[indexPath.row])
            return cell!
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return datasource.count
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.section == 1 {
            return super.tableView(tableView, indentationLevelForRowAt: IndexPath(row: 0, section: 1))
        }
        return super.tableView(tableView, indentationLevelForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 44
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}

// MARK: - 其他方法
extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectedWiFiAtIndexPath(indexPath)
    }
    
    func didSelectedWiFiAtIndexPath(_ indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        guard indexPath.row < self.datasource.count else { return }
        let name = datasource[indexPath.row]
        didSelectedWiFiLabel.text = name
    }
    
}









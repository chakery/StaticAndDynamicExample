//
//  MainTableViewController.swift
//  StaticAndDynamicExample
//
//  Created by Chakery on 16/9/5.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    private let identifier = String(WiFiTableViewCell)
    private let NibName = String(WiFiTableViewCell)
    private var datasource: [String] = []
    
    @IBOutlet weak var didSelectedWiFiLabel: UILabel!
    
    
    
    /**
     初始化数据源（模拟请求网络，3秒后返回数据并刷新列表）
     */
    func intiDatasource() {
        let duration = dispatch_time(DISPATCH_TIME_NOW, (Int64)(3 * NSEC_PER_SEC))
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_after(duration, queue) { 
            let wifiName = "Chakery-WiFi-"
            (1...6).forEach { [weak self] i in
                guard let `self` = self else { return }
                self.datasource.append(wifiName + "\(i)")
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: .Bottom)
            }
        }
    }
    
    /**
     注册Cell
     */
    func registerTableViewCell() {
        let nib = UINib(nibName: NibName, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        intiDatasource()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - 静态Cell与动态cell混合使用时，需要实现以下方法
extension MainTableViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? WiFiTableViewCell
            cell?.dataBind(datasource[indexPath.row])
            return cell!
        }
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return datasource.count
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        if indexPath.section == 1 {
            return super.tableView(tableView, indentationLevelForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 1))
        }
        return super.tableView(tableView, indentationLevelForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 44
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
}

// MARK: - 其他方法
extension MainTableViewController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        didSelectedWiFiAtIndexPath(indexPath)
    }
    
    func didSelectedWiFiAtIndexPath(indexPath: NSIndexPath) {
        guard indexPath.section == 1 else { return }
        guard indexPath.row < self.datasource.count else { return }
        let name = datasource[indexPath.row]
        didSelectedWiFiLabel.text = name
    }
    
}









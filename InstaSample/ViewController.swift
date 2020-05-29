//
//  ViewController.swift
//  InstaSample
//
//  Created by 加藤拓洋 on 2020/05/23.
//  Copyright © 2020 TakumiKato. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TimelineTableViewCell
        
        //内容
        cell.userNameLabel.text = "サンプル"
        
        return cell
    }
    
    @IBOutlet var timelineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timelineTableView.dataSource = self
        timelineTableView.delegate = self
        
        let nib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle.main)
        timelineTableView.register(nib,forCellReuseIdentifier: "Cell")
        
        timelineTableView.tableFooterView = UIView()
    }


}


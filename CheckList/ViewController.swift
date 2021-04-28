//
//  ViewController.swift
//  CheckList
//
//  Created by 전지훈 on 2021/04/28.
//

import UIKit

class ChecklistItem {
    let title: String
    var isChecked: Bool = false
    
    init(title: String) {
        self.title = title
    }
}

class ViewController: UIViewController {
    
    let items: [ChecklistItem] = [
        "iOS 공부하기",
        "라라벨 웹개발 공부하기",
        "리액트 공부하기",
        "코틀린 공부하기",
        "휴식취하기",
        "기타등등"
    ].compactMap({
        ChecklistItem(title: $0)
    })
    
    var checkedBox: [String]?
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isChecked ? .checkmark : .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        item.isChecked = !item.isChecked
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        print("checked: \(item.title) \(item.isChecked)")
        if item.isChecked == true {
            print("checkedBox true: \(item.title)")
            checkedBox?.append(item.title)
        } else if item.isChecked == false {
            print("checkedBox false: \(item.title)")
            checkedBox?.remove(at: indexPath.row)
        }
    }
}

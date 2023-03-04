//
//  View.swift
//  ViperCoreData
//
//  Created by Osinnowo Emmanuel on 04/03/2023.
//

import UIKit

protocol AnyView: AnyObject {
    var presenter: AnyPresenter? { get }
    func update(with users: [User])
    func update(with error: Error)
}

final class UserViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    var presenter: AnyPresenter?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.users[indexPath.row].name
        return cell
    }
    
    func update(with users: [User]) {
        print("Called Twice!")
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    func update(with error: Error) { }
}

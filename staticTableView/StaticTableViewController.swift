//
//  StaticTableViewController.swift
//  staticTableView
//
//  Created by Khawar Shah on 21.11.2022.
//

import UIKit

final class StaticTableViewController: UITableViewController {
    struct SettingItem {
        let title: String
        let imageName: String
        let isOn: Bool? = nil
    }
    
    var data: [[SettingItem]] = [
        [
            SettingItem(title: "Notification", imageName:  "" ) ,
            SettingItem(title: "Hide close", imageName:  "" )
        ],[
            SettingItem(title: "Member list", imageName:  ""),
            SettingItem(title: "Asset list", imageName:  "")
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SwitchCell.self, forCellReuseIdentifier: "cell")
        tableView.register(NormalCell.self, forCellReuseIdentifier: "cell2")
    }
    
    @objc
    func handleNotification(_ sender: UISwitch){
        print(1)
    }
    
    @objc
    func handleHideShow(_ sender: UISwitch){
        print(2)
    }
    
    @objc
    func handleMemberList(){
        print(3)
    }
    
    @objc
    func handleAsset(){
        print(4)
    }
}


extension StaticTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.section][indexPath.row]
        switch indexPath.section {
        case 0:
            let cell = SwitchCell()
            cell.textLabel?.text = model.title
            cell.onSwitch.isOn = model.isOn ?? false
            switch indexPath.row {
            case 1:
                cell.onSwitch.addTarget(self, action: #selector(handleNotification(_:)), for: .valueChanged)
            case 2:
                cell.onSwitch.addTarget(self, action: #selector(handleHideShow(_:)), for: .valueChanged)
            default:
                print("not a valid row")
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = NormalCell()
            cell.textLabel?.text = model.title
            return cell
        default:
            print("not a valid section")
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("Switch cells are not clickable")
        case 1:
            switch indexPath.row {
            case 0:
                handleMemberList()
            case 1:
                handleAsset()
            default:
                print("not a valid row")
            }
        default:
            print("not a valid section")
        }
    }
}

class SwitchCell: UITableViewCell {
    private(set) var onSwitch = UISwitch()
    let iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        onSwitch.isUserInteractionEnabled = true
        contentView.addSubview(onSwitch)
        onSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onSwitch.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            onSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NormalCell: UITableViewCell {
    let iconImageView = UIImageView()
}

//
//  StaticTableViewWithEnum.swift
//  staticTableView
//
//  Created by Khawar Shah on 23.11.2022.
//

import UIKit


struct SettingCellVM {

    let title: String
    let imageName: String
    let isOn: Bool?
    let action: () -> ()

}

final class StaticTableViewWithEnum: UITableViewController {

    enum SettingSection: Int, CaseIterable {
        case navigationItems
        case settingToggles

        var items: [SettingCellVM] {
            switch self {
            case .settingToggles:
                return [
                    SettingCellVM(title: "Notification", imageName:  "", isOn: true, action: { print("notification toggled") }),
                    SettingCellVM(title: "Hide close", imageName:  "", isOn: false, action: { print("mute toggled") }),
                ]

            case .navigationItems:
                return [
                    SettingCellVM(title: "Member list", imageName:  "", isOn: nil, action: { print("member list thing tapped") }),
                    SettingCellVM(title: "Asset list", imageName:  "", isOn: nil, action: { print("asset list thing tapped") })
                ]
            }
        }
    }

}

extension StaticTableViewWithEnum {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingSection(rawValue: section)?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let section = SettingSection(rawValue: indexPath.section),
            section.items.count > indexPath.item
        else {
            print("not a valid section")
            return UITableViewCell()
        }

        switch section {
        case .settingToggles:
            let cell = SwitchCellTwo()
            cell.populate(section.items[indexPath.row])
            return cell

        case .navigationItems:
            let cell = NormalCellTwo()
            cell.textLabel?.text = section.items[indexPath.row].title
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard
            let section = SettingSection(rawValue: indexPath.section),
            section.items.count > indexPath.item
        else {
            print("not a valid section")
            return
        }

        switch section {
        case .navigationItems:
            section.items[indexPath.row].action()
        default: break
        }
    }
}

class SwitchCellTwo: UITableViewCell {

    private(set) var onSwitch = UISwitch()
    let iconImageView = UIImageView()

    private var model: SettingCellVM? = nil

    func populate(_ model: SettingCellVM) {
        self.model = model

        textLabel?.text = model.title
        iconImageView.image = UIImage(named: model.imageName)
        onSwitch.isOn = model.isOn ?? false
        onSwitch.addTarget(self, action: #selector(toggleAction), for: .valueChanged)
    }

    @objc private func toggleAction() {
        model?.action()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        onSwitch.isUserInteractionEnabled = true

        contentView.addSubview(onSwitch)
        onSwitch.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            onSwitch.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            onSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NormalCellTwo: UITableViewCell {

    let iconImageView = UIImageView()

}

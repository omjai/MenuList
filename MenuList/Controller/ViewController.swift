//
//  ViewController.swift
//  MenuList
//
//  Created by APPLE on 25/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIGestureRecognizerDelegate {

    var menuData: [MenuData] = []
    
    var previousIndex = -1
    var hiddenSections = Set<Int>()
    //to keep track of already expanded section
    var alreadyExpandedElement: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load menu json
        guard let menudata = loadJson(filename: "menu") else {
            return
        }
        menuData = menudata
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        menuData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !self.hiddenSections.contains(section) {
            return 0
        }
        
        return self.menuData[section].sub_category.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.nameLbl?.text = menuData[indexPath.section].sub_category[indexPath.row].name
        cell.displayNameLbl?.text = menuData[indexPath.section].sub_category[indexPath.row].display_name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionButton = UIButton()
        sectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        let width = menuData[section].name.widthOfString(usingFont: UIFont.systemFont(ofSize: 18))
        sectionButton.setTitle(menuData[section].name, for: .normal)
        sectionButton.setTitleColor(UIColor.black, for: .normal)
        sectionButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -self.view.frame.width/1.1 + width - 10, bottom: 0, right: 0)
        sectionButton.setImage(UIImage(named: "drop_20X20"), for: .normal)
        sectionButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -self.view.frame.width/1.2 - width)
        sectionButton.backgroundColor = .white
        sectionButton.tag = section
        sectionButton.addTarget(self, action: #selector(self.hideShowSection(sender:)), for: .touchUpInside)
        return sectionButton
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)

    }
    
    @objc private func hideShowSection(sender: UIButton) {
        let section = sender.tag
        if previousIndex != -1 {
            if previousIndex == section {
                sender.setImage(UIImage(named: "drop_20X20"), for: .normal)
                closeWithExpandSection(section: section)
                previousIndex = -1
                return
            }
            alreadyExpandedElement?.setImage(UIImage(named: "drop_20X20"), for: .normal)
            closeWithExpandSection(section: previousIndex)
            //now after closing that opened section insert new section rows
            //insert
            sender.setImage(UIImage(named: "up_20X20"), for: .normal)
            expandSection(section: section)
        } else {
            //insert
            alreadyExpandedElement = sender
            sender.setImage(UIImage(named: "up_20X20"), for: .normal)
            expandSection(section: section)
        }
    }
    
    func indexPathsForSection(section: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        for row in 0..<self.menuData[section].sub_category.count {
            indexPaths.append(IndexPath(row: row,section: section))
        }
        return indexPaths
    }
    
    func closeWithExpandSection(section: Int) {
        //if section is already expanded we need to close that section first
        self.hiddenSections.remove(previousIndex)
        self.tableView.deleteRows(at: indexPathsForSection(section: previousIndex),with: .fade)
    }
    
    func expandSection(section: Int){
        self.hiddenSections.insert(section)
        previousIndex = section
        //self.tableView.deleteRows(at: indexPathsForSection(),with: .fade)
        self.tableView.insertRows(at: indexPathsForSection(section: section),
        with: .fade)
    }
}


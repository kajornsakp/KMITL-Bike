//
//  MoreViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/11/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

enum MoreTableViewIndex : Int{
    case header = 0,info,button
}

class MoreViewController: BaseViewController {

    @IBOutlet weak var tableView : UITableView!
    var infoDetailList : [[String:String]]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerNib()
        self.setupTableView()
        self.setupInfoData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setupTitle(title: "More")
    }
    func registerNib(){
        self.tableView.register(UINib(nibName: MoreHeaderTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MoreHeaderTableViewCell.className)
        self.tableView.register(UINib(nibName : MoreInfoTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MoreInfoTableViewCell.className)
        self.tableView.register(UINib(nibName : MoreButtonTableViewCell.nibName,bundle: nil), forCellReuseIdentifier: MoreButtonTableViewCell.className)
    }
    func setupTableView(){
        self.tableView.estimatedRowHeight = 500
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    func setupInfoData(){
        let user = UserSession.sharedInstance.data
        let email = ["Email": user.email]
        let phoneno = ["Phone no.": user.phoneNumber]
        self.infoDetailList = []
        self.infoDetailList.append(email as! [String : String])
        self.infoDetailList.append(phoneno as! [String : String])
        self.tableView.reloadData()
    }
    
    func onAboutClick(){
        let vc = ViewControllerFactory.sharedInstance.resolve(service: CreditViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onLogoutClick(){
        UserSession.sharedInstance.clearUserSession()
        let vc = ViewControllerFactory.sharedInstance.resolve(service: LoginViewController.self)
        UIApplication.shared.keyWindow?.rootViewController = vc
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension MoreViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let index = MoreTableViewIndex(rawValue: section){
            switch index {
            case .header:
                return 1
            case .info:
                return self.infoDetailList.count
            case .button:
                return 2
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let index = MoreTableViewIndex(rawValue: indexPath.section){
            switch index {
            case .header:
                let cell = tableView.dequeueReusableCell(withIdentifier: MoreHeaderTableViewCell.className) as! MoreHeaderTableViewCell
                return cell
            case .info:
                let cell = tableView.dequeueReusableCell(withIdentifier: MoreInfoTableViewCell.className) as! MoreInfoTableViewCell
                cell.infoKeyValue = self.infoDetailList[indexPath.row]
                return cell
                
            case .button:
                let cell = tableView.dequeueReusableCell(withIdentifier: MoreButtonTableViewCell.className) as! MoreButtonTableViewCell
                cell.buttonType = indexPath.row == 0 ? ButtonType.about : ButtonType.logout
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = MoreTableViewIndex(rawValue: indexPath.section){
            switch index{
            case .button:
                if indexPath.row == 0 {
                    self.onAboutClick()
                }
                else{
                    self.onLogoutClick()
                }
                
            default:
                break
            }
        }
    }
}

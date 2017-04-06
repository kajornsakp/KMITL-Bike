//
//  CreditViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/14/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

struct CreditModel {
    var name : String
    var position : String
}

enum CreditTableViewIndex:Int{
    case people = 0 ,freepik
}
class CreditViewController: BaseViewController {
    
    @IBOutlet weak var tableView : UITableView!
    var peopleCredit : [CreditModel]! = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupTableView()
        registerNib()
        setupPeopleCredit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupTableView(){
        self.tableView.estimatedRowHeight = 500
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    func registerNib(){
        self.tableView.register(UINib(nibName: CreditPeopleTableViewCell.className,bundle: nil), forCellReuseIdentifier: CreditPeopleTableViewCell.className)
    }
    func setupPeopleCredit(){
        let array = ["Dr. Ronnachai Tiyarattanachai":"Adviser","Dr. Isara Anantavrasilp":"Adviser","Mr. Sasawat Chanate":"Coordinator","Mr. Chaiwat Wattanapaiboonsuk":"Database","Mr. Puriwat Khantiviriya":"Database","Mr. Boonnithi Jiaramaneepinit":"Hardware","Mr. Pavit Noinongyao":"Hardware","Ms. Chatchaya Chanchua":"Software (Android) & Database","Mr. Kajornsak Peerapathananont":"Software (iOS)"]
        self.peopleCredit = array.map{
            return CreditModel(name: $0, position: $1)
            }.sorted{
                return $0.position < $1.position
        }
        self.peopleCredit.append(CreditModel(name: "Freepik", position: "All icons used in KMITL Bike made by Freepik from www.flaticon.com"))
//        for i in array{
//            self.peopleCredit.append(CreditModel(name: i.key, position: i.value))
//        }
//        self.peopleCredit = self.peopleCredit.sorted{$0.position < $1.position}
        self.tableView.reloadData()
    }
    

}

extension CreditViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let index = CreditTableViewIndex(rawValue: section){
            switch index {
            case .people:
                return self.peopleCredit.count
            default:
                return 1
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let index = CreditTableViewIndex(rawValue: indexPath.section){
            switch index {
            case .people:
                let cell = tableView.dequeueReusableCell(withIdentifier: CreditPeopleTableViewCell.className) as! CreditPeopleTableViewCell
                cell.peopleCredit = self.peopleCredit[indexPath.row]
                return cell
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell(frame: CGRect.zero)
    }
}

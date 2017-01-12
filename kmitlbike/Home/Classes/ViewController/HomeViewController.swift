//
//  HomeViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 12/25/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    static let TAB_BAR_CONTROLLER_IDENTIFIER = "MainTabBarController"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setTabBar()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(UserSession.sharedInstance.data)
    }
    
    func setNavigationBar(){
        self.navigationController?.navigationItem.title = "Borrow bike"
    }
    func setTabBar(){
        self.tabBarController?.tabBarItem.title = "Borrow"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

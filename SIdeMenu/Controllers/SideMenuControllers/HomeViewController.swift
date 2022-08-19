//
//  HomeViewController.swift
//  IOSOMS
//
//  Created by Yugesh Marahatta on 19/08/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var profiles: [UIButton]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var allButton: [UIScrollView]!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    var profileItem = ["Profile","Settings","Log Out"]
    let cellReuseIdentifier = "cell"
    var toggleforStack = true
    override func viewDidLoad() {
        super.viewDidLoad()
        allButton.forEach({(Button) in
            Button.isHidden = true
            scrollView.layer.cornerRadius = 3
        })
        //show button
        sideMenuBtn.target = revealViewController()
                sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        print("Dashboard")
        print(ViewController.GlobalVariable.tokenValue)
    }

    @IBAction func profileBtn(_ sender: Any) {

        allButton.forEach({(Button) in
            Button.isHidden = !Button.isHidden
            scrollView.layer.cornerRadius = 3
        })
    }
    @IBAction func profile(_ sender: Any) {
    }
    
    @IBAction func setting(_ sender: Any) {
    }
    @IBAction func logout(_ sender: Any) {
    }
    
    
    
}


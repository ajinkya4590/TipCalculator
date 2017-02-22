//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Ajinkya Pawar on 2/22/17.
//  Copyright © 2017 Ajinkya Pawar. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var defaultTipSelector: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        defaultTipSelector.selectedSegmentIndex = defaults.integer(forKey: "tip_percentage")
    }

    @IBAction func setDefaultTipPercentage(_ sender: Any) {
        
        let defaultTipPercentage = defaultTipSelector.selectedSegmentIndex
        let defaults = UserDefaults.standard
        defaults.set(defaultTipPercentage, forKey: "tip_percentage")
        defaults.synchronize()
    }
}

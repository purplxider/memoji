//
//  MainViewController.swift
//  memoji
//
//  Created by CAU on 07/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.frame = UIScreen.main.bounds
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        backgroundImage.isUserInteractionEnabled = true
        backgroundImage.addGestureRecognizer(tapGestureRecognizer)
        
        backgroundImage.image = UIImage(named: "title.png")
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "navigationController") as! UINavigationController
        navigationController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(navigationController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

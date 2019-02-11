//
//  GameViewController.swift
//  memoji
//
//  Created by CAU on 07/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var gameToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.frame = UIScreen.main.bounds
        
        answerView.backgroundColor = UIColor(red: 208/255.0, green: 211/255.0, blue: 217/255.0, alpha: 1.0)
        
        navigationItem.title = "#1" // 수정
        
        backgroundImage.image = UIImage(named: "background.png")

        // Do any additional setup after loading the view.
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

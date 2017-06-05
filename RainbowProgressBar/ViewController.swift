//
//  ViewController.swift
//  RainbowProgressBar
//
//  Created by NguyenVuHuy on 6/5/17.
//  Copyright © 2017 hyubyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var progressView: RainbowProgressBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect.init(x: 0, y: 100, width: view.bounds.size.width, height: 10)
        progressView = RainbowProgressBar(frame: frame)
        view.backgroundColor = UIColor.white
        view.addSubview(progressView)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressView.startAnimating()
        simulateProgress()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func simulateProgress() {
        let delayTime = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: delayTime) { 
            let increment = (CGFloat)(arc4random() % 5) / 10.0 + 0.1;
            let progress = self.progressView.progress + 0.1
            print(progress)
            self.progressView.setProgress(value: progress)
            if progress < 1.0 {
                self.simulateProgress()
            } else {
                self.progressView.progress = 0
                self.simulateProgress()
            }
        }
        
    }

}


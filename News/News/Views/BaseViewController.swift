//
//  BaseViewController.swift
//  News
//
//  Created by PavanaKC on 01/02/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showToastLabel(message: String) {
        let textSize = message.getStringBoundingSize(boundingBox: CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude), font: UIFont.systemFont(ofSize: 20))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0))
        label.text = message
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = .red
        label.textColor = .white
        view.addSubview(label)
        
        UIView.animate(withDuration: 0.3) {
            let frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.x, width: label.frame.size.width, height: textSize.height)
            label.frame = frame
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            label.removeFromSuperview()
        }
    }
}

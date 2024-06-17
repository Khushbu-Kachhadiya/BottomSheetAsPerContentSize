//
//  StatusViewController.swift
//  bottomCard
//
//  Created by sagar on 07/04/23.
//  Copyright © 2023 fluffy. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {

    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    
    @IBOutlet weak var reactionListButton: UIButton!
    
    var currentSnapshotImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        addIconToActionButtons()
    }
    
    @IBAction func reactionListButtonTapped(_ sender: UIButton) {
        print("reaction list button tapped")
        guard let reactionVC = storyboard?.instantiateViewController(withIdentifier: "ReactionViewController")
                as? ReactionViewController else {
            assertionFailure("No view controller ID ReactionViewController in storyboard")
            return
        }
        
        
        // Delay the capture of snapshot by 0.1 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 , execute: {
            // take a snapshot of current view and set it as backingImage
            // reactionVC.backingImage = self.view.asImage() // Without tabbar
//            reactionVC.backingImage = self.tabBarController?.view.asImage() // With tabbar
         
            reactionVC.modalPresentationStyle = .overCurrentContext
            
            // present the view controller modally without animation
            self.present(reactionVC, animated: false, completion: nil)
        })
    }
    
    private func addIconToActionButtons() {
        let labels = [likeLabel, commentLabel, shareLabel]
        let texts = ["Like", "Comment", "Share"]
        // Image assets name used for the icons
        let iconNames = ["Like", "Comment", "Share"]
        
        for (label,(text, iconName)) in zip(labels, zip(texts, iconNames)) {
            let iconAttachment = NSTextAttachment()
            iconAttachment.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
            let iconOffsetY : CGFloat = -2.0;
            iconAttachment.bounds = CGRect(x: -4, y: iconOffsetY, width: 16.0, height: 16.0)
            
            let attachmentString = NSAttributedString(attachment: iconAttachment)
            // iOS bug, must use an empty space string before appending icon attachment
            // else the tint color won't work
            let labelText = NSMutableAttributedString(string: " ")
            labelText.append(attachmentString)
            labelText.append(NSMutableAttributedString(string: text))
            
            label?.textAlignment = .center
            label?.attributedText = labelText
            label?.tintColor = UIColor(named: "ActionButtonGray")
        }
    }
}

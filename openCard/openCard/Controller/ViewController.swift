//
//  ViewController.swift
//  openCard
//
//  Created by Joey Liu on 6/2/20.
//  Copyright © 2020 Joey Liu. All rights reserved.
//

import UIKit

enum FourColor: Int {
    case green = 1
    case red
    case blue
    case gray
}

class ViewController: UIViewController {
    
    @IBOutlet weak var auraSurroundCard: UIImageView!
    @IBOutlet weak var borderImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var cardBackImageView: UIImageView!
    
    let viewManager = ViewManager()
    var gleamView = UIView()
    var gleamImageView = UIImageView()
    
    var longView = UIView()
    var backgroundColorIMV = [UIImageView]()
    var backgroundAV = UIImageView()
    var monsterImageView = [UIImageView]()
    let whiteBorder = UIImageView()
    
    var width:CGFloat = 0
    var height:CGFloat = 0
    var originY:CGFloat = 0
    var originX:CGFloat = 0
    
    var numbers = [Int]()
    var colors:[FourColor] = [.green, .red, .blue, .gray]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        borderImageView.blink()
        
        viewManager.insertAnimationToImageView(imageView: auraSurroundCard, duration: 2.3) { () -> ([UIImage]) in
            let images = self.viewManager.makeAnimatedImages(imageName: "img-aura-gray-", amount: 30)
            return images
        }
        auraSurroundCard.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        width = self.cardBackImageView.frame.size.width
        height = self.cardBackImageView.frame.size.height
        originY = self.cardBackImageView.frame.origin.y
        originX = self.cardBackImageView.frame.origin.x
        
        numbers.makeRandomNumbers(start: 1, end: 36)
       
        longView = viewManager.makeLongContainerView(width: width, height: height, originX: originX, originY: originY, numbers: numbers)
        backgroundColorIMV = viewManager.makeBackground(width: width, height: height, originX: originX, originY: originY, colors: colors, numbers: numbers, monsterIsTrue: false)
        viewManager.makeAnimation(colors: colors, width: width, height: height, animationView: backgroundAV)
        monsterImageView = viewManager.makeMonsterView(width: width, height: height, numbers: numbers)
        
        whiteBorder.image = UIImage(named: "img-card-bg-blank")
        whiteBorder.frame = CGRect(x: originX, y: originY, width: width, height: height)
    }
    
    @IBAction func clickedButton(_ sender: UIButton) {
        borderImageView.isHidden.toggle()
        auraSurroundCard.isHidden.toggle()
        cardBackImageView.isHidden.toggle()
        
        resetEverything()
        numbers.shuffle()
        colors.shuffle()
        
        self.putImageViewsTogether(longView: longView, backgroundColorIMV: backgroundColorIMV, backgroundAV: backgroundAV, monsterImageView: monsterImageView)
        
        //When button is clicked
        if sender.titleLabel?.text == "open"{
            sender.isUserInteractionEnabled = false
            self.longView.isHidden = false
            makeMask()
            
            view.addSubview(longView)
            view.addSubview(gleamView)
            view.addSubview(whiteBorder)

            gleamView.openCardAnimation(imageView: nil)
            self.longView.frame.origin.x += self.width * 1
            whiteBorder.isHidden = false
            sender.setTitle("hide", for: .normal)
            UIView.animate(withDuration: 3, delay: 0.65, options: [.curveEaseInOut], animations: {
                self.longView.frame.origin.x -= self.width * 36
                print("#1: \(self.longView.frame)")
            }, completion: { finised in
                self.gleamView.openCardAnimation(duration: 0.5, delay: 0, alpha: 1, imageView: self.backgroundAV)
                self.whiteBorder.isHidden.toggle()
                sender.isUserInteractionEnabled = true
            })
        } else {
            self.longView.frame.origin.x += self.width * 35
            self.longView.isHidden.toggle()
            view.mask = nil
            self.backgroundAV.stopAnimating()
            self.gleamImageView.image = nil
            self.gleamView.alpha = 0
            
            for view in self.longView.subviews {
                view.removeFromSuperview()
            }
            
            sender.setTitle("open", for: .normal)
        }
    }
}



extension ViewController {
    //MARK: set up image
    fileprivate func setupView() {
        gleamView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(gleamView)
        gleamView.alpha = 0
        
        NSLayoutConstraint.activate(
            [
                gleamView.centerYAnchor.constraint(equalTo: cardBackImageView.centerYAnchor),
                gleamView.centerXAnchor.constraint(equalTo: cardBackImageView.centerXAnchor),
                gleamView.widthAnchor.constraint(equalToConstant: 138 * 1.2),
                gleamView.heightAnchor.constraint(equalToConstant: 168 * 1.2)
            ]
        )
        
        gleamImageView.image = UIImage(named: "img-card-shime")
        gleamImageView.translatesAutoresizingMaskIntoConstraints = false
        gleamImageView.contentMode = .scaleAspectFill
        gleamView.addSubview(gleamImageView)
        
        NSLayoutConstraint.activate(
            [
                gleamImageView.centerYAnchor.constraint(equalTo: cardBackImageView.centerYAnchor),
                gleamImageView.centerXAnchor.constraint(equalTo: cardBackImageView.centerXAnchor),
                gleamImageView.widthAnchor.constraint(equalToConstant: 138),
                gleamImageView.heightAnchor.constraint(equalToConstant: 168)
            ]
        )
    }
    //MARK: -Create a mask for view
    
    fileprivate func makeMask() {
        //containerView
        let maskView = UIView()
        view.addSubview(maskView)
        maskView.backgroundColor = .black
        maskView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                maskView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                maskView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                maskView.widthAnchor.constraint(equalTo: view.widthAnchor),
                maskView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ]
        )
        
        let cardUncensoredView = UIView()
        maskView.addSubview(cardUncensoredView)
        cardUncensoredView.backgroundColor = .black
        cardUncensoredView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                cardUncensoredView.centerXAnchor.constraint(equalTo: self.cardBackImageView.centerXAnchor),
                cardUncensoredView.centerYAnchor.constraint(equalTo: self.cardBackImageView.centerYAnchor),
                cardUncensoredView.heightAnchor.constraint(equalTo: self.cardBackImageView.heightAnchor),
                cardUncensoredView.widthAnchor.constraint(equalTo: self.cardBackImageView.widthAnchor),
            ]
        )
        
        let buttonUncensoredView = UIView()
        maskView.addSubview(buttonUncensoredView)
        buttonUncensoredView.backgroundColor = .black
        buttonUncensoredView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                buttonUncensoredView.centerXAnchor.constraint(equalTo: self.button.centerXAnchor),
                buttonUncensoredView.centerYAnchor.constraint(equalTo: self.button.centerYAnchor),
                buttonUncensoredView.heightAnchor.constraint(equalTo: self.button.heightAnchor),
                buttonUncensoredView.widthAnchor.constraint(equalTo: self.button.widthAnchor),
            ]
        )
        
        self.view.mask = maskView
    }
    
    //MARK: -Reset Everything
    
    fileprivate func resetEverything() {
        self.gleamImageView.image = UIImage(named: "img-card-shime")
        self.gleamView.alpha = 0
    }
    
    //Insert animation to ImageView
    fileprivate func insertAnimationToImageView(imageView: UIImageView,duration: Double, animation: @escaping () -> ([UIImage])){
        let images:[UIImage] = animation()
        imageView.animationImages = images
        imageView.animationDuration = duration
    }
    
    //拼裝[ImageView]進去long container view
    fileprivate func putImageViewsTogether(longView: UIView,backgroundColorIMV: [UIImageView],backgroundAV:UIImageView,monsterImageView:[UIImageView]) {
        for i in 1...36 {
            longView.addSubview(backgroundColorIMV[i - 1])
            
            if i == 36 {
                backgroundColorIMV[i - 1].addSubview(backgroundAV)
                backgroundAV.addSubview(monsterImageView[i - 1])
            } else {
            backgroundColorIMV[i - 1].addSubview(monsterImageView[i - 1])
            }
        }
    }
}

//
//  ViewManager.swift
//  openCard
//
//  Created by Joey Liu on 6/4/20.
//  Copyright © 2020 Joey Liu. All rights reserved.
//

import UIKit

class ViewManager: UIView {
    
    //    var monsterView = UIView()
    
    //MARK: Make animated images
    func makeAnimatedImages(imageName: String, amount: Int) -> [UIImage] {
        
        var images = [UIImage]()
        
        for i in 1...amount{
            images.append(UIImage(named: "\(imageName)\(i)")!)
        }
        
        return images
    }
    
    //MARK: Insert animation to ImageView
    func insertAnimationToImageView(imageView: UIImageView, duration: Double, animation: @escaping () -> ([UIImage])){
        let images:[UIImage] = animation()
        imageView.animationImages = images
        imageView.animationDuration = duration
    }
    
    //長條裝載View的東西
    func makeLongContainerView(width: CGFloat, height: CGFloat, originX x: CGFloat, originY y: CGFloat, numbers: [Int]) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: x, y: y, width: width * 36, height: height)
        return view
    }
    
    //裝載背景圖片
    func makeBackground(width: CGFloat, height: CGFloat, originX x: CGFloat, originY y: CGFloat, colors: [FourColor], numbers: [Int],monsterIsTrue: Bool) -> [UIImageView] {
        var imageViews = [UIImageView]()
        
        for i in 1 ... 36 {
            let imageView = UIImageView()
            
            let chooseColor: Int = i % 4
            
            let xPosition = 0 + width * CGFloat((i - 1))
            
            if monsterIsTrue {
                let monsterImageView = UIImageView()
                let xPosition = 0 + width * CGFloat((i - 1))
                monsterImageView.frame = CGRect(x: xPosition, y: y, width: width, height: height)
                
                monsterImageView.image = UIImage(named: "monster-\(numbers[i - 1])")
                
                imageViews.append(monsterImageView)
            } else {
                switch colors[chooseColor] {
                case.blue:
                    imageView.image = UIImage(named: "img-card-bg-blue")
                    
                case.red:
                    imageView.image = UIImage(named: "img-card-bg-red")
                case.green:
                    imageView.image = UIImage(named: "img-card-bg-green")
                case.gray:
                    imageView.image = UIImage(named: "img-card-bg-gray")
                }
            }
            
            imageView.frame = CGRect(x: xPosition, y: 0, width: width, height: height)
            
            imageViews.append(imageView)
        }
        
        return imageViews
    }
    
    //裝載背景動畫
    func makeAnimation(colors: [FourColor], width: CGFloat, height: CGFloat, animationView: UIImageView){
//        let animationView = UIImageView()
        animationView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        let chooseColor: Int = 36 % 4
        var colorString: String = ""
        switch colors[chooseColor] {
        case.blue:
            colorString = "blue"
        case.red:
            colorString = "red"
        case.green:
            colorString = "green"
        case.gray:
            colorString = "gray"
        }
        
        animationView.animationImages = self.makeAnimatedImages(imageName: "img-aura-\(colorString)-", amount: 30)
        animationView.animationDuration = 2.3
        
    }
    
    //怪物ImageView
    
    func makeMonsterView(width: CGFloat, height: CGFloat,numbers: [Int]) -> [UIImageView]{
        
        var imageViews:[UIImageView] = []
        
        for i in 1 ... 36 {
            let monsterImageView = UIImageView()
            monsterImageView.frame = CGRect(x: 0, y: 0, width: width * 0.85, height: height * 0.85)
            
            monsterImageView.image = UIImage(named: "monster-\(numbers[i - 1])")
            
            imageViews.append(monsterImageView)
        }
        
        return imageViews
    }
}

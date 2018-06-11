//
//  ViewController.swift
//  WaterfallFlowLayoutDemo
//
//  Created by heyuze on 2018/6/11.
//  Copyright © 2018 heyuze. All rights reserved.
//

import UIKit

func RandomColor() -> UIColor {
  return UIColor(red: CGFloat(arc4random() % 256) / 255, green: CGFloat(arc4random() % 256) / 255, blue: CGFloat(arc4random() % 256) / 255, alpha: 1)
}

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let waterfallFlowLayout = WaterfallFlowLayout()
    waterfallFlowLayout.delegate = self
    let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: waterfallFlowLayout)
    collectionView.dataSource = self
    collectionView.backgroundColor = .white
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    
    view.addSubview(collectionView)
  }
}

// MARK: - WaterfallFlowLayoutDelegate
extension ViewController: WaterfallFlowLayoutDelegate {
  
  func waterfallFlowLayout(_ layout: WaterfallFlowLayout, heightForItemAtIndexPath indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat {
    return CGFloat(arc4random_uniform(200) + 100)
  }
  
  func columnCountInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> Int {
    return 3
  }
  
  func columnSpacingInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> CGFloat {
    return 15
  }
  
  func rowSpacingInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> CGFloat {
    return 15
  }
  
  func edgeInsetsInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> UIEdgeInsets {
    return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
  }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = RandomColor()
    return cell
  }
}

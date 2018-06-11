//
//  WaterfallFlowLayout.swift
//  WaterfallFlowLayout
//
//  Created by heyuze on 2018/4/13.
//  Copyright © 2018 heyuze. All rights reserved.
//

import UIKit

private let defaultColumnCount = 2
private let defaultColumnSpacing: CGFloat = 15
private let defaultRowSpacing: CGFloat = 15
private let defaultEdgeInsets = UIEdgeInsets.zero

protocol WaterfallFlowLayoutDelegate: class {
  
  func waterfallFlowLayout(_ layout: WaterfallFlowLayout, heightForItemAtIndexPath indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat
  func columnCountInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> Int
  func columnSpacingInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> CGFloat
  func rowSpacingInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> CGFloat
  func edgeInsetsInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> UIEdgeInsets
}

extension WaterfallFlowLayoutDelegate {
  
  func columnCountInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> Int { return defaultColumnCount }
  func columnSpacingInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> CGFloat { return defaultColumnSpacing }
  func rowSpacingInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> CGFloat { return defaultRowSpacing }
  func edgeInsetsInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> UIEdgeInsets { return defaultEdgeInsets }
}

class WaterfallFlowLayout: UICollectionViewLayout {
  
  weak var delegate: WaterfallFlowLayoutDelegate?
  
  private var contentHeight: CGFloat = 0
  private var columnHeights: [CGFloat] = [CGFloat]()
  private var attributesArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
  
  private var columnCount: Int {
    return delegate?.columnCountInWaterfallFlowLayout(self) ?? defaultColumnCount
  }
  
  private var columnSpacing: CGFloat {
    return delegate?.columnSpacingInWaterfallFlowLayout(self) ?? defaultColumnSpacing
  }
  
  private var rowSpacing: CGFloat {
    return delegate?.rowSpacingInWaterfallFlowLayout(self) ?? defaultRowSpacing
  }
  
  private var edgeInsets: UIEdgeInsets {
    return delegate?.edgeInsetsInWaterfallFlowLayout(self) ?? defaultEdgeInsets
  }
  
  override func prepare() {
    super.prepare()
    
    contentHeight = 0
    columnHeights.removeAll()
    
    for _ in 0..<columnCount {
      columnHeights.append(edgeInsets.top)
    }
    
    attributesArray.removeAll()
    let count = collectionView?.numberOfItems(inSection: 0) ?? 0
    for i in 0..<count {
      let indexPath = IndexPath(item: i, section: 0)
      let attrs = layoutAttributesForItem(at: indexPath) ?? UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributesArray.append(attrs)
    }
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
    let collectionWidth = collectionView?.frame.size.width ?? 0
    let itemWidth = (collectionWidth - edgeInsets.left - edgeInsets.right - CGFloat(columnCount - 1) * columnSpacing) / CGFloat(columnCount)
    let itemHeight = delegate?.waterfallFlowLayout(self, heightForItemAtIndexPath: indexPath, itemWidth: itemWidth) ?? 0.0
    
    var destColumn = 0
    var minColumnHeight = columnHeights[0]
    for i in 1..<columnCount {
      let columnHeight = columnHeights[i]
      if minColumnHeight > columnHeight {
        minColumnHeight = columnHeight
        destColumn = i
      }
    }
    
    let itemX = edgeInsets.left + CGFloat(destColumn) * (itemWidth + columnSpacing)
    var itemY = minColumnHeight
    if itemY != edgeInsets.top {
      itemY += rowSpacing
    }
    attrs.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: itemHeight)
    columnHeights[destColumn] = attrs.frame.maxY
    
    let maxColumnHeight = columnHeights[destColumn]
    if contentHeight < maxColumnHeight {
      contentHeight = maxColumnHeight
    }
    
    return attrs
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return attributesArray
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: 0, height: contentHeight + edgeInsets.bottom)
  }
}

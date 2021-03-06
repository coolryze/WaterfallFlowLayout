## WaterfallFlowLayout

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/coolryze/YZPlayer/master/LICENSE)&nbsp;
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)](https://www.apple.com/nl/ios/)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;

![demo](https://github.com/coolryze/WaterfallFlowLayout/blob/master/WaterfallFlowLayoutDemo/demo.png?raw=true)

## Requirements
This library requires `iOS 7.0+`, `Swift 4` and `Xcode 9.0+`.

## Usage

1. Init WaterfallFlowLayout && set delegate.

```swift
let waterfallFlowLayout = WaterfallFlowLayout()
waterfallFlowLayout.delegate = self
let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: waterfallFlowLayout)
```

2. Implements WaterfallFlowLayoutDelegate.

```swift
func waterfallFlowLayout(_ layout: WaterfallFlowLayout, heightForItemAtIndexPath indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat
func columnCountInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> Int
func columnSpacingInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> CGFloat
func rowSpacingInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> CGFloat
func edgeInsetsInWaterfallFlowLayout(_ layout: WaterfallFlowLayout) -> UIEdgeInsets
```

## Installation
Add the source file 'WaterfallFlowLayout' to your Xcode project.

## License
WaterfallFlowLayout is provided under the MIT license. See LICENSE file for details.
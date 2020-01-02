//
//  SectionedCollectionViewDataSource.swift
//  Core
//
//  Created by Rafael Ferreira on 1/2/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

import UIKit

final class SectionedCollectionViewDataSource: DataSource<UICollectionViewDataSource>, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return get(at: section).collectionView(collectionView, numberOfItemsInSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dataSource = get(at: indexPath.section)
        let indexPath = IndexPath(row: indexPath.row, section: 0)

        return dataSource.collectionView(collectionView, cellForItemAt: indexPath)
    }
}

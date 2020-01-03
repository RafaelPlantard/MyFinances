//
//  SectionedCollectionViewDataSource.swift
//  Core
//
//  Created by Rafael Ferreira on 1/2/20.
//  Copyright © 2020 Swift Yah. All rights reserved.
//

import UIKit

public final class SectionedCollectionViewDataSource<Section, SectionCell>: DataSource<Section>,
    UICollectionViewDataSource where SectionCell: UICollectionReusableView {
    public typealias SectionTitleConfigurator = (Section, SectionCell) -> Void

    // MARK: Private constants

    private let sectionTitleConfigurator: SectionTitleConfigurator
    private let dataSources: DataSource<UICollectionViewDataSource>

    // MARK: Initializers

    public init(sections: [UICollectionViewDataSource], sectionTitles: [Section],
                sectionConfigurator: @escaping SectionTitleConfigurator) {
        self.sectionTitleConfigurator = sectionConfigurator
        self.dataSources = DataSource(models: sections)
        super.init(models: sectionTitles)
    }

    // MARK: UICollectionViewDataSource conforms

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSources.get(at: section).collectionView(collectionView, numberOfItemsInSection: section)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dataSource = dataSources.get(at: indexPath.section)
        let indexPath = IndexPath(row: indexPath.row, section: 0)

        return dataSource.collectionView(collectionView, cellForItemAt: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        let genericView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier: SectionCell.className, for: indexPath
        )

        guard let supplementaryView = genericView as? SectionCell else {
            return genericView
        }

        let title = get(at: indexPath.section)

        sectionTitleConfigurator(title, supplementaryView)

        return supplementaryView
    }
}

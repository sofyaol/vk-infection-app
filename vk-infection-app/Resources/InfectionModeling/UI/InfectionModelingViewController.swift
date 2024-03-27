//
//  GroupModelingViewController.swift
//  vk-infection-app
//
//  Created by Sofya Olekhnovich on 26.03.2024.
//

import UIKit

class InfectionModelingViewController: UIViewController {
    
    var viewModel: InfectionModelingViewModel
    
    // MARK: - UI elements
    
    lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: getCollectionFlowLayout())
        collectionView.backgroundColor = .lightGray
        collectionView.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: - Inits
    
    init(viewModel: InfectionModelingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcs

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupUI()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.launchTimerForRecalculation()
    }
    
    private func getCollectionFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        let itemWidth = (UIScreen.main.bounds.width / CGFloat(viewModel.columnsNumber)) - layout.minimumInteritemSpacing
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        return layout
    }
    
    private func setupUI() {
        view.backgroundColor = .lightGray
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        collectionView.frame = view.safeAreaLayoutGuide.layoutFrame
    }
}

// MARK: - CollectionView extension

extension InfectionModelingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        viewModel.infect(index: indexPath.item)
        if let cell = collectionView.cellForItem(at: indexPath) as? PersonCollectionViewCell {
            cell.infect()
        }
    }
}

extension InfectionModelingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.infectionModel.groupSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.reuseIdentifier, for: indexPath) as? PersonCollectionViewCell {
            cell.setup(isInfected: viewModel.isInfected(index: indexPath.item))
            return cell
        }
        return UICollectionViewCell()
    }
}

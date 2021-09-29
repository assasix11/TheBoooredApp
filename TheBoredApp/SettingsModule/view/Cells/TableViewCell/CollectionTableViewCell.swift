//
//  CollectionTableViewCell.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 26.09.2021.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    var types = ["all","education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"]
    var chosenTypes =  Array<String>()
    var typesCount = 6
    var arrayOfCellsNumbers = Array<Int>()
    var presenter: SettingsPresenterProtocol!
    @IBOutlet weak var buttonMoreLess: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = TagsLayout()
        buttonMoreLess.clipsToBounds = true
        buttonMoreLess.layer.cornerRadius = 22
        buttonMoreLess.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        buttonMoreLess.backgroundColor = .darkGray
        buttonMoreLess.setTitleColor(.white, for: .normal)

    }

    @IBAction func MoreLessButtonActon(_ sender: UIButton) {
        if typesCount == 6 {
            typesCount = types.count
            buttonMoreLess.setTitle("меньше", for: .normal)
            collectionView.reloadData()
            collectionView.layoutIfNeeded()
            updateTableView()
        } else {
            typesCount = 6
            buttonMoreLess.setTitle("еще", for: .normal)
            collectionView.reloadData()
            collectionView.layoutIfNeeded()
            updateTableView()
        }
    }
    
    func updateTableView() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !arrayOfCellsNumbers.contains(indexPath.item) {
            arrayOfCellsNumbers.append(indexPath.item)
            presenter.chosenTypes?.append(types[indexPath.item])
            chosenTypes.append(types[indexPath.item])
            presenter.chosenTypes = chosenTypes
            collectionView.reloadData()
        } else if arrayOfCellsNumbers.contains(indexPath.item) {
            arrayOfCellsNumbers = arrayOfCellsNumbers.filter { $0 != indexPath.item }
            chosenTypes = chosenTypes.filter { $0 != types[indexPath.item] }
            presenter.chosenTypes = chosenTypes
            collectionView.reloadData()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if arrayOfCellsNumbers.contains(indexPath.item) {
            arrayOfCellsNumbers = arrayOfCellsNumbers.filter { $0 != indexPath.item }
            presenter.chosenTypes? = (presenter.chosenTypes?.filter { $0 != types[indexPath.item] })!
            presenter.chosenTypes = chosenTypes
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.label.text = types[indexPath.item]
        cell.label.textColor = .white
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 22
        cell.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        if arrayOfCellsNumbers.contains(indexPath.item) {
            cell.viewOnCell.backgroundColor = .red
         }
         else {
            cell.viewOnCell.backgroundColor = .darkGray
         }
        return cell
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        collectionView.layoutIfNeeded()
                collectionView.frame = CGRect(x: 0, y: 0, width: targetSize.width , height: 1)
        return CGSize(width: collectionView.collectionViewLayout.collectionViewContentSize.width, height: collectionView.collectionViewLayout.collectionViewContentSize.height + 124)
    }
}

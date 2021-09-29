//
//  DataBaseViewController.swift
//  TheBoredApp
//
//  Created by Дмитрий Зубарев on 29.09.2021.
//

import UIKit
import RealmSwift

class DataBaseViewController: UIViewController {
    var activityStruct = [AtcivityModel]()
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: DataBasePresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetch()
        activityStruct = presenter.activityStruct
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DataBaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DataBaseCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width , height: collectionView.bounds.height/2)
        collectionView.collectionViewLayout = layout

    }

}

extension DataBaseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        activityStruct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataBaseCollectionViewCell", for: indexPath) as! DataBaseCollectionViewCell
        cell.type.backgroundColor = .red
        cell.type.textColor = .white
        cell.type.clipsToBounds = true
        cell.type.layer.cornerRadius = 20
        cell.type.layer.maskedCorners =  [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        if  activityStruct.count > 0 {
            cell.price.text = String(activityStruct[indexPath.item].price ?? 0)
            cell.activity.text = activityStruct[indexPath.item].activity ?? "Не заполнено"
            cell.type.text = activityStruct[indexPath.item].type ?? "Не заполнено"
            cell.participants.text = String(activityStruct[indexPath.item].participants ?? 0)
        }
        return cell
    }
}

//
//  JsonPlaceHolderViewController.swift
//  CleanTableView
//
//  Created by Canberk Bibican on 26.09.2021.
//

import UIKit

class JsonPlaceHolderViewController: UIViewController {

    @IBOutlet weak var tableViewJsonPlaceHolder: UITableView!

    private let jsonTableView: JsonTableView = JsonTableView()
    private let jsonService: IJsonPlaceHolderProtocol = JsonPlaceHolderService()

    override func viewDidLoad() {
        super.viewDidLoad()

        initDelegate()
        initService()
    }

    private func initDelegate() {
        tableViewJsonPlaceHolder.delegate = jsonTableView
        tableViewJsonPlaceHolder.dataSource = jsonTableView
        jsonTableView.delegate = self
    }

    private func initService() {
        // weak self lifecycle da hata yaratmaması için sayfa ölünce silinecek.
        jsonService.fectAllPosts { [weak self] (postModelList) in
            self?.jsonTableView.update(newItemList: postModelList)
            self?.tableViewJsonPlaceHolder.reloadData()
        } onFail: { (data) in
            print(data ?? "")
        }

    }
}

extension JsonPlaceHolderViewController: JsonTableViewOutput {
    func onSelected(item: PostModel) {
        print(item.body ?? "")
    }
}

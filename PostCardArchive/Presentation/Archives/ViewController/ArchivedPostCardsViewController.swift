//
//  ArchivedPostCardsViewController.swift
//  PostCardArchive
//
//  Created by Omar Ali on 25/03/2021.
//

import UIKit

class ArchivedPostCardsViewController: ViewController<ArchivedPostCardsViewModel> {

    private let cellId = "Cell"
    @IBOutlet private  var tableView: UITableView! {
        didSet {
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(UINib(nibName: "ArchivedPostCardCell", bundle: nil), forCellReuseIdentifier: cellId)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(actionOfFilterButton))
    }
    
    override func setAdditionalClosures() {
        viewModel.filteredPostCardsDidChange = {
            [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func didClickOnPostCard(at index: Int) {
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let viewCardAction = UIAlertAction(title: "View", style: .default, handler: {
            [weak self] _ in
            self?.viewModel.loadCard(at: index)
        })
        
        let syncCardAction = UIAlertAction(title: "Sync", style: .default, handler: {
            [weak self] _ in
            self?.viewModel.syncCard(at: index)
        })
        
        let deleteCardAction = UIAlertAction(title: "delete", style: .destructive, handler: {
            [weak self] _ in
            self?.viewModel.deleteCard(at: index)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(viewCardAction)
        if index % 3 == 0 {
            alertController.addAction(syncCardAction)
        }
        alertController.addAction(deleteCardAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func actionOfFilterButton() {
        let alertController = UIAlertController(title: "Filter by", message: nil, preferredStyle: .actionSheet)
        
        let regularAction = UIAlertAction(title: "Regular", style: .default, handler: {
            [weak self] _ in
            self?.viewModel.filterCards(type: .regular)
        })
        
        let foldableAction = UIAlertAction(title: "Foldable", style: .default, handler: {
            [weak self] _ in
            self?.viewModel.filterCards(type: .foldable)
        })
        
        let allAction = UIAlertAction(title: "All", style: .default, handler: {
            [weak self] _ in
            self?.viewModel.filterCards(type: nil)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(regularAction)
        alertController.addAction(foldableAction)
        alertController.addAction(allAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

extension ArchivedPostCardsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredPostCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: cellId) as! ArchivedPostCardCell
        cell.postCard = viewModel.filteredPostCards[indexPath.row]
        return cell
    }
    
}

extension ArchivedPostCardsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didClickOnPostCard(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

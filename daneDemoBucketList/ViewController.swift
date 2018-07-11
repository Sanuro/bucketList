//
//  ViewController.swift
//  daneDemoBucketList
//
//  Created by Jaewon Lee on 7/10/18.
//  Copyright © 2018 Jaewon Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addEditModal",  sender: sender)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        if let indexPath = sender as? IndexPath{
            let text = list[indexPath.row]
            let nav = segue.destination as! UINavigationController
            let dest = nav.topViewController as! AddEditVC
            dest.item = text
            dest.indexPath = indexPath
        }
        else{
            print("ADD BUTTON")
        }
    }
    @IBAction func unwindFromAddEditVC(segue: UIStoryboardSegue){
        
        let src = segue.source as! AddEditVC
        let text = src.addEditTextField.text!
        if let indexPath = src.indexPath{
            list[indexPath.row] = text
        }else{
            list.append(text)
        }
        tableView.reloadData()
        
    }
    
    var list: [String] = ["hello", "Dane", "Sruthi", "John"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemList", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {action, view, completionHandler in
            self.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(false)
//            tableView.reloadData()
        }
        
        
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfig
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: . normal, title: "Edit"){action, view, completionHandler in
            self.performSegue(withIdentifier: "addEditModal", sender: indexPath)
            completionHandler(false)
            
        
    }
        
        editAction.backgroundColor = UIColor.purple
        let swipeConfig = UISwipeActionsConfiguration(actions: [editAction])
        return swipeConfig
}
}

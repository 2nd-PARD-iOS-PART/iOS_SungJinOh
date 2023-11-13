import UIKit

class SearchCollectionTableController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .black
        tableView.separatorColor = .gray
        
        // Register a custom cell if needed
        // tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // You can have multiple sections if needed.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // You can adjust the number of rows as needed.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath)
        cell.textLabel?.text = "Search Result \(indexPath.row + 1)"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        return cell
    }
}


import UIKit

class ViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate ,UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    var filterArray:[String]?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return (filterArray?.count)!
        }else{
            return Constants.countries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.textLabel?.text = filterArray?[indexPath.row]
        }else{
            cell.textLabel?.text = Constants.countries[indexPath.row]
        }
        return cell
    }

    func updateSearchResults(for searchController: UISearchController) {
        self.filterArray = Constants.countries.filter(){
            $0.range(of: searchController.searchBar.text!) != nil
            //$0.contains(searchController.searchBar.text!)
        }
        self.tableView.reloadData()
    }
    
}


extension ViewController :UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

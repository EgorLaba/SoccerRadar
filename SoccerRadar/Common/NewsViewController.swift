
import UIKit

class NewsViewController: UIViewController {
    
    var model: [News] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self 
        
        self.jsonPars()
        
    }
    
    private func jsonPars() {
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?apiKey=824f5258ca0541fa824da8bd1417eba4&category=sports") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(Response.self, from: data)
                        self.model = response.articles
                        DispatchQueue.main.async {
                          self.tableView.reloadData()
                        }

                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        cell.titleLabel?.text = model[indexPath.row].title
        cell.sourceLabel?.text = model[indexPath.row].source.name
        cell.dateLabel?.text = model[indexPath.row].publishedAt
        return cell
    }
    
    
}


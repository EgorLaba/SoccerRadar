
import UIKit

class NewsViewController: UIViewController {
    
    // MARK: - Variables
    
    var model: [News] = []
    var nameController = "News"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = nameController
        
        tableView.dataSource = self
        tableView.delegate = self 
        
        self.jsonPars()
        
    }
    
    // MARK: - Private
    
    private func jsonPars() {
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?apiKey=824f5258ca0541fa824da8bd1417eba4&category=sports") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let response = try decoder.decode(Response.self, from: data)
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

// MARK: - UITableViewDelegate/UITableViewDataSource

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
        if let publishedAt = model[indexPath.row].publishedAt {
            cell.dateLabel?.text = DateUtils.formattedDate(date: publishedAt, format: DateUtils.fullDateFormat)
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let path = self.model[indexPath.row].urlToImage, let url = URL(string: path) {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.iconImageView.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        let detailVC = DetailVC.create(news: model[indexPath.row], image: currentCell.iconImageView.image)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


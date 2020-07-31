import UIKit

class DetailVC: UIViewController {
    
    // MARK: - Variables
    
    private var news: News!
    private var image: UIImage?
    
    // MARK: - Outlets
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    // MARK: - Static
    
    static func create(news: News, image: UIImage?) -> DetailVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailVC") as! DetailVC
        detailVC.news = news
        detailVC.image = image
        
        return detailVC
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentLabel.text = news.content
        self.newsImageView.image = self.image
    }
}

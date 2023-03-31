import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fileSystem();
        let image = self.loadImageFromDocumentDirectory();
        let imageView = UIImageView();
        
        view.addSubview(imageView);
        imageView.image = image;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true;
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
    }
    
    private func fileSystem() {
        let DocumentDirectory: NSURL = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let dir: URL? = DocumentDirectory.appendingPathComponent("FOLDER_NAME")
        let manager: FileManager = FileManager.default;
        
        do {
            try manager.createDirectory(atPath: dir!.path, withIntermediateDirectories: true, attributes: nil);
            let image: String = "https://www.easylinedrawing.com/wp-content/uploads/2020/10/flower_drawing.png";
            let imageLocation: URL? = dir?.appending(path: "image.png");
            let url: URL? = URL(string: image);
            
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, res, error) in
                DispatchQueue.main.async {
                    if let d = data {
                        do {
                            try d.write(to: imageLocation!);
                        } catch {
                            print("ERROR IS: \(error)")
                        }
                    }
                }
            }).resume();
            
            print("IMAGE URL IS: \(imageLocation!.path)");
        } catch let error as NSError {
            print("Unable to create directory \(error.debugDescription)")
        }
        
        print("Dir Path = \(dir!)")
    }
    
    private func loadImageFromDocumentDirectory() -> UIImage {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first{
            print("WHAT IS DIR: \(dirPath)")
            let imageURL = URL(fileURLWithPath: "\(dirPath)/FOLDER_NAME").appendingPathComponent("image.png")
            let image = UIImage(contentsOfFile: imageURL.path)!;
            return image
        }
        return UIImage.init(named: "imageDefaultPlaceholder")!
    }
    
    private func image() {
        let imageView = UIImageView();
        let imageUrl = "https://www.easylinedrawing.com/wp-content/uploads/2020/10/flower_drawing.png";
        let url = URL(string: imageUrl);
                
        view.backgroundColor = .cyan;
        
        if let data = try? Data(contentsOf: url!){
            imageView.image = UIImage(data: data);
        }
        
        view.addSubview(imageView);
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true;
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
    }
}


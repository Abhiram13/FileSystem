import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fileSystem();
    }
    
    private func fileSystem() {
        let DocumentDirectory: NSURL = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let dir: URL? = DocumentDirectory.appendingPathComponent("FOLDER_NAME")
        let manager: FileManager = FileManager.default;
        
        do {
            try manager.createDirectory(atPath: dir!.path, withIntermediateDirectories: true, attributes: nil);
            let file: URL? = dir?.appending(path: "logs.txt");
//            let imageUrl: URL? = dir?.appending(path: "image.png");
            let image: String = "https://www.easylinedrawing.com/wp-content/uploads/2020/10/flower_drawing.png";
            let imageLocation: URL? = dir?.appending(path: "image.png");
            let url: URL? = URL(string: image);
            
            if let data = try? Data(contentsOf: url!) {
                try data.write(to: imageLocation!);
            }
            
            print("FILE URL IS: \(file!.path)");
            print("IMAGE URL IS: \(imageLocation!.path)");
            
            manager.createFile(atPath: file!.path, contents: nil, attributes: [FileAttributeKey.creationDate: Date()])
        } catch let error as NSError {
            print("Unable to create directory \(error.debugDescription)")
        }
        
        print("Dir Path = \(dir!)")
    }
    
    private func image() {
        let imageView = UIImageView();
        let imageUrl = "https://www.easylinedrawing.com/wp-content/uploads/2020/10/flower_drawing.png";
        let url = URL(string: imageUrl);
                
        view.backgroundColor = .cyan;
        
        if let data = try? Data(contentsOf: url!){
//            data.write(to: <#T##URL#>)
            imageView.image = UIImage(data: data);
        }
        
        view.addSubview(imageView);
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true;
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
    }
}


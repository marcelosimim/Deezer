//
//  MusicCollectionViewCell.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/31/22.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(MusicCollectionViewCell.self)"
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([imageView])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func setup(url: String) {
        let url = URL(string: url)!
        downloadImage(from: url)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 5
    }
}

extension MusicCollectionViewCell: Stylable {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
}

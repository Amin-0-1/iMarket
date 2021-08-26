//
//  AddItemVC.swift
//  iMarket
//
//  Created by Amin on 19/08/2021.
//

import UIKit
import Gallery

class AddItemVC: UIViewController {

    @IBOutlet private var uiTitle: UITextField!
    @IBOutlet private var uiPrice: UITextField!
    @IBOutlet private var uiDesc: UITextView!
    @IBOutlet var uiCollectionView: UICollectionView!
    @IBOutlet var uiEmptyImages: UIImageView!
    
    var categoryId : String!
    var presenter: AddItemPresenterInteface!
    private var itemImages :  [Data] = []{
        didSet{
            if !itemImages.isEmpty{
                uiEmptyImages.isHidden = true
                uiCollectionView.isUserInteractionEnabled = true
            }else{
                uiEmptyImages.isHidden = false
                uiCollectionView.isUserInteractionEnabled = false
            }
        }
    }
    private var gallery : GalleryController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddItemPresenter(view: self)
        configureGallery()
    }
    
    @IBAction func uiCameraBtn(_ sender: Any) {
        gallery.modalPresentationStyle = .fullScreen
        
        present(gallery, animated: true)
    }
    
    @IBAction func uiDoneBtn(_ sender: Any) {
        if isFilled(){
            dismissKeyboard()
            
           presenter.prepareItemObject(withImagesData:itemImages,categoryId: categoryId, description: uiDesc.text!, name: uiTitle.text!, price: Double(uiPrice.text!) ?? 0)
                      
        }else{
            let ac = UIAlertController(title: "missing fields", message: "Please fill in the blanks!!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    @IBAction func uiTapGestureRecognizer(_ sender: Any) {
        dismissKeyboard()
    }
    
    private func dismissKeyboard(){
        view.endEditing(true)
    }
    
    private func isFilled()->Bool{
        guard let title = uiTitle.text ,let price = uiPrice.text ,let description = uiDesc.text else { return false}

        return !title.isEmpty && !price.isEmpty && !description.isEmpty
    }
    
    private func configureGallery(){
        gallery = GalleryController()
        gallery.delegate = self
        Config.tabsToShow = [.cameraTab,.imageTab]
        Config.Camera.imageLimit = kImageLimit
    }
    
}

extension AddItemVC: GalleryControllerDelegate{
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        guard !images.isEmpty else{return}
        Image.resolve(images: images) { [weak self] (uiImages) in
            guard let self = self else { return }

            self.itemImages = uiImages.compactMap{$0?.jpegData(compressionQuality: 50)}
            self.uiCollectionView.reloadData()
        }
        self.dismiss(animated: true)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        print(video.asset.isFavorite)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        print(images.count,"weird")
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        itemImages =  controller.cart.images.isEmpty ? [] : itemImages + []
        uiCollectionView.reloadData()
        self.dismiss(animated: true)
    }
    
    
}

extension AddItemVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else {return UICollectionViewCell()}
        cell.uiImage.image = UIImage(data: itemImages[indexPath.item])

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
    }
}


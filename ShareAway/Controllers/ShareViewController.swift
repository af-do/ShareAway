//
//  ShareViewController.swift
//  ShareAway
//
//  Created by Dmitry Ovchinikov on 29/06/2022.
//

import UIKit
import FirebaseFirestore

class ShareViewController: UIViewController{
    
//    @IBOutlet weak var NewsFeedTableView: UITableView!
//
//    @IBOutlet weak var uploadPost: UIButton!
//
//    //var news = [Post]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        loadPosts()
//
//        Utilities.styleFilledButton(uploadPost)
//        let nib = UINib(nibName: "PostsTableViewCell" , bundle: nil)
//        NewsFeedTableView.register(nib, forCellReuseIdentifier: "PostsTableViewCell")
//        NewsFeedTableView.delegate = self
//        NewsFeedTableView.dataSource = self
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return news.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = NewsFeedTableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as! PostsTableViewCell
//
//        let db = Firestore.firestore()
//        db.collection("users").whereField("uid", isEqualTo: news[indexPath.row].createdByUID).getDocuments() { (snapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for d in snapshot!.documents {
//                        print("\(d.documentID) => \(d.data())")
//                        cell.profileName.text = d["name"] as? String
//                        cell.profileImage.image = LetterAvatarMaker().setUsername(d["name"] as! String).setBackgroundColors([.random()]).build()
//                        cell.profileImage.setRounded()
//                    }
//                }
//            }
//
//        cell.postDate.text = news[indexPath.row].uploadDate
//        cell.postInfo.text = news[indexPath.row].postInfo
//
//        return cell;
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //showToast(message: "You tapped \(indexPath.row)", font: UIFont.systemFont(ofSize: 14))
//
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let destination = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfilePage
//        destination.uid = news[indexPath.row].createdByUID
//        navigationController?.pushViewController(destination, animated: true)
//    }
//
//    //fetch all posts from the firestore db
//    func loadPosts(){
//        let db = Firestore.firestore().collection("posts")
//        db.addSnapshotListener{snapshot,error in
//            if let err = error {
//                debugPrint("error fetching docs: \(err)")
//            } else {
//                guard let snap = snapshot else {
//                    return
//                }
//                for d in snap.documents {
//                    let post = Post(createdByUID: d["createdByUID"] as! String, uploadDate: d["uploadDate"] as! String, postInfo: d["postInfo"] as! String)
//                    if (!self.news.contains(where: {$0.postInfo == post.postInfo})){
//                        self.news.append(post)
//                    }
//                }
//                DispatchQueue.main.async {
//                    self.NewsFeedTableView.reloadData()
//                }
//            }
//        }
//    }
    
}

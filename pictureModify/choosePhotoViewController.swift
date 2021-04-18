/*第一個畫面
選擇照片
 */

import UIKit

class choosePhotoViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var image01:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    //執行要做的事情
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image01 = info[.originalImage] as? UIImage
        //將選到的照片存入自定義資料 chooseImage裡面 等下方便傳給下一頁
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "show", sender: nil) //跳到下一頁
    }
    
    //傳資料給下一頁
    @IBSegueAction func showImage(_ coder: NSCoder) -> editViewController? {
        let controller = editViewController(coder: coder)
        controller?.enterImage = ChooseImage(chooseImage: image01)
        return controller
    }
    
    
    //點選button選擇照片
    @IBAction func openImage(_ sender: UIButton) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//修改選到圖片的地方

import UIKit


class editViewController: UIViewController {
    //準備被修改的image
    @IBOutlet weak var editImageing: UIImageView!
    //改變image大小SegmentedControl
    @IBOutlet weak var changImageSegmentedControl: UISegmentedControl!
    //背景view
    @IBOutlet weak var backgroundImageView: UIView!
    //裝旋轉功能button View
    @IBOutlet weak var spinView: UIView!
    //子功能 旋轉控制
    @IBOutlet var controlButtons: [UIButton]!
    //子功能 濾鏡
    @IBOutlet weak var filterScrollView: UIScrollView!
    
    
    var enterImage:ChooseImage!
    var count:CGFloat = 1 //鏡像數值
    var oneDegree = CGFloat.pi / 180 //左右旋轉數值
    var degreeNumber:CGFloat = 0 //翻轉次數
    var filterNumber = 0 //控制濾鏡array數量
    
    //子功能操作欄位透明度func
    func alphaController(sizeViews:CGFloat,spinViews:CGFloat,filterView:CGFloat,changeSpinView:CGFloat) {
        changImageSegmentedControl.alpha = sizeViews
        filterScrollView.alpha = filterView
        spinView.alpha = changeSpinView
        //旋轉功能欄位
        for i in 0...2{
            controlButtons[i].alpha = spinViews
        }
    }
    //濾鏡選擇func
    func chooseFilters(){
        //濾鏡種類array
        let filters = ["","CIPhotoEffectInstant", "CIPhotoEffectNoir", "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CIPhotoEffectFade", "CIPhotoEffectProcess", "CIPhotoEffectMono","CIColorInvert"]
        let ciImage = CIImage(image: enterImage.chooseImage!)
        if let filter = CIFilter(name: filters[filterNumber]){
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            if let outputImage = filter.outputImage{
                let filterImage = UIImage(ciImage: outputImage)
                editImageing.image = filterImage
            }
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //顯示前一頁傳來的照片
        editImageing.image = enterImage.chooseImage
        alphaController(sizeViews: 0, spinViews: 0, filterView: 0, changeSpinView: 0)
    }
    //UISegmentedControl改變照片大小
    @IBAction func changeImageSize(_ sender: UISegmentedControl) {
        //存讀到照片的寬高
        var imageWidth:CGFloat = 380
        var imageHeight:CGFloat = 476
        
        switch changImageSegmentedControl.selectedSegmentIndex {
        case 0:
            imageWidth = 380
            imageHeight = 476
            
        case 1:
            imageWidth = imageHeight
        case 2:
            imageHeight = imageWidth / 3 * 4
        case 3:
            imageHeight = imageWidth / 16 * 9
        default:
            break
        }
        //改變照片大小
        editImageing.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        backgroundImageView.bounds.size = CGSize(width: editImageing.bounds.width, height: editImageing.bounds.height)
        
    }
    //母功能 大小控制button
    @IBAction func changeSize(_ sender: UIButton) {
        alphaController(sizeViews: 1, spinViews: 0, filterView: 0, changeSpinView: 1)
        
    }
    //母功能 旋轉控制 button
    @IBAction func changeSpin(_ sender: Any) {
        alphaController(sizeViews: 0, spinViews: 1, filterView: 0, changeSpinView: 1)
    }
    //子功能 鏡像翻轉
    @IBAction func mirrorFlipImage(_ sender: UIButton) {
        count *= -1
        editImageing.transform = CGAffineTransform(scaleX: count, y: 1)
    }
    //子功能 相片左轉
    @IBAction func turnLeftImage(_ sender: UIButton) {
        degreeNumber += 1
        editImageing.transform = CGAffineTransform(rotationAngle: oneDegree * 90 * degreeNumber)
    }
    //子功能 相片右轉
    @IBAction func trunRightImage(_ sender: UIButton) {
        degreeNumber -= 1
        editImageing.transform = CGAffineTransform(rotationAngle: oneDegree * 90 * degreeNumber)
    }
    //母功能 開啟濾鏡調整
    @IBAction func changeFilter(_ sender: UIButton) {
        alphaController(sizeViews: 0, spinViews: 0, filterView: 1, changeSpinView: 0)
    }
    //子功能 濾鏡選擇
    @IBAction func chooseFilter(_ sender: UIButton) {
        if sender.tag == 0{
            editImageing.image = enterImage.chooseImage
        }else{
            filterNumber = sender.tag
            chooseFilters()
            print(sender.tag)
        }
    }
    
    
    //母功能 分享、儲存照片
    @IBAction func share(_ sender: UIButton) {
        let renderer = UIGraphicsImageRenderer(size: backgroundImageView.bounds.size)
        let image = renderer.image(actions: { (context) in
              backgroundImageView.drawHierarchy(in: backgroundImageView.bounds, afterScreenUpdates: true)
        })
           //分享照片
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



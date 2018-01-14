import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var mAudioPlayer: AVAudioPlayer!
    let mNames: [String] = ["ド", "ド#", "レ"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Button
    
    private func createButton(tag: Int, name: String, pos: CGPoint) -> UIButton
    {
        let btn: UIButton = UIButton()
        btn.frame = CGRect(x:pos.x, y:pos.y, width:60, height:40)
        btn.setTitle(name, for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        btn.backgroundColor = UIColor.black
        btn.tag = tag;
        btn.addTarget(self, action: #selector(ViewController.didTapButton(sender:)), for: .touchUpInside)
        
        return btn
    }
    
    private func setupButtons()
    {
        var pos = CGPoint(x: 100, y: 50)
        for (index, name) in mNames.enumerated()
        {
            let btn: UIButton = createButton(tag: index, name: name, pos: pos)
            pos.y += (btn.frame.height + 10)
            self.view.addSubview(btn)
        }
    }
    
    @objc func didTapButton(sender: UIButton)
    {
        print(sender.tag)
        
        playSound()
    }
    
    // MARK: - Sound
    
    private func playSound()
    {
        let audioPath = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Jump", ofType: "wav")!)
        do
        {
            mAudioPlayer = try AVAudioPlayer(contentsOf: audioPath as URL)
        }
        catch
        {
            print("AVAudioPlayer error")
        }
        
        mAudioPlayer.play()
    }
}


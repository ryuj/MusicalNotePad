import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var mAudioPlayer: AVAudioPlayer!
    let mNames: [String] = ["ド", "ド#", "レ", "レ#", "ミ", "ファ", "ファ#", "ソ", "ソ#", "ラ", "ラ#", "シ"]
    
    let ButtonWidth: CGFloat = 60
    let ButtonHeight: CGFloat = 40
    let ButtonHMargin: CGFloat = 10
    let ButtonVMargin: CGFloat = 10
    
    let NewLineCount: Int = 4
    
    enum Tag: Int
    {
        case text
        case buttonBase = 100
    }

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
        btn.frame = CGRect(x:pos.x, y:pos.y, width:ButtonWidth, height:ButtonHeight)
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
        for (index, name) in mNames.enumerated()
        {
            let btn: UIButton = createButton(tag: index + Tag.buttonBase.rawValue, name: name, pos: calcPos(index: index))
            self.view.addSubview(btn)
        }
    }
    
    private func calcPos(index: Int) -> CGPoint
    {
        let DefaultX = 25, DefaultY = 40
        var pos = CGPoint(x: DefaultX, y: DefaultY)
        pos.x += ((ButtonWidth + ButtonHMargin) * CGFloat(index % NewLineCount))
        pos.y += CGFloat(Int(ButtonHeight + ButtonVMargin) * (index / NewLineCount))
        
        return pos
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


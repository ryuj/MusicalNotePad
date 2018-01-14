import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var mAudioPlayer: AVAudioPlayer!
    var mLabel: UILabel!
    var mIndexList: [Int] = []
    let mNames: [String] = ["ド", "ド#", "レ", "レ#", "ミ", "ファ", "ファ#", "ソ", "ソ#", "ラ", "ラ#", "シ"]
    
    let ButtonWidth: CGFloat = 60
    let ButtonHeight: CGFloat = 40
    let ButtonHMargin: CGFloat = 10
    let ButtonVMargin: CGFloat = 10
    
    let NewLineCount: Int = 4
    
    enum Tag: Int
    {
        case buttonBase = 100
    }
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        setupDeleteButton()
        setupLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Button
    
    private func createButton(tag: Int, name: String, pos: CGPoint, selector: Selector) -> UIButton
    {
        let btn: UIButton = UIButton()
        btn.frame = CGRect(x:pos.x, y:pos.y, width:ButtonWidth, height:ButtonHeight)
        btn.setTitle(name, for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        btn.backgroundColor = UIColor.black
        btn.tag = tag;
        btn.addTarget(self, action: selector, for: .touchUpInside)
        
        return btn
    }
    
    private func setupButtons()
    {
        for (index, name) in mNames.enumerated()
        {
            let btn: UIButton = createButton(tag: index + Tag.buttonBase.rawValue,
                                             name: name,
                                             pos: calcPos(index: index),
                                             selector: #selector(ViewController.didTapButton(sender:)))
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
        playSound()
        
        let index = sender.tag - Tag.buttonBase.rawValue
        print(index)
        
        addLabel(index: index)
    }
    
    // MARK: - Delete Button
    
    private func setupDeleteButton()
    {
        let btn: UIButton = createButton(tag: 0, name: "<-", pos: CGPoint(x: 55, y: 200), selector: #selector(ViewController.didTapDeleteButton(sender:)))
        btn.backgroundColor = UIColor.blue
        self.view.addSubview(btn)
    }
    
    @objc func didTapDeleteButton(sender: UIButton)
    {
        playSound()
        
        if mIndexList.isEmpty
        {
            return
        }
        
        mIndexList.removeLast()
        refreshLabel()
    }
    
    // MARK: - Label
    
    private func setupLabel()
    {
        mLabel = UILabel()
        mLabel.frame = CGRect(x:0, y:280, width:self.view.frame.width, height:20)
        mLabel.text = ""
        mLabel.textAlignment = NSTextAlignment.center
        mLabel.layer.borderColor = UIColor.gray.cgColor
        mLabel.layer.borderWidth = 1
        
        self.view.addSubview(mLabel)
    }
    
    private func addLabel(index: Int)
    {
        mIndexList.append(index)
        mLabel.text?.append(mNames[index])
    }
    
    private func refreshLabel()
    {
        mLabel.text = ""
        
        for index in mIndexList
        {
            mLabel.text?.append(mNames[index])
        }
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



import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let label = SKLabelNode(text: "Hello World !")
    var txtchange: Bool = false
    
    override func didMove(to view: SKView) {
        label.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        label.fontSize = 45
        label.fontColor = SKColor.red
        label.fontName = "Avenir"
        label.speed = 5
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        
        let dtaporecognizer = UITapGestureRecognizer(target: self, action: #selector(doubletap))
        dtaporecognizer.numberOfTapsRequired = 2
        
        let lgpressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(lgpress))
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe_left))
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe_right))
        swipeRight.direction = .right
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch_label))
        view.addGestureRecognizer(pinch)
        
        view.addGestureRecognizer(recognizer)
        view.addGestureRecognizer(dtaporecognizer)
        view.addGestureRecognizer(lgpressRecognizer)
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        addChild(label)
    }
    
    @objc func tap(recognizer: UIGestureRecognizer) {
        let viewLocation = recognizer.location(in: view)
        let sceneLocation = convertPoint(fromView: viewLocation)
        let moveToAction = SKAction.move(to: sceneLocation, duration: 1)
        label.run(moveToAction)
    }
    
    @objc func doubletap(recognizer: UIGestureRecognizer) {
        if txtchange {
            label.text = "Hello World!"
        }
        else {
            label.text = "🚗🚕🚙🚌🚎"
        }
        txtchange = !txtchange
    }
    
    @objc func lgpress(recognizer: UIGestureRecognizer) {
        if recognizer.state == .began {
            self.backgroundColor = SKColor.init(red: CGFloat(arc4random_uniform(255)) / CGFloat(255.0),
                                                green: CGFloat(arc4random_uniform(255)) / CGFloat(255.0),
                                                blue: CGFloat(arc4random_uniform(255)) / CGFloat(255.0),
                                                alpha: 1)
        }
    }
    
    @objc func swipe_left(recognizer: UIGestureRecognizer) {
        let fadeAlpha = SKAction.fadeAlpha(by: -0.2, duration: 1)
        label.run(fadeAlpha)
    }
    
    @objc func swipe_right(recognizer: UIGestureRecognizer) {
        let fadeAlpha = SKAction.fadeAlpha(by: 0.2, duration: 1)
        label.run(fadeAlpha)
    }
    
    @objc func pinch_label(recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .began {
            print("start")
        }
        else if recognizer.state == .changed {
            let labelSize = label.fontSize
            var scale = recognizer.scale
            print(scale)
            if scale > 1 {
                scale = 1
            }
            else if scale < 1 {
                scale = -1
            }
            let labelScale = labelSize + scale
            if labelScale > 22 && labelScale < 90 {
                label.fontSize = labelScale
            }
        }
        else if recognizer.state == .ended {
            print("end")
        }
    }
}

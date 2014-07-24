import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
  // Our main scene. Everything is added to this for the playable game
  var moving: SKNode!
  
  // Our running man! Defaults to a stand still position
  var hero: SKSpriteNode! = SKSpriteNode(imageNamed: "runningman1")
  
  override func didMoveToView(view: SKView)
  {
    moving = SKNode()
    self.addChild(moving)
    
    createSky()
    createGround()
    
    hero.xScale = 0.5
    hero.yScale = 0.5
    hero.position = CGPointMake(frame.width / 2.5, frame.height / 2.75)
    
    self.addChild(hero)
    runForward()
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
  {
    for touch: AnyObject in touches
    {
      // Do jump
    }
  }
  
  func runForward()
  {
    let hero_run_anim = SKAction.animateWithTextures([
      SKTexture(imageNamed: "runningman1"),
      SKTexture(imageNamed: "runningman2"),
      SKTexture(imageNamed: "runningman3"),
      SKTexture(imageNamed: "runningman4"),
      SKTexture(imageNamed: "runningman5"),
      SKTexture(imageNamed: "runningman6"),
      SKTexture(imageNamed: "runningman7"),
      SKTexture(imageNamed: "runningman8"),
      SKTexture(imageNamed: "runningman9"),
      SKTexture(imageNamed: "runningman10"),
      SKTexture(imageNamed: "runningman11"),
      SKTexture(imageNamed: "runningman12"),
      SKTexture(imageNamed: "runningman13"),
      SKTexture(imageNamed: "runningman14")
      ], timePerFrame: 0.06)
    
    let run = SKAction.repeatActionForever(hero_run_anim)
    
    hero.runAction(run, withKey: "running")
  }
  
  func createGround()
  {
    let groundTexture = SKTexture(imageNamed: "ground")
    groundTexture.filteringMode = .Nearest
    
    let moveGroundSprite = SKAction.moveByX(-groundTexture.size().width * 2.0, y: 0, duration: NSTimeInterval(0.01 * groundTexture.size().width * 2.0))
    let resetGroundSprite = SKAction.moveByX(groundTexture.size().width * 2.0, y: 0, duration: 0.0)
    let moveGroundSpritesForever = SKAction.repeatActionForever(SKAction.sequence([moveGroundSprite, resetGroundSprite]))
    
    for var i:CGFloat = 0; i < 2.0 + self.frame.size.width / ( groundTexture.size().width * 2.0 ); ++i
    {
      let sprite = SKSpriteNode(texture: groundTexture)
      sprite.setScale(2.0)
      sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2.0)
      sprite.runAction(moveGroundSpritesForever)
      moving.addChild(sprite)
    }
  }
  
  func createSky()
  {
    let skyTexture = SKSpriteNode(color: UIColor(red: 71/255, green: 140/255, blue: 183/255, alpha: 1.0), size: frame.size)
    skyTexture.position = CGPointMake(frame.width / 2, frame.height / 2)
    moving.addChild(skyTexture)
  }
  
}
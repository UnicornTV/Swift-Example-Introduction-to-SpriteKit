import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
  // Our main scene. Everything is added to this for the playable game
  var moving: SKNode!
  
  // Our running man! Defaults to a stand still position
  let heroAtlas = SKTextureAtlas(named: "hero.atlas")
  var hero: SKSpriteNode!
  
  override func didMoveToView(view: SKView)
  {
    // setup physics
    self.physicsWorld.gravity = CGVectorMake(0.0, -2)
    
    moving = SKNode()
    self.addChild(moving)
    
    createSky()
    createGround()
    
    hero = SKSpriteNode(texture: heroAtlas.textureNamed("running1"))
    hero.xScale = 0.5
    hero.yScale = 0.5
    hero.position = CGPointMake(frame.width / 2.5, frame.height / 2.75)
    
    // Enable physics around our hero using a circle to draw our radius
    hero.physicsBody = SKPhysicsBody(circleOfRadius: hero.size.height / 2.75)
    hero.physicsBody?.dynamic = true
    
    self.addChild(hero)
    runForward()
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
  {
    for touch: AnyObject in touches
    {
      // Do jump
      let hero_jump_anim = SKAction.animateWithTextures([
        heroAtlas.textureNamed("running4"),
        heroAtlas.textureNamed("running5"),
        heroAtlas.textureNamed("running6"),
        heroAtlas.textureNamed("jumping1"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping2"),
        heroAtlas.textureNamed("jumping3")
        ], timePerFrame: 0.06)
      
      let jump = SKAction.repeatAction(hero_jump_anim, count: 1)
      
      if (hero.actionForKey("jumping") != nil)
      {
        hero.runAction(jump, withKey: "jumping")
        hero.physicsBody?.velocity = CGVectorMake(0, 0)
        hero.physicsBody?.applyImpulse(CGVectorMake(0, 280))
      }
    }
  }
  
  func runForward()
  {
    let hero_run_anim = SKAction.animateWithTextures([
      heroAtlas.textureNamed("running1"),
      heroAtlas.textureNamed("running2"),
      heroAtlas.textureNamed("running3"),
      heroAtlas.textureNamed("running4"),
      heroAtlas.textureNamed("running5"),
      heroAtlas.textureNamed("running6"),
      heroAtlas.textureNamed("running7"),
      heroAtlas.textureNamed("running8"),
      heroAtlas.textureNamed("running9"),
      heroAtlas.textureNamed("running10"),
      heroAtlas.textureNamed("running11"),
      heroAtlas.textureNamed("running12"),
      heroAtlas.textureNamed("running13"),
      heroAtlas.textureNamed("running14")
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
    
    for var i:CGFloat = 0; i < 2.0 + self.frame.size.width / (groundTexture.size().width * 2.0); ++i
    {
      let sprite = SKSpriteNode(texture: groundTexture)
      sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: groundTexture.size().width, height: groundTexture.size().height/4))
      sprite.physicsBody?.dynamic = false
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
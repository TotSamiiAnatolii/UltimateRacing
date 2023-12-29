//
//  GameRacingView.swift
//  UltimateRacing
//
//  Created by APPLE on 27.11.2023.
//

import UIKit

final class GameRacingView: UIView {
    
    //MARK: - Properties
    
    private let shapeLayer = CAShapeLayer()
    
    public let car = UIView()
        .setRoundCorners(radius: 8)
        .setColor(color: .red)
    
    private let road: UIView = UIView()
        .setStyle()
    
    private lazy var animator: UIDynamicAnimator = UIDynamicAnimator(referenceView: self)
    
    public var collider: UICollisionBehavior = UICollisionBehavior()
    
    private var gravity: UIGravityBehavior = UIGravityBehavior()
    
    private var itemBehavior: UIDynamicItemBehavior = UIDynamicItemBehavior()
    
    private var reusablePool: [ObstacleView] = []
   
    private var lastObstacleBounds: CGRect? {
        subviews
            .filter { $0 is ObstacleView && !$0.isHidden }
            .sorted { $0.frame.minY < $1.frame.minY }
            .first?
            .frame
    }
    
    private var widthCar: CGFloat {
        return AppDesign.widthCar(roadbed)
    }
    
    private var heightCar: CGFloat {
        return AppDesign.heightCar(self
        )
    }
    
    private var leftRoad: CGFloat {
        return AppDesign.leftRoad(roadbed)
    }
    
    private var rightRoad: CGFloat {
        return AppDesign.rightRoad(roadbed)
    }
    
    private var roadbed: UIView = UIView()
        .setStyle()
        .setColor(color: .gray)
    
    private var roadSideLeft: UIView = UIView()
        .setStyle()
        .setColor(color: .green)
    
    private let roadSideRight: UIView = UIView()
        .setStyle()
        .setColor(color: .green)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewHierarhies()
        setupConstraints()
        prepareComponentsForGame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawDottedLine(view: roadbed.layer)
        setupStartPositionCar()
        addGesture()
        addBoundary(collider, type: .carBoudary,
                    from: CGPoint(x: 0, y: car.frame.maxY + car.frame.height),
                    to: CGPoint(x: frame.maxX, y: car.frame.maxY + car.frame.height))
    }
    
    //MARK: - Private methods
    
    private func setViewHierarhies() {
        addSubview(roadSideLeft)
        addSubview(roadSideRight)
        addSubview(roadbed)
        roadbed.layer.addSublayer(shapeLayer)
        addSubview(car)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            roadSideLeft.topAnchor.constraint(equalTo: self.topAnchor),
            roadSideLeft.leftAnchor.constraint(equalTo: self.leftAnchor),
            roadSideLeft.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            roadSideLeft.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            roadSideRight.topAnchor.constraint(equalTo: self.topAnchor),
            roadSideRight.rightAnchor.constraint(equalTo: self.rightAnchor),
            roadSideRight.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            roadSideRight.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            roadbed.topAnchor.constraint(equalTo: self.topAnchor),
            roadbed.leftAnchor.constraint(equalTo: roadSideLeft.rightAnchor),
            roadbed.rightAnchor.constraint(equalTo: roadSideRight.leftAnchor),
            roadbed.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func prepareComponentsForGame() {
        gravity.angle = .pi / 2
        
        collider.translatesReferenceBoundsIntoBoundary = false
        collider.collisionMode = .items
        
        itemBehavior.elasticity = 0.5
        itemBehavior.friction = 0.5
        itemBehavior.allowsRotation = true
        
        animator.addBehavior(gravity)
        animator.addBehavior(collider)
        animator.addBehavior(itemBehavior)
    }
    
    private func setupStartPositionCar() {
        car.transform = CGAffineTransform.identity
        car.frame.size = CGSize(width: widthCar, height: heightCar)
        let startYPosition = frame.maxY - (car.frame.height * 2)
        car.center = CGPoint(x: rightRoad , y: startYPosition)
        collider.addItem(car)
    }
    
    private func addBoundary(_ collision: UICollisionBehavior?, type: Boundary, from: CGPoint, to: CGPoint) {
        
        guard let collision = collision else { return }
        
        collider.removeAllBoundaries()
        let identifier = type.rawValue as NSCopying
        switch type {
        case .carBoudary:
            collision.addBoundary(withIdentifier: identifier, from: from, to: to)
        case .bottomBoundary:
            collision.addBoundary(withIdentifier: identifier, from: from, to: to)
        }
    }
    
    private func drawDottedLine(view: CALayer) {
        let path = CGMutablePath()
        
        let startPoint = CGPoint(x: view.bounds.midX, y: view.bounds.minY)
        
        let endPoint = CGPoint(x: view.bounds.midX, y: view.bounds.maxY)
        
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = AppDesign.lineWidth
        shapeLayer.lineDashPattern = [AppDesign.dashSize, AppDesign.gapSize]
        shapeLayer.lineDashPhase = 40
        shapeLayer.fillRule = .evenOdd
        path.addLines(between: [startPoint, endPoint])
        shapeLayer.path = path
        animation(shapeLayer, fromValue: AppDesign.dashSize.intValue + AppDesign.gapSize.intValue, toValue: 0)
    }
    
    private func animation(_ layer: CALayer, fromValue: Int, toValue: Int) {
        let anim = CABasicAnimation(keyPath: "lineDashPhase")
        anim.fromValue = fromValue
        anim.toValue = toValue
        anim.duration = 1
        anim.repeatCount = .infinity
        layer.add(anim, forKey: nil)
    }
    
    private func addGesture() {
        let gester = UIPanGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(gester)
    }
    
    @objc func tapAction (parametr: UIPanGestureRecognizer) {
        
        if parametr.state == .changed {
            
            let translation = parametr.translation(in: roadbed)
            
            let newX = car.center.x + translation.x
            
            let newY = car.center.y
            
            if newX < car.frame.width / 2 || newX + car.frame.width / 2 > frame.width {
                return
            }
            
            car.center = CGPoint(x: newX, y: newY)
            animator.updateItem(usingCurrentState: car)
            
            parametr.setTranslation(CGPoint.zero, in: self)
        }
    }
    
    private var readyToGenerateObstacle: Bool {
        guard let lastObstacleBounds else {
            return true
        }
        
        let minimumDistanceBetweenObstacles: CGFloat = 50
        let additionalDistance = Int.random(in: 0...150)
        let result = lastObstacleBounds.minY - heightCar > minimumDistanceBetweenObstacles + CGFloat(additionalDistance)
        
        return result
    }
    
    private func dequeueObstacle() -> ObstacleView {
        if let obstacle = reusablePool.popLast() {
            return obstacle
        }
        return ObstacleView()
    }
    
    private func clearView() {
        subviews.forEach({ obstacle in
            if obstacle is ObstacleView && !obstacle.isHidden  {
                gravity.removeItem(obstacle)
                collider.removeItem(obstacle)
                itemBehavior.removeItem(obstacle)
            }
        })
    }
    
    //MARK: - Public methods
    
    public func createObstacle() {
        guard readyToGenerateObstacle else {
            return
        }
        
        let positionX = TrafficLanes.allCases.randomElement()
        let positionY = bounds.minY
        
        guard let positionX = positionX else {
            return
        }
        
        switch positionX {
        case .right:
            createObstacle(CGPoint(x: rightRoad, y: positionY))
        case .left:
            createObstacle(CGPoint(x: leftRoad, y: positionY))
        }
    }
    
    public func removeObstacle(_ view: ObstacleView) {
        view.removeFromSuperview()
        gravity.removeItem(view)
        collider.removeItem(view)
        itemBehavior.removeItem(view)
        
        reusablePool.append(view)
    }
    
    public func createObstacle(_ position: CGPoint) {
        let size: CGSize = CGSize(width: widthCar, height: heightCar)
        let view = dequeueObstacle()
        view.frame.size = size
        view.center = position
        addSubview(view)
        
        gravity.addItem(view)
        collider.addItem(view)
        itemBehavior.addItem(view)
    }
    
    public func stopGame() {
        
        shapeLayer.speed = 0
        gravity.magnitude = 0
        collider.removeItem(car)
        clearView()
    }
    
    public func repeatGame(_ settingForGame: ModelSetting) {
        subviews.forEach({ obstacle in
            if obstacle is ObstacleView  {
                obstacle.removeFromSuperview()
            }
        })
        setupStartPositionCar()
        reusablePool.removeAll()
        shapeLayer.speed = settingForGame.lavel.speed.speed
        gravity.magnitude = settingForGame.lavel.speed.magnitude
        gravity.angle = .pi / 2
    }
    
    public func changeSpeed(_ settingForGame: ModelSetting) {
        shapeLayer.speed = settingForGame.lavel.speed.speed
        gravity.magnitude = settingForGame.lavel.speed.magnitude
        gravity.angle = .pi / 2
    }
}

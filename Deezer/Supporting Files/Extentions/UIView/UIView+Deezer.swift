//
//  UIView+Deezer.swift
//  Deezer
//
//  Created by Marcelo Simim Santos on 7/30/22.
//

import UIKit

extension UIView {
    public struct ConstrainedSubviewViewOptions: OptionSet {
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public let rawValue: Int

        public static let top  = ConstrainedSubviewViewOptions(rawValue: 1 << 0)
        public static let leading = ConstrainedSubviewViewOptions(rawValue: 1 << 1)
        public static let trailing = ConstrainedSubviewViewOptions(rawValue: 1 << 2)
        public static let bottom = ConstrainedSubviewViewOptions(rawValue: 1 << 3)

        public static let all: ConstrainedSubviewViewOptions = [.top, .leading, .trailing, .bottom]
    }

    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }

    public var firstResponder: UIView? {
        guard !isFirstResponder else {
            return self
        }

        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }

        return nil
    }

    public func addConstrainedSubview(_ view: UIView,
                                      insets: UIEdgeInsets = .zero,
                                      createContraints: ConstrainedSubviewViewOptions = .all) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)

        if createContraints.contains(.leading) {
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left).isActive = true
        }
        if createContraints.contains(.trailing) {
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        }
        if createContraints.contains(.top) {
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
        }
        if createContraints.contains(.bottom) {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
        }
    }

    public func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, options: UIView.AnimationOptions = .curveEaseIn, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }

    public func fadeOut(_ duration: TimeInterval = 0.5, delay: TimeInterval = 1.0, options: UIView.AnimationOptions = .curveEaseIn, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.alpha = 0.3
        }, completion: completion)
    }

    public func fadeInOrOutWithHidden(_ hidden: Bool, duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        if hidden {
            self.fadeOut(duration, delay: delay, options: .curveLinear) { completed in
                self.isHidden = hidden
                completion?(completed)
            }
        } else {
            self.fadeIn(duration, delay: delay, options: .curveLinear) { completed in
                self.isHidden = hidden
                completion?(completed)
            }
        }
    }

    public func setRoundCornersAndShadow(cornerRadius: CGFloat = 4,
                                         shadowColor: UIColor = UIColor.black,
                                         shadowRadius: CGFloat = 0.5,
                                         shadowOpacity: Float = 0.1,
                                         shadowOffset: CGSize = CGSize(width: 0.0, height: 0.5)) {
        setRoundCorners(cornerRadius: cornerRadius)
        setShadow(shadowColor: shadowColor,
                  shadowRadius: shadowRadius,
                  shadowOpacity: shadowOpacity,
                  shadowOffset: shadowOffset)
    }

    public func setRoundCorners(cornerRadius: CGFloat = 4) {
         self.layer.cornerRadius = cornerRadius
    }

    public func setRoundCorners(cornerRadius: CGFloat = 4,
                                cornerMasks: CACornerMask = []) {
        setRoundCorners(cornerRadius: cornerRadius)
        setShadow()
        self.layer.maskedCorners = cornerMasks
    }

    public func setShadow(shadowColor: UIColor = UIColor.black,
                          shadowRadius: CGFloat = 0.5,
                          shadowOpacity: Float = 0.1,
                          shadowOffset: CGSize = CGSize(width: 0.0, height: 0.5)) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
    }

    public func setTransformRotation(toDegrees angleInDegrees: CGFloat) {
        let angleInRadians = angleInDegrees / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: angleInRadians)
        self.transform = rotation
    }

    /// Flip view horizontally.
    public func flipX() {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }

    /// Flip view vertically.
    public func flipY() {
        transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
    }

    // Convert X Coodinate to System X on view `self`
    public func getBoundsByXCoodinate(_ x: CGFloat, frameWidth: CGFloat, correctedBy correction: CGFloat) -> CGFloat {
        let minX = self.frame.minX
        let maxX = self.frame.maxX
        let visibleWidth = frameWidth / 2.0
        let leftPostionDiff = (x - visibleWidth)
        let righPositionDiff = (x + visibleWidth)
        if leftPostionDiff <= minX {
            return -leftPostionDiff + correction
        } else if righPositionDiff >= maxX {
            return -(righPositionDiff - maxX) - correction
        }
        return CGFloat(0)
    }

    public static func spaceView(height: CGFloat) -> UIView {
        let spaceView = UIView()
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        spaceView.backgroundColor = .clear
        spaceView.heightAnchor.constraint(equalToConstant: height).isActive = true
        return spaceView
    }

    public static func spaceView(width: CGFloat) -> UIView {
        let spaceView = UIView()
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        spaceView.backgroundColor = .clear
        spaceView.widthAnchor.constraint(equalToConstant: width).isActive = true
        return spaceView
    }

    public var statusBarFrame: CGRect {
        let newWindow = window ?? UIApplication.shared.windows.first { $0.isKeyWindow }
        return newWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
    }
}

// MARK: - Constraints
public extension NSLayoutConstraint {
    func off() {
        isActive = false
    }
    func on() {
        isActive = true
    }
    func toggle() {
        isActive = !isActive
    }
}

    // MARK: - addSubviews
public extension UIView {
    /// Set translatesAutoresizingMaskIntoConstraints into false automatically while adding the subviews
    @discardableResult
    func addSubviews(_ views: [UIView]) -> Self {
        for view in views {
            view.autoResizingOff()
            addSubview(view)
        }
        return self
    }

    @discardableResult
    func autoResizingOff() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

public extension UIViewController {
    func prepareViewsForLayout(_ views: [UIView]) {
        for view in views {
            view.autoResizingOff()
        }
    }
}

public extension UIView {

    // MARK: - Top, Bottom, Leading, Trailing
    @discardableResult
    func topToBottom(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: element, attribute: .bottom, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func bottomToTop(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: element, attribute: .top, multiplier: multiplier, constant: -margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func leadingToTrailing(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relation, toItem: element, attribute: .trailing, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func trailingToLeading(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: relation, toItem: element, attribute: .leading, multiplier: multiplier, constant: -margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func topToTop(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: element, attribute: .top, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func bottomToBottom(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: element, attribute: .bottom, multiplier: multiplier, constant: -margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func leadingToLeading(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relation, toItem: element, attribute: .leading, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func trailingToTrailing(of element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: relation, toItem: element, attribute: .trailing, multiplier: multiplier, constant: -margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    // MARK: - Width and Height
    @discardableResult
    func widthTo(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: self, attribute: .width, multiplier: 0, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func heightTo(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: self, attribute: .height, multiplier: 0, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func widthOf(_ element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: element, attribute: .width, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func heightOf(_ element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: element, attribute: .height, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    // MARK: - Centers
    @discardableResult
    func centerHorizontal(to element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: relation, toItem: element, attribute: .centerX, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func centerVertical(to element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: relation, toItem: element, attribute: .centerY, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func centerTo(to element: UIView, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, isActive: Bool = true) -> Self {
        centerHorizontal(to: element, relation: relation, multiplier: multiplier, priority: priority, constant: constant, isActive: isActive)
        centerVertical(to: element, relation: relation, multiplier: multiplier, priority: priority, constant: constant, isActive: isActive)
        return self
    }

    // MARK: - Aspect Ratio
    @discardableResult
    func aspectRatio(multiplier: CGFloat = 1, relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> Self {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: self, attribute: .height, multiplier: multiplier, constant: 0)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }
}

// MARK: - Individual Constraints
public extension UIView {

    func widthConstraint() -> NSLayoutConstraint? {
        constraints.first { $0.firstAttribute == NSLayoutConstraint.Attribute.width }
    }

    func heightConstraint() -> NSLayoutConstraint? {
        constraints.first { $0.firstAttribute == NSLayoutConstraint.Attribute.height }
    }

    func topConstraint() -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: NSLayoutConstraint.Attribute.top) {
                return constraint
            }
        }
        return nil
    }

    func bottomConstraint() -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: NSLayoutConstraint.Attribute.bottom) {
                return constraint
            }
        }
        return nil
    }

    func leadingConstraint() -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: NSLayoutConstraint.Attribute.leading) {
                return constraint
            }
        }
        return nil
    }

    func trailingConstraint() -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: NSLayoutConstraint.Attribute.trailing) {
                return constraint
            }
        }
        return nil
    }

    private func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
            let firstItemMatch = firstItem == self && constraint.firstAttribute == layoutAttribute
            let secondItemMatch = secondItem == self && constraint.secondAttribute == layoutAttribute
            return firstItemMatch || secondItemMatch
        }
        return false
    }
}

// MARK: - Hugging and Compression
public extension UIView {

    @discardableResult
    func setHugging(_ priority: UILayoutPriority = .required, for axis: NSLayoutConstraint.Axis) -> Self {
        setContentHuggingPriority(priority, for: axis)
        return self
    }

    @discardableResult
    func setCompressionResistance(_ priority: UILayoutPriority = .required, for axis: NSLayoutConstraint.Axis) -> Self {
        setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
}

// MARK: - Superview
public extension UIView {

    // MARK: - Width and Height Superview
    @discardableResult
    func widthToSuperview(_ margin: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        guard let superview = self.superview else {
            return self
        }
         let anchor = toSafeArea ? superview.safeAreaLayoutGuide : superview
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: anchor, attribute: .width, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func heightToSuperview(_ margin: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        guard let superview = self.superview else {
            return self
        }
        let anchor = toSafeArea ? superview.safeAreaLayoutGuide : superview
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: anchor, attribute: .height, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    // MARK: - Top, Bottom, Leading, Trailing Superview
    @discardableResult
    func topToSuperview(_ margin: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        guard let superview = self.superview else {
            return self
        }
        let anchor = toSafeArea ? superview.safeAreaLayoutGuide : superview
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: anchor, attribute: .top, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func bottomToSuperview(_ margin: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        guard let superview = self.superview else {
            return self
        }
        let anchor = toSafeArea ? superview.safeAreaLayoutGuide : superview
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: anchor, attribute: .bottom, multiplier: multiplier, constant: -margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func leadingToSuperview(_ margin: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        guard let superview = self.superview else {
            return self
        }
        let anchor = toSafeArea ? superview.safeAreaLayoutGuide : superview
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relation, toItem: anchor, attribute: .leading, multiplier: multiplier, constant: margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func trailingToSuperview(_ margin: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        guard let superview = self.superview else {
            return self
        }
        let anchor = toSafeArea ? superview.safeAreaLayoutGuide : superview
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: relation, toItem: anchor, attribute: .trailing, multiplier: multiplier, constant: -margin)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    // MARK: - Centers Superview
    @discardableResult
    func centerHorizontalToSuperView(relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        guard let superview = self.superview else {
            return self
        }
        let anchor = toSafeArea ? superview.safeAreaLayoutGuide : superview
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: relation, toItem: anchor, attribute: .centerX, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func centerVerticalToSuperView(relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        guard let superview = self.superview else {
            return self
        }
        let anchor = toSafeArea ? superview.safeAreaLayoutGuide : superview
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: relation, toItem: anchor, attribute: .centerY, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = isActive
        return self
    }

    @discardableResult
    func centerToSuperview(relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, constant: CGFloat = 0.0, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        centerHorizontalToSuperView(relation: relation, multiplier: multiplier, priority: priority, constant: constant, toSafeArea: toSafeArea, isActive: isActive)
        centerVerticalToSuperView(relation: relation, multiplier: multiplier, priority: priority, constant: constant, toSafeArea: toSafeArea, isActive: isActive)
        return self
    }

    // MARK: - Axis Superview
    @discardableResult
    func verticalToSuperview(_ margin: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        topToSuperview(margin, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        bottomToSuperview(margin, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        return self
    }

    @discardableResult
    func horizontalToSuperview(_ margin: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        leadingToSuperview(margin, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        trailingToSuperview(margin, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        return self
    }

    // MARK: - Egdes Superview
    struct LayoutEdge: OptionSet {
        public let rawValue: UInt8

        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }

        public static let top = LayoutEdge(rawValue: 1)
        public static let bottom = LayoutEdge(rawValue: 1 << 1)
        public static let trailing = LayoutEdge(rawValue: 1 << 2)
        public static let leading = LayoutEdge(rawValue: 1 << 3)
        public static let none = LayoutEdge(rawValue: 1 << 4)
    }

    @discardableResult
    func edgesToSuperView(excluding: LayoutEdge = .none, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: CGFloat = 0.0, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        if !excluding.contains(.leading) {
            leadingToSuperview(margin, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        }
        if !excluding.contains(.trailing) {
            trailingToSuperview(margin, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        }
        if !excluding.contains(.top) {
            topToSuperview(margin, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        }
        if !excluding.contains(.bottom) {
            bottomToSuperview(margin, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        }
        return self
    }

    @discardableResult
    func edgesToSuperView(excluding: LayoutEdge = .none, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, margin: UIEdgeInsets, toSafeArea: Bool = false, isActive: Bool = true) -> Self {
        if !excluding.contains(.leading) {
            leadingToSuperview(margin.left, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        }
        if !excluding.contains(.trailing) {
            trailingToSuperview(margin.right, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        }
        if !excluding.contains(.top) {
            topToSuperview(margin.top, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        }
        if !excluding.contains(.bottom) {
            bottomToSuperview(margin.bottom, relation: relation, multiplier: multiplier, priority: priority, toSafeArea: toSafeArea, isActive: isActive)
        }
        return self
    }
}


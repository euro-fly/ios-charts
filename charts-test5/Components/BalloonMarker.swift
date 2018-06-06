import Foundation
import CoreGraphics
import UIKit
import Charts


open class BalloonMarker: MarkerImage
{
    open var color: UIColor?
    open var arrowSize = CGSize(width: 15, height: 11)
    open var font: UIFont?
    open var textColor: UIColor?
    open var insets = UIEdgeInsets()
    open var minimumSize = CGSize()
    
    open var bodyWeight: String? = "0.0"
    open var bodyFat: String? = "0.0"
    
    var chartViewController: ChartViewController?
    
    
    fileprivate var label: String?
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [String : AnyObject]()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        super.init()
        
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        let size = self.size
        var point = point
        point.x -= size.width / 2.0
        point.y -= size.height
        return super.offsetForDrawing(atPoint: point)
    }
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        guard let label = label else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
//                y: 0,
                y: 0),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        context.saveGState()
        if let color = color
        {
            //context.setFillColor(color.cgColor)
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(2.0)
            context.beginPath()
            context.move(to: CGPoint(
                x: point.x + offset.x,
                y: 0.0))
            context.addLine(to: CGPoint(
                x: point.x + offset.x,
                y: UIScreen.main.bounds.height))
            context.drawPath(using: .fillStroke)
        } // TODO: draw circles through data points...?
        
        rect.origin.y += self.insets.top
        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
        //label.draw(in: CGRect(x: 50, y: 50, width: 200, height: 200), withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        let set1 = chartView?.data?.dataSets[0]
        let set2 = chartView?.data?.dataSets[1]
        let setEntry1 = set1?.entryForIndex(Int(entry.x))
        let setEntry2 = set2?.entryForIndex(Int(entry.x))
        bodyWeight = String("\(setEntry1?.y ?? 0.0)kg")
        bodyFat = String("\(setEntry2?.y ?? 0.0)%")
        setLabel(String("体量：\(setEntry1?.y ?? 0.0)kg\n 体脂肪率：\(setEntry2?.y ?? 0.0)%"))
        
        chartViewController?.updateLabel(weight: bodyWeight!, fat: bodyFat!)
    }
    
    open func getLabel() -> String? {
        return label
    }
    
    open func setLabel(_ newLabel: String)
    {
        label = newLabel
        
        _drawAttributes.removeAll()
        _drawAttributes[NSFontAttributeName] = self.font
        _drawAttributes[NSParagraphStyleAttributeName] = _paragraphStyle
        _drawAttributes[NSForegroundColorAttributeName] = self.textColor
        
        _labelSize = label?.size(attributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
}

import Foundation
import UIKit

@IBDesignable
class StartButton: UIButton {
    private let outlinedLabel = OutlinedLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        customDesign()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customDesign()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customDesign()
    }
    
    private func customDesign() {
        self.backgroundColor = UIColor.csgreen
        setTitle("", for: .normal) // ボタンのデフォルトのタイトルを空にする
        outlinedLabel.text = "はじめる"
        outlinedLabel.font = UIFont(name: "Kosugi-Regular", size: 20)
        outlinedLabel.textColor = UIColor.csblack
        outlinedLabel.outlineColor = UIColor.csWhite
        outlinedLabel.outlineWidth = 8
        outlinedLabel.textAlignment = .center
        outlinedLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(outlinedLabel)
        
        // UILabelの中央に配置するための制約を設定
        NSLayoutConstraint.activate([
            outlinedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            outlinedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            outlinedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            outlinedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        // 角を丸くする設定
        layer.cornerRadius = 10 // 適切な角の丸みの半径を設定
        clipsToBounds = true
    }
}

@IBDesignable
class NextButton: UIButton {
    private let outlinedLabel = OutlinedLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        customDesign()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customDesign()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customDesign()
    }
    
    private func customDesign() {
        self.backgroundColor = UIColor.csgreen
        setTitle("", for: .normal) // ボタンのデフォルトのタイトルを空にする
        outlinedLabel.text = "次に進む"
        outlinedLabel.font = UIFont(name: "Kosugi-Regular", size: 20)
        outlinedLabel.textColor = UIColor.csblack
        outlinedLabel.outlineColor = UIColor.csWhite
        outlinedLabel.outlineWidth = 8
        outlinedLabel.textAlignment = .center
        outlinedLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(outlinedLabel)
        
        // UILabelの中央に配置するための制約を設定
        NSLayoutConstraint.activate([
            outlinedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            outlinedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            outlinedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            outlinedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        // 角を丸くする設定
        layer.cornerRadius = 10 // 適切な角の丸みの半径を設定
        clipsToBounds = true
    }
}

@IBDesignable
class OKButton: UIButton {
	private let outlinedLabel = OutlinedLabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		customDesign()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		customDesign()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		customDesign()
	}
	
	private func customDesign() {
		self.backgroundColor = UIColor.csgreen
		setTitle("", for: .normal) // ボタンのデフォルトのタイトルを空にする
		outlinedLabel.text = "決定する"
		outlinedLabel.font = UIFont(name: "Kosugi-Regular", size: 20)
		outlinedLabel.textColor = UIColor.csblack
		outlinedLabel.outlineColor = UIColor.csWhite
		outlinedLabel.outlineWidth = 8
		outlinedLabel.textAlignment = .center
		outlinedLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(outlinedLabel)
		
		// UILabelの中央に配置するための制約を設定
		NSLayoutConstraint.activate([
			outlinedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
			outlinedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
			outlinedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
			outlinedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
		])
		
		// 角を丸くする設定
		layer.cornerRadius = 10 // 適切な角の丸みの半径を設定
		clipsToBounds = true
	}
}


@IBDesignable
class BacktoGroundButton: UIButton {
    private let outlinedLabel = OutlinedLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        customDesign()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customDesign()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customDesign()
    }
    
    private func customDesign() {
        self.backgroundColor = UIColor.csgreen
        setTitle("", for: .normal) // ボタンのデフォルトのタイトルを空にする
        outlinedLabel.text = "戻る"
        outlinedLabel.font = UIFont(name: "Kosugi-Regular", size: 20)
        outlinedLabel.textColor = UIColor.csblack
        outlinedLabel.outlineColor = UIColor.csWhite
        outlinedLabel.outlineWidth = 8
        outlinedLabel.textAlignment = .center
        outlinedLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(outlinedLabel)
        
        // UILabelの中央に配置するための制約を設定
        NSLayoutConstraint.activate([
            outlinedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            outlinedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            outlinedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            outlinedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        // 角を丸くする設定
        layer.cornerRadius = 10 // 適切な角の丸みの半径を設定
        clipsToBounds = true
    }
}



class HomeLabel: UILabel {
    private let outlinedLabel = OutlinedLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        customDesign()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customDesign()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customDesign()
    }
    
    private func customDesign() {
        outlinedLabel.translatesAutoresizingMaskIntoConstraints = false
        outlinedLabel.outlineColor = .csWhite
        outlinedLabel.textColor = .csblack
        outlinedLabel.outlineWidth = 8
        outlinedLabel.text = text
        outlinedLabel.font = UIFont(name: "Kosugi-Regular", size: 20)
        outlinedLabel.textAlignment = textAlignment
        outlinedLabel.backgroundColor = .clear
        addSubview(outlinedLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            outlinedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            outlinedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            outlinedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            outlinedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    override var text: String? {
        didSet {
            outlinedLabel.text = text
        }
    }
    
    override var font: UIFont! {
        didSet {
            outlinedLabel.font = font
        }
    }
    
    override var textAlignment: NSTextAlignment {
        didSet {
            outlinedLabel.textAlignment = textAlignment
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return outlinedLabel.intrinsicContentSize
    }
}

class OutlinedLabel: UILabel {
    var outlineColor: UIColor = .csWhite
    var outlineWidth: CGFloat = 0

    override func drawText(in rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            super.drawText(in: rect)
            return
        }

        let textColor = self.textColor

        // 外側に縁取りを描画
        context.setLineWidth(outlineWidth)
        context.setLineJoin(.round)
        context.setTextDrawingMode(.stroke)
        self.textColor = outlineColor
        super.drawText(in: rect)

        // 内側の文字を描画
        context.setTextDrawingMode(.fill)
        self.textColor = textColor
        super.drawText(in: rect)
    }
}

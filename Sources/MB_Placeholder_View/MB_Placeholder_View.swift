//
//  MB_Placeholder_View.swift
//
//  Created by BLIN Michael on 28/01/2022.
//

import Foundation
import UIKit
import SnapKit
import MB_Button

open class MB_Placeholder_View : UIView {
	
	/**
	 This class is used in order to center scrollview if needed
	 */
	private class MB_Placeholder_ScrollView: UIScrollView {

		public var isCentered:Bool = true {
			
			didSet {
				
				updateContentInset()
			}
		}
		
		public override var bounds: CGRect {
			
			didSet {
				
				updateContentInset()
			}
		}

		public override var contentSize: CGSize {
			
			didSet {
				
				updateContentInset()
			}
		}

		private func updateContentInset() {
			
			if isCentered {
				
				var top = CGFloat(0)
				var left = CGFloat(0)
				
				if contentSize.width < bounds.width {
					
					left = (bounds.width - contentSize.width) / 2
				}
				
				if contentSize.height < bounds.height {
					
					top = (bounds.height - contentSize.height) / 2
				}
				
				contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
			}
		}
	}
	
	//MARK: - Common
	/**
	 Used to set space between elements
	 - Note: Default value is `UI.Margins` (15)
	 */
	public var spacing:CGFloat = UI.Margins {
		
		didSet {
			
			stackView.spacing = spacing
		}
	}
	/**
	 Used to insert custom spacing after a specific view
	 */
	public func set(spacing:CGFloat, after view:UIView) {
		
		stackView.setCustomSpacing(spacing, after: view)
	}
	/**
	 Used to insert custom spacing before a specific view
	 */
	public func set(spacing:CGFloat, before view:UIView) {
		
		if let index = stackView.arrangedSubviews.firstIndex(of: view), index != 0 {
			
			let view = stackView.arrangedSubviews[index-1]
			stackView.setCustomSpacing(spacing, after: view)
		}
	}
	
	//MARK: - UI
	/**
	 Used to set the main image
	 */
	public var image:UIImage? {
		
		didSet {
			
			imageView.image = image
			imageView.isHidden = image == nil
		}
	}
	/**
	 Used to control the tint of the main image
	 */
	public var imageColor:UIColor? {
		
		didSet {
			
			imageView.tintColor = imageColor
		}
	}
	/**
	 Used to control the height of the main image depending on the placeholder width
	 - Note: Default value is 0.5
	 */
	public var imageHeightRatio:CGFloat = 0.5 {
		
		didSet {
			
			imageView.snp.updateConstraints { (make) in
				
				make.height.equalTo(stackView.snp.width).multipliedBy(imageHeightRatio)
			}
		}
	}
	/**
	 Used to tint the activityIndicatorView
	 */
	public var loadingColor:UIColor? {
		
		didSet {
			
			activityIndicatorView.color = loadingColor
		}
	}
	/**
	 Used to set the text of the main title
	 */
	public var title:String? {
		
		didSet {
			
			titleLabel.text = title
			titleLabel.isHidden = title?.isEmpty ?? true && attributedTitle?.string.isEmpty ?? true
		}
	}
	/**
	 Used to set the attributed text of the main title
	 */
	public var attributedTitle:NSAttributedString? {
		
		didSet {
			
			titleLabel.attributedText = attributedTitle
			titleLabel.isHidden = attributedTitle?.string.isEmpty ?? true && title?.isEmpty ?? true
		}
	}
	/**
	 Used to set the font of the main title
	 - Note: Default value is `.boldSystemFont(ofSize: Fonts.Size.Default+6)`
	 */
	public var titleFont:UIFont = .boldSystemFont(ofSize: Fonts.Size.Default+6) {
		
		didSet {
			
			titleLabel.font = titleFont
		}
	}
	/**
	 Used to set the color of the main title
	 - Note: Default value is `.darkText`
	 */
	public var titleColor:UIColor = .darkText {
		
		didSet {
			
			titleLabel.textColor = titleColor
		}
	}
	/**
	 Used to set the alignment of the main title
	 - Note: Default value is `.center`
	 */
	public var titleAlignment:NSTextAlignment = .center {
		
		didSet {
			
			titleLabel.textAlignment = titleAlignment
		}
	}
	/**
	 Used to set the text of the content
	 */
	public var content:String? {
		
		didSet {
			
			contentLabel.text = content
			contentLabel.isHidden = content?.isEmpty ?? true && attributedContent?.string.isEmpty ?? true
		}
	}
	/**
	 Used to set the attributed text of the content
	 */
	public var attributedContent:NSAttributedString? {
		
		didSet {
			
			contentLabel.attributedText = attributedContent
			contentLabel.isHidden = attributedContent?.string.isEmpty ?? true && content?.isEmpty ?? true
		}
	}
	/**
	 Used to set the font of the content
	 - Note: Default value is `.systemFont(ofSize: Fonts.Size.Default)`
	 */
	public var contentFont:UIFont = .systemFont(ofSize: Fonts.Size.Default) {
		
		didSet {
			
			contentLabel.font = contentFont
		}
	}
	/**
	 Used to set the color of the content
	 - Note: Default value is `.darkText`
	 */
	public var contentColor:UIColor = .darkText {
		
		didSet {
			
			contentLabel.textColor = contentColor
		}
	}
	/**
	 Used to set the alignment of the content
	 - Note: Default value is `.center`
	 */
	public var contentAlignment:NSTextAlignment = .center {
		
		didSet {
			
			contentLabel.textAlignment = contentAlignment
		}
	}
	/**
	 Used to set the style of the primary button
	 - Note: Default value is `.solid`
	 */
	public var primaryButtonStyle:MB_Button_Style = .solid {
		
		didSet {
			
			primaryButton.style = primaryButtonStyle
		}
	}
	/**
	 Used to set the color of the primary button
	 */
	public var primaryButtonTintColor:UIColor? {
		
		didSet {
			
			primaryButton.tintColor = primaryButtonTintColor
		}
	}
	/**
	 Used to set the title of the primary button
	 */
	public var primaryButtonTitle:String? {
		
		didSet {
			
			primaryButton.title = primaryButtonTitle
			primaryButton.isHidden = primaryButtonTitle?.isEmpty ?? true && primaryButtonImage == nil
		}
	}
	/**
	 Used to set the image of the primary button
	 */
	public var primaryButtonImage:UIImage? {
		
		didSet {
			
			primaryButton.image = primaryButtonImage
			primaryButton.isHidden = primaryButtonTitle?.isEmpty ?? true && primaryButtonImage == nil
		}
	}
	/**
	 Used to set the action of the primary button
	 */
	public var primaryButtonAction:((MB_Button?)->Void)? {
		
		didSet {
			
			primaryButton.action = primaryButtonAction
		}
	}
	/**
	 Used to set the style of the secondary button
	 - Note: Default value is `.transparent`
	 */
	public var secondaryButtonStyle:MB_Button_Style = .transparent {
		
		didSet {
			
			secondaryButton.style = secondaryButtonStyle
		}
	}
	/**
	 Used to set the color of the secondary button
	 */
	public var secondaryButtonTintColor:UIColor? {
		
		didSet {
			
			secondaryButton.tintColor = secondaryButtonTintColor
		}
	}
	/**
	 Used to set the title of the secondary button
	 */
	public var secondaryButtonTitle:String? {
		
		didSet {
			
			secondaryButton.title = secondaryButtonTitle
			secondaryButton.isHidden = secondaryButtonTitle?.isEmpty ?? true && secondaryButtonImage == nil
		}
	}
	/**
	 Used to set the image of the secondary button
	 */
	public var secondaryButtonImage:UIImage? {
		
		didSet {
			
			secondaryButton.image = secondaryButtonImage
			secondaryButton.isHidden = secondaryButtonTitle?.isEmpty ?? true && secondaryButtonImage == nil
		}
	}
	/**
	 Used to set the action of the secondary button
	 */
	public var secondaryButtonAction:((MB_Button?)->Void)? {
		
		didSet {
			
			secondaryButton.action = secondaryButtonAction
		}
	}
	/**
	 Used to insert a view after another
	 */
	public func insert(_ view:UIView, after afterView:UIView? = nil) {
		
		if let afterView = afterView {
			
			if let index = stackView.arrangedSubviews.firstIndex(of: afterView) {
			
				stackView.insertArrangedSubview(view, at: index+1)
			}
		}
		else{
			
			stackView.addArrangedSubview(view)
		}
	}
	/**
	 Used to insert a view before another
	 */
	public func insert(_ view:UIView, before beforeView:UIView? = nil) {
		
		if let beforeView = beforeView {
			
			if let index = stackView.arrangedSubviews.firstIndex(of: beforeView), index != 0 {
			
				stackView.insertArrangedSubview(view, at: index-1)
			}
		}
		else{
			
			stackView.addArrangedSubview(view)
		}
	}
	/**
	 Used to insert a view at first
	 */
	public func prepend(_ view:UIView) {
		
		stackView.insertArrangedSubview(view, at: 0)
	}
	/**
	 Used to append a view
	 */
	public func append(_ view:UIView) {
		
		stackView.addArrangedSubview(view)
	}
	
	//MARK: - States
	/**
	 Used to define if the placeholder is in loading state or not
	 - Note: Default value is `false`
	 */
	public var isLoading:Bool = false {
		
		didSet {
			
			isLoading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
		}
	}
	/**
	 Used to define of the content of the placeholder must be centered if smaller
	 - Note: Default value is `true`
	 */
	public var isCentered:Bool = true {
		
		didSet {
			
			scrollView.isCentered = isCentered
		}
	}
	
	//MARK: - Private
	
	private lazy var scrollView:MB_Placeholder_ScrollView = {
		
		let scrollView:MB_Placeholder_ScrollView = .init()
		scrollView.addSubview(stackView)
		scrollView.clipsToBounds = false
		scrollView.isCentered = isCentered
		
		stackView.snp.makeConstraints { (make) in
			
			make.leading.trailing.top.bottom.width.equalToSuperview().inset(2*UI.Margins)
		}
		
		return scrollView
	}()
	private lazy var stackView:UIStackView = {
		
		let stackView:UIStackView = .init(arrangedSubviews: [imageView,activityIndicatorView,titleLabel,contentLabel,primaryButton,secondaryButton])
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = spacing
		
		imageView.snp.makeConstraints { (make) in
			
			make.height.equalTo(stackView.snp.width).multipliedBy(imageHeightRatio)
		}
		
		return stackView
	}()
	private lazy var imageView:UIImageView = {
		
		let imageView:UIImageView = .init(image: image)
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = imageColor
		imageView.isHidden = image == nil
		return imageView
	}()
	private lazy var activityIndicatorView:UIActivityIndicatorView = {
		
		let activityIndicatorView:UIActivityIndicatorView = .init(style: .medium)
		activityIndicatorView.hidesWhenStopped = true
		activityIndicatorView.color = loadingColor
		return activityIndicatorView
	}()
	private lazy var titleLabel:UILabel = {
		
		let label:UILabel = .init()
		label.font = titleFont
		label.textColor = titleColor
		label.textAlignment = titleAlignment
		label.text = title
		label.attributedText = attributedTitle
		label.numberOfLines = 0
		label.isHidden = title?.isEmpty ?? true && attributedTitle?.string.isEmpty ?? true
		return label
	}()
	private lazy var contentLabel:UILabel = {
		
		let label:UILabel = .init()
		label.font = contentFont
		label.textColor = contentColor
		label.textAlignment = contentAlignment
		label.text = content
		label.attributedText = attributedContent
		label.numberOfLines = 0
		label.isHidden = content?.isEmpty ?? true && attributedContent?.string.isEmpty ?? true
		return label
	}()
	private lazy var primaryButton:MB_Button = {
		
		let button:MB_Button = .init(style: primaryButtonStyle, title: primaryButtonTitle, image: primaryButtonImage, andCompletion: primaryButtonAction)
		button.tintColor = primaryButtonTintColor
		button.isHidden = primaryButtonTitle?.isEmpty ?? true && primaryButtonImage == nil
		return button
	}()
	private lazy var secondaryButton:MB_Button = {
		
		let button:MB_Button = .init(style: secondaryButtonStyle, title: secondaryButtonTitle, image: secondaryButtonImage, andCompletion: secondaryButtonAction)
		button.tintColor = secondaryButtonTintColor
		button.isHidden = secondaryButtonTitle?.isEmpty ?? true && secondaryButtonImage == nil
		return button
	}()
	
	public override init(frame: CGRect) {
		
		super.init(frame: frame)
		
		addSubview(scrollView)

		scrollView.snp.makeConstraints { (make) in
			
			make.edges.equalToSuperview()
		}
		
		setUp()
	}
	
	required public init?(coder: NSCoder) {
		
		fatalError("init(coder:) has not been implemented")
	}
	
	open func setUp() {
		
		
	}
}

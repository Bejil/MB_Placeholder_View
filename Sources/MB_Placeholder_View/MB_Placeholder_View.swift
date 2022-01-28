//
//  MB_Placeholder_View.swift
//
//  Created by BLIN Michael on 28/01/2022.
//

import Foundation
import UIKit
import SnapKit
import MB_Button

public enum MB_Placeholder_View_Style {
	
	case loading
	case error
	case empty
}

open class MB_Placeholder_View : UIView {
	
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
	
	public var style:MB_Placeholder_View_Style? {
		
		didSet {
			
			updateStyle()
		}
	}
	public var error:Error? {
		
		didSet {
			
			updateStyle()
		}
	}
	
	private lazy var scrollView:MB_Placeholder_ScrollView = {
		
		let scrollView:MB_Placeholder_ScrollView = .init()
		scrollView.addSubview(stackView)
		scrollView.clipsToBounds = false
		
		stackView.snp.makeConstraints { (make) in
			
			make.leading.trailing.top.bottom.width.equalToSuperview().inset(2*UI.Margins)
		}
		
		return scrollView
	}()
	public lazy var stackView:UIStackView = {
		
		let stackView:UIStackView = .init(arrangedSubviews: [imageView,activityIndicatorView,titleLabel,contentLabel,primaryButton,secondaryButton])
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = UI.Margins
		
		imageView.snp.makeConstraints { (make) in
			
			make.height.equalTo(stackView.snp.width).multipliedBy(0.5)
		}
		
		return stackView
	}()
	public lazy var imageView:UIImageView = {
		
		let imageView:UIImageView = .init()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	private lazy var activityIndicatorView:UIActivityIndicatorView = {
		
		let activityIndicatorView:UIActivityIndicatorView = .init(style: .medium)
		activityIndicatorView.hidesWhenStopped = true
		activityIndicatorView.isHidden = true
		return activityIndicatorView
	}()
	public lazy var titleLabel:UILabel = {
		
		let label:UILabel = .init()
		label.font = .boldSystemFont(ofSize: Fonts.Size.Default+6)
		label.textColor = .darkText
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	private lazy var contentLabel:UILabel = {
		
		let label:UILabel = .init()
		label.font = .systemFont(ofSize: Fonts.Size.Default)
		label.textColor = .darkText
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	public lazy var primaryButton:MB_Button = .init()
	private lazy var secondaryButton:MB_Button = .init(style: .transparent)
	
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
	
	open func updateStyle() {
		
		if style == .loading {
			
			imageView.isHidden = true
			titleLabel.isHidden = true
			activityIndicatorView.isHidden = false
			primaryButton.isHidden = true
			secondaryButton.isHidden = true
		}
		else if style == .error {
			
			contentLabel.text = error?.localizedDescription
			secondaryButton.isHidden = true
		}
		else if style == .empty {
			
			primaryButton.isHidden = true
			secondaryButton.isHidden = true
		}
	}
}

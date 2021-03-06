import UIKit
import Parchment

class CalendarPagingCell: PagingCell {
  
  fileprivate var theme: PagingTheme?
  
  lazy var dateLabel: UILabel = {
    let dateLabel = UILabel(frame: .zero)
    dateLabel.font = UIFont.systemFont(ofSize: 20)
    return dateLabel
  }()
  
  lazy var weekdayLabel: UILabel = {
    let weekdayLabel = UILabel(frame: .zero)
    weekdayLabel.font = UIFont.systemFont(ofSize: 12)
    return weekdayLabel
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
  
  fileprivate func configure() {
    addSubview(dateLabel)
    addSubview(weekdayLabel)
    
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    weekdayLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let verticalDateLabelContraint = NSLayoutConstraint(
      item: dateLabel,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerY,
      multiplier: 1.0,
      constant: -9)
    
    let horizontalDateLabelContraint = NSLayoutConstraint(
      item: dateLabel,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerX,
      multiplier: 1.0,
      constant: 0)
    
    let verticalWeekdayLabelContraint = NSLayoutConstraint(
      item: weekdayLabel,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerY,
      multiplier: 1.0,
      constant: 12)
    
    let horizontalWeekdayLabelContraint = NSLayoutConstraint(
      item: weekdayLabel,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerX,
      multiplier: 1.0,
      constant: 0)
    
    addConstraints([
      verticalDateLabelContraint,
      horizontalDateLabelContraint,
      verticalWeekdayLabelContraint,
      horizontalWeekdayLabelContraint
    ])
  }
  
  fileprivate func updateSelectedState(selected: Bool) {
    guard let theme = theme else { return }
    if selected {
      dateLabel.textColor = theme.selectedTextColor
      weekdayLabel.textColor = theme.selectedTextColor
    } else {
      dateLabel.textColor = theme.textColor
      weekdayLabel.textColor = theme.textColor
    }
  }
  
  override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, theme: PagingTheme) {
    let calendarItem = pagingItem as! CalendarItem
    dateLabel.text = DateFormatters.dateFormatter.string(from: calendarItem.date)
    weekdayLabel.text = DateFormatters.weekdayFormatter.string(from: calendarItem.date)
    
    self.theme = theme
    updateSelectedState(selected: selected)
  }
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    guard let theme = theme else { return }

    if let attributes = layoutAttributes as? PagingCellLayoutAttributes {
      dateLabel.textColor = UIColor.interpolate(
        from: theme.textColor,
        to: theme.selectedTextColor,
        with: attributes.progress)
      
      weekdayLabel.textColor = UIColor.interpolate(
        from: theme.textColor,
        to: theme.selectedTextColor,
        with: attributes.progress)
    }
  }
  
}

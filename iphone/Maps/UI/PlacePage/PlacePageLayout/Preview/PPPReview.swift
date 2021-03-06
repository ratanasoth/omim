@objc(MWMPPPReview)
final class PPPReview: MWMTableViewCell {
  @IBOutlet private weak var ratingSummaryView: RatingSummaryView!
  @IBOutlet private weak var reviewsLabel: UILabel! {
    didSet {
      reviewsLabel.font = UIFont.regular14()
      reviewsLabel.textColor = UIColor.blackSecondaryText()
    }
  }

  @IBOutlet private weak var pricingLabel: UILabel! {
    didSet {
      pricingLabel.font = UIFont.regular14()
    }
  }

  @IBOutlet private weak var addReviewButton: UIButton! {
    didSet {
      addReviewButton.backgroundColor = UIColor.linkBlue()
      addReviewButton.setTitle("+ \(L("leave_a_review"))", for: .normal)
      addReviewButton.setTitleColor(UIColor.white, for: .normal)
      addReviewButton.titleLabel?.font = UIFont.bold12()
    }
  }

  private var onAddReview: (() -> Void)!

  @objc func config(rating: UGCRatingValueType, canAddReview: Bool, reviewsCount: UInt, priceSetter: (UILabel) -> Void, onAddReview: @escaping () -> Void) {
    self.onAddReview = onAddReview
    ratingSummaryView.textFont = UIFont.bold12()
    ratingSummaryView.value = rating.value
    ratingSummaryView.type = rating.type
    ratingSummaryView.backgroundOpacity = 0.05
    if canAddReview {
      addReviewButton.isHidden = false
      addReviewButton.layer.cornerRadius = addReviewButton.height / 2
    } else {
      addReviewButton.isHidden = true
    }
    pricingLabel.isHidden = true
    reviewsLabel.isHidden = false
    if rating.type == .noValue {
      if canAddReview {
        ratingSummaryView.noValueImage = #imageLiteral(resourceName: "ic_12px_rating_normal")
        ratingSummaryView.noValueColor = UIColor.blackSecondaryText()
        reviewsLabel.text = L("placepage_no_reviews")
      } else {
        ratingSummaryView.noValueImage = #imageLiteral(resourceName: "ic_12px_radio_on")
        ratingSummaryView.noValueColor = UIColor.linkBlue()
        reviewsLabel.text = L("placepage_reviewed")
        pricingLabel.isHidden = false
        priceSetter(pricingLabel)
      }
    } else {
      ratingSummaryView.defaultConfig()

      if reviewsCount > 0 {
        reviewsLabel.text = String(coreFormat: L("placepage_summary_rating_description"), arguments: [reviewsCount])
        reviewsLabel.isHidden = false
      } else {
        reviewsLabel.text = ""
        reviewsLabel.isHidden = true
      }
      pricingLabel.isHidden = false
      priceSetter(pricingLabel)
    }
  }

  @IBAction private func addReview() {
    onAddReview()
  }
}

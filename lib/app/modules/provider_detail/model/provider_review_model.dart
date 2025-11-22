
class ProviderReviewData {
  final int providerId;
  final int totalReviews;
  final double averageRating;
  final List<Rating> ratings;
  final List<Review> lstReviews;

  ProviderReviewData({
    required this.providerId,
    required this.totalReviews,
    required this.averageRating,
    required this.ratings,
    required this.lstReviews,
  });

  factory ProviderReviewData.fromJson(Map<String, dynamic> json) {
    return ProviderReviewData(
      providerId: json['provider_id'],
      totalReviews: json['total_reviews'],
      averageRating: (json['average_rating'] as num).toDouble(),
      ratings: (json['ratings'] as List)
          .map((item) => Rating.fromJson(item))
          .toList(),
      lstReviews: (json['lstReviews'] as List)
          .map((item) => Review.fromJson(item))
          .toList(),
    );
  }
}

class Rating {
  final String label;
  final int count;
  final String color;

  Rating({
    required this.label,
    required this.count,
    required this.color,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      label: json['label'],
      count: json['count'],
      color: json['color'],
    );
  }
}

class Review {
  final int reviewId;
  final int providerId;
  final int customerId;
  final String customerName;
  final double rating;
  final int approvalStatus;
  final String reviewTitle;
  final String reviewContent;
  final DateTime reviewDate;

  Review({
    required this.reviewId,
    required this.providerId,
    required this.customerId,
    required this.customerName,
    required this.rating,
    required this.approvalStatus,
    required this.reviewTitle,
    required this.reviewContent,
    required this.reviewDate,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewId: json['review_id'],
      providerId: json['provider_id'],
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      rating: (json['rating'] as num).toDouble(),
      approvalStatus: json['approval_status'],
      reviewTitle: json['review_title'],
      reviewContent: json['review_content'],
      reviewDate: DateTime.parse(json['review_date']),
    );
  }
}
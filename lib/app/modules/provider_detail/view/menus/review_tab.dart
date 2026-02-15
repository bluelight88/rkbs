import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/custom/shimmer_widget.dart';
import 'package:timoraa/app/modules/provider_detail/model/provider_review_model.dart';
import 'package:timoraa/app/modules/provider_detail/view_model/provider_reviews/provider_reviews_bloc.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';

class ReviewTab extends StatelessWidget {
  final int providerId;
  const ReviewTab({required this.providerId, super.key});

  String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) return "1 Day Ago";
    if (difference.inDays < 30) return "${difference.inDays} Days Ago";

    final months = (difference.inDays / 30).floor();
    return "$months Month${months > 1 ? 's' : ''} Ago";
  }

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProviderReviewsBloc()..add(FetchProviderReview(providerId: providerId)),
      child: BlocBuilder<ProviderReviewsBloc, ProviderReviewsState>(
        builder: (context, state) {
          if (state is ProviderReviewLoading) {
            return _buildSkeleton(context);
          }

          if (state is ProviderReviewFailure) {
            return SliverToBoxAdapter(
              child: Container(
                color: ColorConstants.whiteColor,
                height: MediaQuery.of(context).size.height * 0.6,
                alignment: Alignment.center,
                child: const Text(
                  "No reviews found.",
                  style: TextStyle(color: ColorConstants.primaryColor, fontSize: 16, fontFamily: "PlusJakartaSans"),
                ),
              ),
            );
          }

          if (state is ProviderReviewSuccess) {
            final providerReviewModel = state.providerReviewmodel;

            if (providerReviewModel.lstReviews.isEmpty) {
              return SliverToBoxAdapter(
                child: Container(
                  color: ColorConstants.whiteColor,
                  height: MediaQuery.of(context).size.height * 0.6,
                  alignment: Alignment.center,
                  child: const Text(
                    "No reviews found.",
                    style: TextStyle(
                      color: ColorConstants.primaryColor,
                      fontSize: 16,
                      fontFamily: "PlusJakartaSans",
                    ),
                  ),
                ),
              );
            }

            final averageRating = providerReviewModel.averageRating;
            final totalReviews = providerReviewModel.totalReviews;
            final List<Rating> ratings = providerReviewModel.ratings;
            final List<Review> reviews = providerReviewModel.lstReviews;

            return SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  decoration: const BoxDecoration(color: ColorConstants.whiteColor),
                  child: Column(
                    children: [
                      const Gap(20),
                      Center(
                        child: Text(
                          averageRating.toString(),
                          style: const TextStyle(
                            fontSize: 47,
                            fontWeight: FontWeight.w800,
                            fontFamily: "PlusJakartaSans",
                          ),
                        ),
                      ),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star_rounded,
                            color: index < averageRating.floor()
                                ? Colors.amber
                                : Colors.grey.shade300,
                            size: 20,
                          ),
                        ),
                      ),
                      const Gap(5),
                      Center(
                        child: Opacity(
                          opacity: 0.7,
                          child: Text(
                            "based on $totalReviews reviews",
                            style: const TextStyle(
                              color: ColorConstants.primaryColor,
                              fontFamily: "PlusJakartaSans",
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: ratings.map((rating) {
                            final percent = rating.count / totalReviews;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Text(
                                        rating.label,
                                        style: const TextStyle(
                                          color: ColorConstants.primaryColor,
                                          fontFamily: "PlusJakartaSans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: percent,
                                      color: hexToColor(rating.color),
                                      backgroundColor: Colors.grey.shade200,
                                      minHeight: 6,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const Divider(
                        height: 30,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: reviews.map((review) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'https://i.pravatar.cc/150?img=${review.reviewId}',
                                          height: 54,
                                          width: 54,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  review.customerName,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    fontFamily: "PlusJakartaSans",
                                                  ),
                                                ),
                                                Opacity(
                                                  opacity: 0.50,
                                                  child: Text(
                                                    timeAgo(review.reviewDate),
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: ColorConstants.primaryColor,
                                                      fontFamily: "PlusJakartaSans",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: List.generate(
                                                5,
                                                (i) => Icon(
                                                  Icons.star_rounded,
                                                  size: 16,
                                                  color: i < review.rating
                                                      ? Colors.amber
                                                      : Colors.grey.shade300,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(5),
                                  Opacity(
                                    opacity: 0.7,
                                    child: Text(
                                      review.reviewContent,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "PlusJakartaSans",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const Gap(100),
                    ],
                  ),
                ),
              ]),
            );
          }

          return _buildSkeleton(context);
        },
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          color: ColorConstants.whiteColor,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const ShimmerWidget.rectangular(width: 80, height: 60),
              const Gap(10),
              const ShimmerWidget.rectangular(width: 120, height: 20),
              const Gap(10),
              const ShimmerWidget.rectangular(width: 150, height: 15),
              const Gap(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: List.generate(
                    4,
                    (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          ShimmerWidget.rectangular(width: 60, height: 12),
                          Gap(10),
                          Expanded(child: ShimmerWidget.rectangular(height: 8)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(height: 40, thickness: 1, indent: 20, endIndent: 20),
              Column(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            ShimmerWidget.circular(width: 50, height: 50),
                            Gap(15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShimmerWidget.rectangular(width: 120, height: 15),
                                  Gap(8),
                                  ShimmerWidget.rectangular(width: 80, height: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(15),
                        const ShimmerWidget.rectangular(height: 12),
                        const Gap(8),
                        ShimmerWidget.rectangular(height: 12, width: MediaQuery.of(context).size.width * 0.6),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

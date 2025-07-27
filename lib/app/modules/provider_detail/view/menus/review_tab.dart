import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';

import '../../model/provider_detail_model.dart';

class ReviewTab extends StatelessWidget {
  final ProviderDetailModel providerDetailModel;
  const ReviewTab({required this.providerDetailModel, super.key});

  final double averageRating = 4.9;
  final int totalReviews = 23;

  final List<Map<String, dynamic>> ratings = const [
    {"label": "Excellent", "count": 15, "color": Colors.green},
    {"label": "Good", "count": 5, "color": Colors.lightGreen},
    {"label": "Average", "count": 2, "color": Colors.amber},
    {"label": "Poor", "count": 1, "color": Colors.red},
  ];

  final List<Map<String, dynamic>> reviews = const [
    {
      "name": "John Parker",
      "rating": 5.0,
      "date": "2025-07-22",
      "image": "https://i.pravatar.cc/150?img=1",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magna",
    },
    {
      "name": "Jane Doe",
      "rating": 4.0,
      "date": "2025-06-20",
      "image": "https://i.pravatar.cc/150?img=2",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magna",
    },
    {
      "name": "John Parker",
      "rating": 5.0,
      "date": "2025-07-22",
      "image": "https://i.pravatar.cc/150?img=1",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magna",
    },
    {
      "name": "Jane Doe",
      "rating": 4.0,
      "date": "2025-06-20",
      "image": "https://i.pravatar.cc/150?img=2",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magna",
    },
    {
      "name": "John Parker",
      "rating": 5.0,
      "date": "2025-07-22",
      "image": "https://i.pravatar.cc/150?img=1",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magna",
    },
    {
      "name": "Jane Doe",
      "rating": 4.0,
      "date": "2025-06-20",
      "image": "https://i.pravatar.cc/150?img=2",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magna",
    },
    {
      "name": "John Parker",
      "rating": 5.0,
      "date": "2025-07-22",
      "image": "https://i.pravatar.cc/150?img=1",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magna",
    },
    {
      "name": "Jane Doe",
      "rating": 4.0,
      "date": "2025-06-20",
      "image": "https://i.pravatar.cc/150?img=2",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magna",
    },
    {
      "name": "John Parker",
      "rating": 5.0,
      "date": "2025-07-22",
      "image": "https://i.pravatar.cc/150?img=1",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magna",
    },
    {
      "name": "Jane Doe",
      "rating": 4.0,
      "date": "2025-06-20",
      "image": "https://i.pravatar.cc/150?img=2",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magna",
    },
    {
      "name": "Jane Doe",
      "rating": 4.0,
      "date": "2025-06-20",
      "image": "https://i.pravatar.cc/150?img=2",
      "text": "Good work, but there's room for improvement.",
    },
  ];

  String timeAgo(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays == 0) return "1 Day Ago";
    if (difference.inDays < 30) return "${difference.inDays} Days Ago";
    final months = (difference.inDays / 30).floor();
    return "$months Month${months > 1 ? 's' : ''} Ago";
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          decoration: BoxDecoration(color: ColorConstants.whiteColor),
          // padding: EdgeInsets.symmetric(horizontal: 620),
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
                    color:
                        index < averageRating.floor()
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
                    style: TextStyle(
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
                  children:
                      ratings.map((rating) {
                        final percent = rating['count'] / totalReviews;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                                child: Opacity(
                                  opacity: 0.5,
                                  child: Text(
                                    rating['label'],
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
                                  color: rating['color'],
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
                  children:
                      reviews.map((review) {
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
                                      review['image'],
                                      height: 54,
                                      width: 54,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              review['name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                fontFamily: "PlusJakartaSans",
                                              ),
                                            ),
                                            Opacity(
                                              opacity: 0.50,
                                              child: Text(
                                                timeAgo(review['date']),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      ColorConstants
                                                          .primaryColor,
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
                                              color:
                                                  i < review['rating']
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
                              Gap(5),
                              Opacity(
                                opacity: 0.7,
                                child: Text(
                                  review['text'],
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
}

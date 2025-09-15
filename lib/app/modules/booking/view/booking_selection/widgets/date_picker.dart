import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final VoidCallback callback;
  final ValueNotifier<DateTime> selectedDate;

  const CustomDatePicker({
    super.key,
    required this.callback,
    required this.selectedDate,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final ScrollController _scrollController = ScrollController();

  List<DateTime> getMonthDates(DateTime month) {
    final last = DateTime(month.year, month.month + 1, 0);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    List<DateTime> allDates = [];
    for (int i = 1; i <= last.day; i++) {
      final date = DateTime(month.year, month.month, i);
      if (date.isAtSameMomentAs(today) || date.isAfter(today)) {
        allDates.add(date);
      }
    }

    return allDates;
  }

  DateTime _displayMonth = DateTime.now();

  void _changeMonth(int delta) {
    final newMonth = DateTime(
      _displayMonth.year,
      _displayMonth.month + delta,
      1,
    );
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastDayOfNewMonth = DateTime(newMonth.year, newMonth.month + 1, 0);
    if (lastDayOfNewMonth.isAtSameMomentAs(today) ||
        lastDayOfNewMonth.isAfter(today)) {
      setState(() {
        _displayMonth = newMonth;
      });
    }
  }

  void _scrollToDate(DateTime targetDate) {
    final dates = getMonthDates(_displayMonth);
    final index = dates.indexWhere((d) => DateUtils.isSameDay(d, targetDate));

    if (index != -1 && _scrollController.hasClients) {
      final itemWidth = 70.0;
      final screenWidth = MediaQuery.of(context).size.width;
      final targetOffset =
          (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

      _scrollController.animateTo(
        targetOffset.clamp(0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleDateTap(DateTime date) {
    final now = DateTime.now();
    final normalizedToday = DateTime(now.year, now.month, now.day);
    final normalizedTap = DateTime(date.year, date.month, date.day);

    if (DateUtils.isSameDay(normalizedTap, normalizedToday)) {
      setState(() {
        widget.selectedDate.value = now;
      });
    } else {
      setState(() {
        widget.selectedDate.value = normalizedTap;
      });
    }
    widget.callback();
  }

  @override
  void initState() {
    _displayMonth = DateTime(
      widget.selectedDate.value.year,
      widget.selectedDate.value.month,
      1,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToDate(widget.selectedDate.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> dates = getMonthDates(_displayMonth);
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month, 1);
    final displayMonthStart = DateTime(
      _displayMonth.year,
      _displayMonth.month,
      1,
    );
    final canGoBack = displayMonthStart.isAfter(currentMonth);

    return Container(
      color: Colors.black,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color:
                        canGoBack
                            ? const Color(0xff272727)
                            : const Color(0xff1a1a1a),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: canGoBack ? () => _changeMonth(-1) : null,
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: canGoBack ? Colors.white : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      DateFormat('MMMM').format(_displayMonth).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "PlusJakartaSans",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      _displayMonth.year.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: "PlusJakartaSans",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xff272727),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () => _changeMonth(1),
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Horizontal Date Selector
          SizedBox(
            height: 65,
            child:
                dates.isEmpty
                    ? const Center(
                      child: Text(
                        'No available dates',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                    : ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: dates.length,
                      separatorBuilder: (_, __) => const Gap(10),
                      itemBuilder: (context, index) {
                        final date = dates[index];
                        final isSelected = DateUtils.isSameDay(
                          date,
                          widget.selectedDate.value,
                        );

                        return GestureDetector(
                          onTap: () => _handleDateTap(date),
                          child: Container(
                            width: 60,
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Colors.white
                                      : const Color(0xFF1F1F1F),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xff000000),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors.black
                                            : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "PlusJakartaSans",
                                    fontSize: 19,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat('EEE').format(date).toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: "PlusJakartaSans",
                                    color:
                                        isSelected
                                            ? Colors.black
                                            : Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

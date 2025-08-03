import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  List<DateTime> getMonthDates(DateTime month) {
    final first = DateTime(month.year, month.month, 1);
    final last = DateTime(month.year, month.month + 1, 0);
    return List.generate(last.day, (i) => first.add(Duration(days: i)));
  }

  void _changeMonth(int delta) {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month + delta,
        1,
      );
    });
  }

  void _scrollToDate(DateTime targetDate) {
    final dates = getMonthDates(_selectedDate);
    final index = dates.indexWhere((d) => DateUtils.isSameDay(d, targetDate));

    if (index != -1 && _scrollController.hasClients) {
      _scrollController.animateTo(
        index * 87.0, // 75 width + 12 spacing
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleDateTap(DateTime date) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final normalizedTap = DateTime(date.year, date.month, date.day);

    if (normalizedTap.isBefore(normalizedToday)) {
      setState(() {
        _selectedDate = normalizedToday;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToDate(normalizedToday);
      });
    } else {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> dates = getMonthDates(_selectedDate);

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
                  decoration: const BoxDecoration(
                    color: Color(0xff272727),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () => _changeMonth(-1),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      DateFormat('MMMM').format(_selectedDate).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "PlusJakartaSans",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      _selectedDate.year.toString(),
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
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: dates.length,
              separatorBuilder: (_, __) => const Gap(10),
              itemBuilder: (context, index) {
                final date = dates[index];
                final isSelected = DateUtils.isSameDay(date, _selectedDate);

                return GestureDetector(
                  onTap: () => _handleDateTap(date),
                  child: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color:
                          isSelected ? Colors.white : const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xff000000)),
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
                            color: isSelected ? Colors.black : Colors.white,
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
                            color: isSelected ? Colors.black : Colors.white70,
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

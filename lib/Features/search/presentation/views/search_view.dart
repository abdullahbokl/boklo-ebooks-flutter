import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/custom_circular_indicator.dart';
import '../../../../core/shared/widgets/custom_error_widget.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/styles.dart';
import '../manager/search_cubit/search_cubit.dart';
import '../widgets/custom_search_text_field.dart';
import '../widgets/search_result_list_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    context.read<SearchCubit>().fetchBooksBySearchQuery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.widthCalculator(15)),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: AppDimensions.heightCalculator(20)),
                    const CustomSearchTextField(),
                    SizedBox(height: AppDimensions.heightCalculator(15)),
                    Text(
                      'Search Result',
                      style: AppStyles.textStyle18,
                    ),
                    SizedBox(height: AppDimensions.heightCalculator(15)),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const CustomCircularIndicator();
                    } else if (state is SearchFailure) {
                      return CustomErrorWidget(errorMessage: state.errMessage);
                    } else if (state is SearchSuccess &&
                        state.books.isNotEmpty) {
                      return SearchResultListView(books: state.books);
                    } else {
                      return const CustomErrorWidget(
                        errorMessage: 'No result found',
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

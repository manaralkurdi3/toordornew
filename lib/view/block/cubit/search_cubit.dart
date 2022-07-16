import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/new_url_links.dart';
import '../../../model/search_model.dart';
import '../../../network/remote/api_request.dart';
import 'package:toordor/view/block/state/Search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  Future<void> search({
    String? mobileNumber,
  }) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    emit(SearchLoading());
    ApiRequest.postData(data: {
      "phone": mobileNumber,
    }, path: ApiLinks.search, token: _token)
        .then((value) {
      if (value.statusCode == 200) {
        SearchModel search = SearchModel.fromJson(value.data);

        emit(SearchSuccess(search));
      }
    }).catchError((Error) {
      emit(SearchError("الرجاء التحقق من البيانات"));
    });
  }
}

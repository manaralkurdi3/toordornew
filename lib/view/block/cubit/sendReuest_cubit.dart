import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/view/block/state/sendRequest_satate.dart';

import '../../../const/new_url_links.dart';
import '../../../network/remote/api_request.dart';

class SendRequestCubit extends Cubit<SendRequestState> {
  SendRequestCubit() : super(SendRequestInitial());

  static SendRequestCubit get(context) => BlocProvider.of(context);

  Future<void> sendRequest({
    String? userId,
  }) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    emit(SendRequestLoading());
    ApiRequest.postData(data: {
      // {"user_id":"4","service_id":"1","message":"Hello, Want To Join Us!","specialization":"Driver"}
      "user_id": userId,
      "user_id": '1',
      "user_id": 'Hello, Want To Join Us!',
      "user_id": 'Driver',
    }, path: ApiLinks.sendRequest, token: _token)
        .then((value) {
      if (value.statusCode == 200) {
        emit(SendRequestSuccess());
      }
    }).catchError((Error) {
      emit(SendRequestError("الرجاء التحقق من البيانات"));
    });
  }
}

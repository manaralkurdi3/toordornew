import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toordor/Controller/size.dart';
import 'package:toordor/view/block/cubit/search_cubit.dart';
import 'package:toordor/view/block/cubit/sendReuest_cubit.dart';
//import 'package:toordor/View/block/cubit/search_cubit.dart';
import 'package:toordor/model/search_model.dart';
import 'package:toordor/view/block/state/Search_state.dart';
import 'package:toordor/view/screen/my_work_place.dart';
import 'package:toordor/view/widget/slide_page_transitions.dart';

import 'package:toordor/view/block/state/sendRequest_satate.dart';

class MyEmployees extends StatelessWidget {
  MyEmployees({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String query = '';
    var searchController = TextEditingController();
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: searchController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "يحب ادخل النص";
                      }
                    },
                    onFieldSubmitted: (String text) {
                      SearchCubit.get(context)
                          .search(mobileNumber: searchController.text);
                    },
                    decoration: InputDecoration(
                      enabled: true,
                      hintText: '"يرجي ادخال رقم الهاتف"البحث عن هويه',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      suffixIcon: InkWell(
                        onTap: () {
                          searchController.clear();
                        },
                        child: const Icon(Icons.close),
                      ),
                      prefixIcon: InkWell(
                        onTap: () {
                          SearchCubit.get(context)
                              .search(mobileNumber: searchController.text);
                        },
                        child: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),

                BlocConsumer<SearchCubit, SearchState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is SearchSuccess) {
                        return SearchResult(
                            serachData: state.searchModel, query: query);
                      }
                      if (state is SearchError) {
                        return Text(state.error);
                      } else {
                        return Text('"يرجي ادخال رقم الهاتف"البحث عن هويه');
                      }
                    }),

                Divider(height: 2),

                // FutureBuilder(
                //   future: Controller.fetchTreatsTypes(context),
                //   builder: (context, snapshot) {
                //     return const SizedBox();
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, required this.query, required this.serachData})
      : super(key: key);

  final String query;
  final SearchModel serachData;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SendRequestCubit, SendRequestState>(
      listener: (context, state) {
        if (state is SendRequestSuccess) {
          pushSlide(context,
              screen: MyWorkPlace(
                userId: serachData.message!.id.toString(),
              ));
        }
      },
      child: SizedBox(
        height: MySize.height(context) / 3,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: serachData.success!
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            //employee name
                            Text(
                              serachData.message!.fullname!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    SendRequestCubit.get(context).sendRequest(
                                        userId:
                                            serachData.message!.id!.toString());
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blue[300],
                                    ),
                                    child: Text(
                                      'Send a request',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                //employee id
                                Text(
                                  'ID ${serachData.message!.phone}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    'برجاء التحقق من رقم لهاتف ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

Widget employCard(BuildContext context,
        {required String name, required String id}) =>
    Container(
      margin: EdgeInsets.all(9),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(77)),
      width: MySize.width(context) / 1.2,
      height: MySize.height(context) / 5,
      child: Card(
        elevation: 19,
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [Text('الاسم: $name'), Text("رقم الهويه: $id")],
              ),
              ElevatedButton(onPressed: () {}, child: Text('مسح'))
            ],
          ),
        ),
      ),
    );

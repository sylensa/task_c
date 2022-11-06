import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:task_c/controller/medical_article_controller.dart';
import 'package:task_c/helper/helper.dart';
import 'package:task_c/model/medical_article_model.dart';
import 'package:task_c/view/articles/articles_details.dart';
import 'package:task_c/view/widgets/multi_purpose_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  DateTime? dateFrom;
  DateTime? dateTo;
  bool progressCode= true;
  late AppLifecycleState appLifecycle;
  List<MedicalArticleModel> listAllMedicalArticleModels = [];
  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime(2021, 8, 10),
    DateTime(2021, 8, 13),
  ];
  RefreshController _refreshController =  RefreshController(initialRefresh: false);
  void _onRefresh() async{
    getMedicalArticles();
    if(mounted){
      setState(() {

      });
    }
    _refreshController.refreshCompleted();
  }
  void _onLoading() async{
    getMedicalArticles(onLoading: true);
    if(mounted){
      setState(() {

      });
    }
    _refreshController.loadComplete();
  }

  String _getValueText(CalendarDatePicker2Type datePickerType, List<DateTime?> values,) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  getMedicalArticles({bool onLoading = false})async{
    List<MedicalArticleModel> articles  =  await MedicalArticleController().getMedicalArticle();
    if(onLoading){
      listAllMedicalArticleModels.addAll(articles);
    }else{
      listAllMedicalArticleModels.insertAll(0,articles);

    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMedicalArticles();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: sText("Medical Articles",color: Colors.white,weight: FontWeight.bold,size: 20),
        elevation: 0,

      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Autocomplete<MedicalArticleModel>(

                      optionsBuilder: (textEditing) {
                        if (textEditing.text.isEmpty) {
                          return const Iterable<MedicalArticleModel>.empty();
                        }
                        return listAllMedicalArticleModels.where(
                              (element) =>
                          element.name!.toLowerCase().contains(
                            textEditing.text.toLowerCase(),
                          ) ||
                              element.name!.toLowerCase().contains(
                                textEditing.text.toLowerCase(),
                              ),
                        );
                      },
                      displayStringForOption: (stockReport) => stockReport.name!,
                      onSelected: (selected) {
                        goTo(context, ArticlesDetails(medicalArticleModel: selected,));
                      },
                      fieldViewBuilder:
                          (context, controller, node, onSubmit) {
                        return TextFormField(
                          controller: controller,
                          autovalidateMode: AutovalidateMode.always,
                          onFieldSubmitted: (value) {
                            onSubmit();
                          },
                          focusNode: node,
                          decoration: textDecorSuffix(
                              size: 15,
                              icon: Icon(Icons.search,color: Colors.grey),
                              suffIcon:IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: ()async{
                                final config = CalendarDatePicker2WithActionButtonsConfig(
                                  calendarType: CalendarDatePicker2Type.range,
                                  selectedDayHighlightColor: Colors.purple[800],
                                  shouldCloseDialogAfterCancelTapped: true,
                                );
                                final values = await showCalendarDatePicker2Dialog(
                                  context: context,
                                  config: config,
                                  dialogSize: const Size(325, 400),
                                  borderRadius: BorderRadius.circular(15),
                                  initialValue: _dialogCalendarPickerValue,
                                  dialogBackgroundColor: Colors.white,
                                  selectableDayPredicate: (day) => !day
                                      .difference(_dialogCalendarPickerValue[0]!
                                      .subtract(const Duration(days: 5)))
                                      .isNegative,
                                );
                                if (values != null) {
                                  // ignore: avoid_print
                                  print(_getValueText(config.calendarType, values,));
                                  setState(() {
                                    _dialogCalendarPickerValue = values;
                                  });

                                  print("values:${values.first}");
                                  print("values:${values.last}");
                                }

                              }, icon:  Icon(Icons.filter_alt,color: Colors.grey,),),
                              label: "Searching",
                              enabled: true,
                              showBorder: true
                          ),
                        );
                      },
                    )
                ),

              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: SmartRefresher(
                reverse: false,
                enablePullDown: true,
                enablePullUp: true,
                footer: CustomFooter(
                  builder: (BuildContext context,LoadStatus? mode){
                    Widget body ;
                    if(mode==LoadStatus.idle){
                      body =  Text("No more Data");
                    }
                    else if(mode==LoadStatus.loading){
                      body =  CircularProgressIndicator.adaptive();
                    }
                    else if(mode == LoadStatus.failed){
                      body = Text("Load Failed!Click retry!");
                    }
                    else if(mode == LoadStatus.canLoading){
                      body = Text("release to load more");
                    }
                    else{
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child:body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                    itemCount: listAllMedicalArticleModels.length,
                    itemBuilder: (BuildContext context, int index){
                      return  Column(
                        children: [
                          MultiPurposeCourseCard(
                            title: listAllMedicalArticleModels[index].name!,
                            subTitle: listAllMedicalArticleModels[index].date!,
                            onTap: (){
                              goTo(context, ArticlesDetails(medicalArticleModel: listAllMedicalArticleModels[index],));
                            },
                          ),
                          SizedBox(height: 20,)
                        ],
                      );
                    }),
              ),
            )


          ],
        ),
      ),
    );
  }
}

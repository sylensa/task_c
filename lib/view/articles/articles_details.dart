import 'package:flutter/material.dart';
import 'package:task_c/helper/helper.dart';
import 'package:task_c/model/medical_article_model.dart';

class ArticlesDetails extends StatefulWidget {
   ArticlesDetails({Key? key,required this.medicalArticleModel}) : super(key: key);
   MedicalArticleModel medicalArticleModel;
  @override
  State<ArticlesDetails> createState() => _ArticlesDetailsState();
}

class _ArticlesDetailsState extends State<ArticlesDetails> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: sText("${properCase(widget.medicalArticleModel.name!)}",color: Colors.white,size: 16,weight: FontWeight.bold),
        elevation: 0,
        centerTitle: true,
      ) ,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 10,),
              sText(widget.medicalArticleModel.description,lHeight: 2,maxLines: 100),
              sText(widget.medicalArticleModel.date,lHeight: 2,maxLines: 100,color: Colors.blue),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
